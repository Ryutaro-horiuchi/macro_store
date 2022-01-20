<template>
  <v-app>
    <v-card
      class="mx-auto overflow-hidden"
      color="rgba(220, 175, 089, 0.1)"
      height="100%"
      width="100%"
    >
      <TheHeader />
      <TheFlashMessage />
      <router-view />
      <TheNavigationBar/>
      <TheFooter />
    </v-card>
  </v-app>
</template>

<script>
import TheHeader from "./components/TheHeader.vue"
import TheNavigationBar from "./components/TheNavigationBar.vue"
import TheFooter from "./components/TheFooter.vue"
import TheFlashMessage from "./components/TheFlashMessage.vue"

export default {
  components: {
    TheHeader,
    TheNavigationBar,
    TheFooter,
    TheFlashMessage
  }
}
</script>

<style>
#app {
  font-family: sans-serif;
}
</style>
