import { GraphQLClient, gql } from "graphql-request";

export const locationsBrief = gql`
  query LocationsWPeople {
    locations {
      city
      cityId
      district
      neighborhood
      hash
      events {
        id
        message
        status
        verified
      }
      people(limit: 20, order_by: { created_at: desc }) {
        id
        person
        street
        mainStreet
        floor
        buildingNo
        building
        cityId
        description
        urls
      }
    }
  }
`;

export const cities = gql`
  query CityList {
    cities {
      id
      name
    }
  }
`;
