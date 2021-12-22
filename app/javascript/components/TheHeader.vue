<template>
  <v-app-bar
    color="#D63D17"
    outlined
    dark
    fixed
  >
    <v-app-bar-nav-icon @click="changeDrawer" />
    <v-toolbar-title>
      <router-link
        to="/"
        class="title_logo"
      >
        Macro Store
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
        to="/confirmation"
        class="button"
      >
        <v-btn icon>
          <v-badge
            :content="selectedFoodNumber"
            :value="selectedFoodNumber"
            color="#1c65ac"
            overlap
          >          
            <v-icon>
              mdi-cart
            </v-icon>
          </v-badge>
        </v-btn>
      </router-link>
    </template>
  </v-app-bar>
</template>


<script>
import { mapGetters, mapActions } from "vuex";
export default {
  computed: {
    ...mapGetters(["selectFoods"]),
    isAutheniticated() {
      return this.$store.getters.user !== null;
    },
    selectedFoodNumber() {
      return this.selectFoods.length
    }
  },
  methods: {
    ...mapActions(["changeDrawer", "logout"]),
  },
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
