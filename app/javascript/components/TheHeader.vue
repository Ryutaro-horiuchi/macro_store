<template>
  <v-app-bar
    color="green"
    dark
  >
    <v-app-bar-nav-icon @click="changeDrawer" />
    <v-toolbar-title>MacroStore</v-toolbar-title>
    <v-spacer />
    <template v-if="isAutheniticated">
      <v-btn
        icon
        @click="logout"
      >
        <v-icon>mdi-logout</v-icon>
      </v-btn>
    </template>
    <template v-if="!isAutheniticated">
      <router-link
        style="text-decoration: none;"
        to="/login"
      >
        <v-btn icon>
          <v-icon>mdi-login</v-icon>
        </v-btn>
      </router-link>
      <router-link
        style="text-decoration: none;"
        to="/signup"
      >
        <v-btn icon>
          <v-icon>mdi-account-plus</v-icon>
        </v-btn>
      </router-link>
    </template>
  </v-app-bar>
</template>


<script>
export default {
  computed: {
    isAutheniticated() {
      return this.$store.getters.user !== null;
    }
  },
  methods: {
    changeDrawer() {
      this.$store.dispatch('changeDrawer');
    },
    logout() {
      this.$store.dispatch('logout')
    }
  }
}
</script>