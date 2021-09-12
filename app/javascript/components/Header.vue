<template>
  <v-app-bar color="green" dark>
    <v-app-bar-nav-icon @click="changeDrawer"></v-app-bar-nav-icon>
    <v-toolbar-title>Macro Store</v-toolbar-title>
  </v-app-bar>
</template>


<script>
export default {
  methods: {
    changeDrawer() {
      this.$store.dispatch('changeDrawer');
    }
  }
}
</script>