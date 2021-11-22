<template>
  <v-app>
    <v-card
      class="mx-auto overflow-hidden"
      height="100%"
      width="100%"
    >
      <TheHeader />
      <router-view />
      <TheNavigationBar />
    </v-card>
  </v-app>
</template>

<script>
import TheHeader from "./components/TheHeader.vue"
import TheNavigationBar from "./components/TheNavigationBar.vue"

export default {
  components: {
    TheHeader,
    TheNavigationBar,
  }
}
</script>

<style>
h1, h2, h3, h4 {
  font-weight: normal;
}
</style>
