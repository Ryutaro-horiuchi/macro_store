<template>
  <v-app-bar color="green" dark>
    <v-app-bar-nav-icon @click="changeDrawer"></v-app-bar-nav-icon>
    <v-toolbar-title>Macro Store</v-toolbar-title>
    <v-spacer></v-spacer>
    <v-btn icon>
        <v-icon>mdi-login</v-icon>
      </v-btn>
    <router-link style="text-decoration: none;" to="/signup">
      <v-btn icon>
        <v-icon>mdi-account-plus</v-icon>
      </v-btn>
    </router-link>
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