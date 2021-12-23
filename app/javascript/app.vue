<template>
  <v-app>
    <v-card
      class="mx-auto overflow-hidden"
      color="#fff0e0"
      height="100%"
      width="100%"
    >
      <TheHeader />
      <router-view />
      <TheNavigationBar />
      <TheFooter />
    </v-card>
  </v-app>
</template>

<script>
import TheHeader from "./components/TheHeader.vue"
import TheNavigationBar from "./components/TheNavigationBar.vue"
import TheFooter from "./components/TheFooter.vue"

export default {
  components: {
    TheHeader,
    TheNavigationBar,
    TheFooter
  }
}
</script>

<style>
#app {
  font-family: sans-serif;
}
</style>
