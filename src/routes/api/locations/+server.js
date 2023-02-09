import { runQuery, useAuth } from "$lib/server/fetch-graph";
import { locationsBrief, cities } from "$lib/server/queries/locations";

/** @type {import('./$types').RequestHandler} */
export async function POST({
  cookies,
  getClientAddress,
  params,
  request,
  url,
}) {
  const reqBody = await request.json();

  const { type, q } = reqBody;

  let result = {};

  if (type == "location") {
    result = await fetchLocationBrief();
  }

  return new Response(JSON.stringify(result));
}
/** @type {import('./$types').RequestHandler} */
export async function GET({ cookies, getClientAddress, params, request, url }) {
  const result = await fetchCities();
  return new Response(JSON.stringify(result));
}

const fetchCities = async () => {
  return useAuth()
    .then((header) => runQuery(cities, {}, header))
    .then((result) => result.cities);
};

const fetchLocationBrief = async () => {
  return useAuth()
    .then((header) => runQuery(locationsBrief, {}, header))
    .then((result) => result.locations);
};
