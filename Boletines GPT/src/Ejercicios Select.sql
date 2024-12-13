-- Boletines GTP: SELECTS

-- Ejercicio 1. Selección simple: Lista todos los usuarios (tabla Users) mostrando su nombre y correo electrónico.

SELECT name, email FROM Users;

-- Ejercicio 2. Condición en una columna: Muestra el nombre y la edad de todos los usuarios cuya edad sea mayor o igual a 30.

SELECT name, age FROM Users WHERE age >= 30;

-- Ejercicio 3. Filtrando por otra tabla (JOIN básico): Lista el nombre de todos los videojuegos (de la tabla Videogames) 
-- junto al nombre de la plataforma (de la tabla Platforms) en la que se ejecutan.

SELECT V.name, P.name FROM Videogames V JOIN Platforms P ON V.idPlatform = P.idPlatform;

-- Ejercicio 4. Uso de condiciones en JOIN: Muestra los videojuegos de la tabla Videogames cuyo precio sea menor que 20 y 
-- que pertenezcan a la plataforma 'PC' (filtrando mediante JOIN con la tabla Platforms).

SELECT * FROM Videogames V JOIN Platforms P ON V.idPlatform = P.idPlatform
	WHERE V.price < 20 AND P.name = 'PC';

-- Ejercicio 5. Agregaciones básicas: Calcula el precio medio de todos los videojuegos de la tabla Videogames.

SELECT AVG(V.price) Precio_Medio FROM Videogames V;

-- Ejercicio 6. Funciones de agregación con GROUP BY: Agrupa los videojuegos por plataforma y muestra el número total de 
-- videojuegos por cada plataforma.

SELECT P.name, COUNT(*) Cuenta FROM Videogames V JOIN Platforms P ON V.idPlatform = P.idPlatform
	GROUP BY P.name;

-- Ejercicio 7. Condiciones en GROUP BY (HAVING): Agrupa los videojuegos por plataforma y muestra solo aquellos grupos que
-- tengan más de 3 videojuegos en esa plataforma.

SELECT P.name, COUNT(*) Cuenta FROM Videogames V JOIN Platforms P ON V.idPlatform = P.idPlatform
	GROUP BY P.name
	HAVING Cuenta > 3;
	
-- Ejercicio 8. Subconsulta simple: Muestra el nombre y el email de los usuarios que hayan comprado (UsersVideogames) el
-- videojuego más caro (el que tenga el precio máximo en la tabla Videogames).

SELECT U.email Correo, V.price Precio FROM 
	Users U JOIN UsersVideogames UV ON U.idUser = UV.idUser JOIN Videogames V ON UV.idVideogame = V.idVideogame
		WHERE V.price = (SELECT MAX(price) From Videogames); 
	-- WHERE aclara que pueden haber mas de un usuario con precio maximo, y los selecciona con una subconsulta
	
-- Ejercicio 9. Subconsulta correlacionada: Muestra el nombre y el correo electrónico de los usuarios que posean algún 
-- videojuego que tenga en su título la palabra 'Myst'.

SELECT U.name Nombre, U.email Correo, V.name Nombre_Juego FROM 
	Users U JOIN UsersVideogames UV ON U.idUser = UV.idUser JOIN Videogames V ON UV.idVideogame = V.idVideogame
		WHERE V.name LIKE '%Myst%';

-- Ejercicio 10. Ordenación y límite de resultados: Lista todos los videojuegos ordenados por su puntuación (score) 
-- descendente y muestra únicamente los 5 primeros.

SELECT * FROM Videogames
	ORDER BY score DESC
	LIMIT 5;

-- Ejercicio 11. JOIN múltiples: Muestra el nombre del usuario, el título del videojuego y la descripción del género 
-- asociado. (Usa UsersVideogames, Videogames, GenresVideogames y Genres).

SELECT U.name Nombre, V.name Juego, G.description Descripcion FROM 
	Users U JOIN UsersVideogames UV ON U.idUser = UV.idUser 
		JOIN Videogames V ON UV.idVideogame = V.idVideogame 
		JOIN GenresVideogames GV ON V.idVideogame = GV.idVideogame 
		JOIN Genres G ON GV.idGenre = G.idGenre;
	
-- Ejercicio 12. JOIN con varias tablas y filtrado: Muestra el nombre del usuario y el título del videojuego (Videogames) 
-- solo para aquellos casos en que el videojuego tenga una puntuación (score) igual o superior a 9 y el usuario tenga más 
-- de 40 años

SELECT U.name Nombre, V.name Titulo FROM
	Users U JOIN UsersVideogames UV ON U.idUser = UV.idUser
		JOIN Videogames V ON UV.idVideogame = V.idVideogame
		WHERE V.score >= 9 and U.age > 40;
		
-- Ejercicio 13. Uso de funciones escalares (ejemplo con fecha): Muestra el nombre del videojuego y el año de lanzamiento extraído 
-- de releaseDate.

SELECT name Título, YEAR(releaseDate) Año FROM Videogames
	ORDER BY Año; -- Le pongo un order para que sea mas bonito
	
-- Ejercicio 14. Subconsulta para filtrar logros: Muestra el nombre de los usuarios que hayan obtenido el logro (Achievements) con
-- mayor puntuación en toda la base de datos.

SELECT U.name Nombre FROM
	Users U JOIN UsersAchievements UA ON U.idUser = UA.idUser
		JOIN Achievements A ON UA.idAchievement = A.idAchievement
	
	WHERE A.points = (
		SELECT MAX(points) FROM Achievements
	);

-- Ejercicio 15. JOIN self (amistades): Muestra las parejas de amigos (Friendships) indicando el nombre de ambos usuarios amigos.

SELECT U1.name Nombre1, U2.name Nombre2 FROM
	Users U1 LEFT JOIN Friendships F ON U1.idUser = F.idUser1 LEFT JOIN Users U2 ON F.idUser2 = U2.idUser;
	
-- Ejercicio 16. División relacional (conceptual): Encuentra los usuarios que tengan al menos un videojuego de todos los géneros
-- que tiene el videojuego con uniqueCode = 'M51' (Myst).

-- Ejercicio 17.  Usuarios sin amigos: Encuentra el nombre y correo electrónico de los usuarios que no tengan ningún amigo en la
-- tabla Friendships.

SELECT name FROM Users 
	WHERE NOT EXISTS (SELECT idUser1, idUser2 FROM Friendships);

-- Ejercicio 18. Videojuegos con sus géneros en una sola fila: Muestra el nombre del videojuego y una lista concatenada (separada
-- por comas) con las descripciones de los géneros a los que pertenece.

-- Ejercicio 19. Videojuegos con mayor número de reviews y su puntuación media: Muestra el título de los videojuegos que tengan
-- el mayor número de reseñas (Reviews), junto a la puntuación media de esas reseñas.

-- Ejercicio 20. Ranking de usuarios por puntos de logros: Suma los puntos de todos los logros que cada usuario haya obtenido y
-- ordena el resultado de mayor a menor.

-- Ejercicio 21. Amigos en común (Relación triangular): Encuentra los usuarios que tienen un amigo (User A), que a su vez sea
-- amigo de otro usuario (User B), y que este último (User B) también sea amigo del primero (User A).

-- Ejercicio 22. Logros no obtenidos: Muestra para cada usuario un listado de los logros que aún no han obtenido, junto con el
-- nombre del videojuego al que pertenecen dichos logros.








