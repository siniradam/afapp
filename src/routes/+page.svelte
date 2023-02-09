<script>
  import { onMount, createEventDispatcher } from "svelte";
  import { request } from "$lib/utils/fetch";

  let locations = [];

  onMount(() => {
    request("/api/locations", "POST", { type: "location" })
      .then((result) => result.json())
      .then((json) => {
        locations = json;
      });
  });

  const searchByCity = (cityId) => {
    console.log(cityId);
  };

  const searchByNeighborhood = (hash) => {
    console.log(hash);
  };
</script>

<svelte:head>
  <title>Afet Kordinasyon</title>
</svelte:head>

<div class="flex">
  <div
    class="flex-grow text-white bg-indigo-900 rounded-bl overflow-scroll"
    style="max-height: calc(100vh - 130px);max-width:80%"
  >
    <div class="p-4 flex flex-col gap-2">
      {#each locations as location}
        <div class="bg-indigo-700 rounded">
          <!-- Title -->
          <div class="flex">
            <button
              class="bg-indigo-600 rounded-bl px-2 py-1"
              on:click={() => searchByCity(location.cityId)}
            >
              {location.city}
            </button>
            <button class="bg-indigo-500 rounded-br px-2 py-1">
              {location.district}
            </button>
            <button
              class="bg-indigo-500 rounded-br px-2 py-1"
              on:click={() => searchByNeighborhood(location.hash)}
            >
              {location.neighborhood}
            </button>
          </div>

          <!-- People -->
          <div class="flex flex-row flex-wrap items-stretch p-2 gap-4">
            {#each location.people as person}
              <div
                class="max-w-md min-w bg-indigo-300 rounded text-black flex flex-col flex-grow"
              >
                <div class="font-bold bg-indigo-200 rounded-sm p-2">
                  {person.person}
                </div>
                <div class="font-bold px-2 pb-1">
                  {person.street}, {person.mainStreet}
                </div>
                <div class="px-2 pb-1">
                  {person.description}
                </div>
                <div class="self-center mt-auto">
                  <a
                    class="rounded-md m-2 p-2 bg-indigo-100 block"
                    href="/person/{person.id}"
                  >
                    Bu kisi ile ilgili bilgim var.
                  </a>
                </div>
              </div>
            {/each}
          </div>
        </div>
      {/each}
    </div>
  </div>
  <div class="p-4 bg-white rounded-r-lg w-80">
    <div class="buttons">
      <button> Yardima Ihtiyacim Var </button>
      <button> Ihtiyaclarim Var </button>
    </div>

    <div class="buttons">
      <button> Kisi Bildirimi Yap </button>
      <button> Ihtiyaclarim Var </button>
    </div>
  </div>
</div>
