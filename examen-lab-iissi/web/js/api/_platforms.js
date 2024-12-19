/*
 * DO NOT EDIT THIS FILE, it is auto-generated. It will be updated automatically.
 * All changes done to this file will be lost upon re-running the 'silence createapi' command.
 * If you want to create new API methods, define them in a new file.
 *
 * Silence is built and maintained by the DEAL research group at the University of Seville.
 * You can find us at https://deal.us.es
 */

"use strict";

import { BASE_URL, requestOptions } from './common.js';

const platformsAPI_auto = {

    /** Gets all entries from 'platforms' */
    getAll: async function() {
        let response = await axios.get(`${BASE_URL}/platforms`, requestOptions);
        return response.data;
    },

    /** Gets an entry from 'platforms' by its primary key */
    getById: async function(idPlatform) {
        let response = await axios.get(`${BASE_URL}/platforms/${idPlatform}`, requestOptions);
        return response.data[0];
    },

    /** Creates a new entry in 'platforms' */
    create: async function(formData) {
        let response = await axios.post(`${BASE_URL}/platforms`, formData, requestOptions);
        return response.data;
    },

    /** Updates an existing entry in 'platforms' by its primary key */
    update: async function(formData, idPlatform) {
        let response = await axios.put(`${BASE_URL}/platforms/${idPlatform}`, formData, requestOptions);
        return response.data;
    },

    /** Deletes an existing entry in 'platforms' by its primary key */
    delete: async function(idPlatform) {
        let response = await axios.delete(`${BASE_URL}/platforms/${idPlatform}`, requestOptions);
        return response.data;
    },
};

export { platformsAPI_auto };