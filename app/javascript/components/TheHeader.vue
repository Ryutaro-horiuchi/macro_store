<template>
  <v-app-bar
    color="#393E46"
    outlined
    dark
    fixed
  >
    <v-app-bar-nav-icon @click="changeDrawer" />
    <v-toolbar-title
      style="cursor: pointer;"
      @click="toTop"
    >
      Macro Store
      <!-- <v-img :src="logoImg" max-height="54" max-width="110" /> -->
    </v-toolbar-title>
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
      <!-- <router-link
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
      </router-link> -->
      <router-link
        style="text-decoration: none;"
        to="/confirmation"
      >
        <v-btn icon>
          <v-icon>mdi-cart</v-icon>
        </v-btn>
      </router-link>
    </template>
  </v-app-bar>
</template>


<script>
import { mapActions } from "vuex";
export default {
  data() {
    return {
      logoImg: require("../../assets/images/logo.png")
    }
  },
  computed: {
    isAutheniticated() {
      return this.$store.getters.user !== null;
    }
  },
  methods: {
    ...mapActions(["changeDrawer", "logout"]),
    toTop() {
      if (this.$route.path !== "/") {
        this.$router.push("/")
      }
    }
  }
}
</script>
