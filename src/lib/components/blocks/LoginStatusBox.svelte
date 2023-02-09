<script>
  import { isSignedIn, user } from "$lib/nhost";
</script>

<div class="loginstatus">
  {#if $isSignedIn && $user}
    <div />
  {:else}
    <!-- <a href="/login">Login</a> -->
  {/if}
</div>
