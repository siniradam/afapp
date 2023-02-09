import { GraphQLClient, gql } from "graphql-request";
const VITE_NHOST_BACKEND_URL = import.meta.env.VITE_NHOST_BACKEND_URL;

/**
 *
 * @param {String=} token
 * @returns
 */
export const useAuth = async (token) => {
  return token ? { Authorization: `Bearer ${token}` } : {};
};

/**
 *
 * @param {String} q Graphql Query
 * @param {Object} variables Query variables
 * @param {Object} headers Header variables
 * @returns {Promise<Object>} Returns query object promise.
 */
export const runQuery = async (q, variables, headers = {}) => {
  const graphQLClient = new GraphQLClient(
    `${VITE_NHOST_BACKEND_URL}/v1/graphql`,
    {
      headers: {
        "x-site-id": "afapp",
        ...headers,
      },
    }
  );

  return graphQLClient.request(q, variables);
};
