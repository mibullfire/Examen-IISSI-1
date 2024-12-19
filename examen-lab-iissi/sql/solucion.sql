/* Respuestas al examen de laboratorio.
** Nombre del alumno: 
** Grupo al que pertenece:
*/

-- A continuación debe escribir el código SQL que da solución a las cuestiones planteadas
-- puede añadir todos los comentarios que estime oportuno

DROP TABLE IF EXISTS Concursos;

CREATE TABLE IF NOT EXISTS Concursos (
	concursoID INT NOT NULL AUTO_INCREMENT,
	videojuegoID INT NOT NULL,
	nombre VARCHAR(60) NOT NULL,
	premio DOUBLE NOT NULL,
	fecha DATE NOT NULL,
	-- Claves
	PRIMARY KEY (concursoID),
	FOREIGN KEY (videojuegoID) REFERENCES Videogames(idVideogame),
	-- Restricciones:
	CONSTRAINT RN_1_01 UNIQUE(videojuegoID, fecha),
	CONSTRAINT RN_1_02 CHECK (10 <= premio <= 500),
	CONSTRAINT RN_1_03 CHECK (YEAR(fecha) < 2050)
);

INSERT INTO Concursos (videojuegoID, premio, nombre, fecha) VALUES
	(2, 20, 'Concurso 1', '2020-01-01'),
	(2, 100, 'Concurso 2', '2019-04-15'),
	(1, 70, 'Concurso 3', '2021-10-10')
	-- (1, 70, 'Concurso 4', '2100-01-01'),
	-- (55, 70, 'Concurso 5', '2021-00-00'),
	-- (2, 70, 'Concurso 6', '2020-01-01')
	;

/*	
DELETE FROM Concursos WHERE concursoID = 1;


UPDATE Concursos 
	SET premio = 300
	WHERE concursoID = 2 or concursoID = 3;
Selección
SELECT U.name, U.age, V.name FROM Users U JOIN UsersVideogames UV ON U.idUser = UV.idUser JOIN Videogames V ON UV.idVideogame = V.idVideogame;
*/


DELIMITER //
CREATE OR REPLACE TRIGGER MinimoMinimo
BEFORE INSERT ON Concursos
FOR EACH ROW
BEGIN
	DECLARE minimo FLOAT;
	SET minimo = (SELECT MIN(premio) FROM Concursos);
	IF (new.premio < minimo) THEN
		SIGNAL SQLSTATE '45000' SET message_text = 'Por debajo del minimo campeon';
	END IF;
END //
DELIMITER ;

INSERT INTO Concursos (videojuegoID, premio, nombre, fecha) VALUES
	(3, 400, 'Concurso 1', '2025-01-01');


DELIMITER //
CREATE OR REPLACE FUNCTION rompemuros(concursoID INT) RETURNS INT
BEGIN
	DECLARE minimo DOUBLE;
	DECLARE numero INT;
	SET minimo = (SELECT premio FROM Concursos WHERE Concursos.concursoID = concursoID);
	SET numero = (SELECT COUNT(*) FROM Concursos WHERE Concursos.premio > minimo);
	RETURN numero;
END //
DELIMITER ;

-- SELECT rompemuros(1);


DELIMITER //
CREATE OR REPLACE PROCEDURE hola(concursoID INT)
BEGIN
	IF (rompemuros(concursoID) > 0) THEN
		DELETE FROM Concursos WHERE Concursos.concursoID = concursoID;
	END IF;
END //
DELIMITER ;

-- CALL hola(1);

/*
SELECT U.name, COUNT(*) FROM Users U JOIN UsersVideogames UV ON U.idUser = UV.idUser JOIN Videogames V ON UV.idVideogame = V.idVideogame

	GROUP BY U.name;
*/