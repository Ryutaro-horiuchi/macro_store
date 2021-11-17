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
import FoodSearchBar from "./pages/food/components/FoodSearchBar.vue"

export default {
  components: {
    TheHeader,
    TheNavigationBar,
    FoodSearchBar
  }
}
</script>

<style>



</style>
