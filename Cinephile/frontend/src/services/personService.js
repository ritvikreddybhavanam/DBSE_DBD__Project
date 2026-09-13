import api from "./api";

export const getPersonDetails = async (personId) => {
    const response = await api.get(`/tmdb/person/${personId}`);
    return response.data;
};

export const getPersonCredits = async (personId) => {
    const response = await api.get(
        `/tmdb/person/${personId}/credits`
    );

    return response.data;
};

export const getPersonImages = async (personId) => {
    const response = await api.get(
        `/tmdb/person/${personId}/images`
    );

    return response.data;
};

export const getPersonExternalIds = async (personId) => {
    const response = await api.get(
        `/tmdb/person/${personId}/external-ids`
    );

    return response.data;
};