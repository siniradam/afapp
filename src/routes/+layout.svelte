<script>
  import "../app.css";
  let searchOptions = [
    { name: "Mahalle", value: "location" },
    { name: "Kisi", value: "person" },
  ];
</script>

<main class="flex grow flex-col">
  <div class="container mx-auto py-4 mt-10">
    <div class="bg-slate-200 rounded-lg">
      <div class="p-4 flex gap-4">
        <input type="search" class="rounded flex-grow h-7" />
        <select class="rounded h-7 w-1/12">
          {#each searchOptions as o}
            <option value={o.value}>{o.name}</option>
          {/each}
        </select>
      </div>
      <div>
        <slot />
      </div>
    </div>
  </div>
</main>
