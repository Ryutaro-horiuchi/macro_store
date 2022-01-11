<template>
  <v-app-bar
    color="#D63D17"
    outlined
    dark
    flat
    fixed
  >
    <v-app-bar-nav-icon @click="changeDrawer" />
    <v-toolbar-title>
      <router-link
        to="/"
        class="title_logo"
      >
        <v-row>
          <v-col
            cols="10"
            md="12"
          >
            <v-img
              :src="headerImg"
              max-height="150"
              max-width="150"
            />
          </v-col>
        </v-row>
      </router-link>
    </v-toolbar-title>
    <v-spacer />
    <router-link
      to="/search"
      class="button"
    >
      <v-icon>mdi-magnify</v-icon>
    </router-link>
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
      <!-- <router-link
        style="text-decoration: none;"
        to="/signup"
      >
        <v-btn icon>
          <v-icon>mdi-account-plus</v-icon>
        </v-btn>
      </router-link> -->
    </template>
  </v-app-bar>
</template>


<script>
import { mapGetters, mapActions } from "vuex";
export default {
  data() {
    return {
      headerImg: require("../../assets/images/MacroStore_header_logo.png")
    }
  },
  computed: {
    ...mapGetters(["user"]),
    isAutheniticated() {
      return this.user !== null
    }
  },
  methods: {
    ...mapActions(["changeDrawer"]),
    logout() {
      if (confirm('ログアウトしてもよろしいですか？')) {
        this.$store.dispatch("logout")
      }
    },
  }
}
</script>

<style scoped>
.title_logo {
  font-family: 'Playfair Display', serif;
  font-size: large;
  text-decoration: none;
  color: white;
  cursor: pointer;
}

.button {
  text-decoration: none;
  color: white;
  cursor: pointer;
}
</style>
