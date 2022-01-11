<template>
  <v-navigation-drawer
    v-model="$store.state.drawer"
    color="#D63D17"
    fixed
    dark
    temporary
  >
    <v-list
      nav
      dense
    >
      <!-- v-model="group" -->

      <v-list-item-group 
        active-class="deep-purple--text text--accent-4"
      >
        <!-- <router-link
          to="/login"
          class="button"
        >
          <v-list-item
            class="my-8"
          > -->
            <!-- <v-list-item-icon>
              <v-icon>mdi-login</v-icon>
            </v-list-item-icon>
            <v-list-item-title>ログイン</v-list-item-title>
          </v-list-item>
        </router-link> -->
        <template v-if="!isAutheniticated">
          <router-link
            to="/signup"
            class="button"
          >
            <v-list-item
              class="my-8"
            >
              <v-list-item-icon>
                <v-icon>mdi-account-plus</v-icon>
              </v-list-item-icon>
              <v-list-item-title>新規会員登録</v-list-item-title>
            </v-list-item>
          </router-link>
        </template>
        <router-link
          to="/"
          class="button"
        >
          <v-list-item
            class="my-8"
          >
            <v-list-item-icon>
              <v-icon>mdi-home</v-icon>
            </v-list-item-icon>
            <v-list-item-title>Home</v-list-item-title>
          </v-list-item>
        </router-link>
        <router-link
          to="/mypage"
          class="button"
        >
          <v-list-item class="my-8">
            <v-list-item-icon>
              <v-icon>mdi-account</v-icon>
            </v-list-item-icon>
            <v-list-item-title>マイぺージ</v-list-item-title>
          </v-list-item>
        </router-link>
        <router-link
          to="/bookmark"
          class="button"
        >
          <v-list-item class="my-8">
            <v-list-item-icon>
              <v-icon>mdi-food-drumstick</v-icon>
            </v-list-item-icon>
            <v-list-item-title>
              お気に入り食品
            </v-list-item-title>
          </v-list-item>
        </router-link>
        <router-link
          to="/calculation"
          class="button"
        >
          <v-list-item class="my-8">
            <v-list-item-icon>
              <v-icon>mdi-calculator-variant-outline</v-icon>
            </v-list-item-icon>
            <v-list-item-title>カロリー計算</v-list-item-title>
          </v-list-item>
        </router-link>
      </v-list-item-group>
    </v-list>
    <template #append>
      <div
        v-if="isAutheniticated"
        class="pa-2"
      >
        <v-btn
          block
          color="#1c65ac"
          @click="logout"
        >
          ログアウト
        </v-btn>
      </div>
      <div
        v-if="!isAutheniticated"
        class="pa-2"
      >
        <router-link
          to="/login"
          class="button"
        >
          <v-btn
            block
            color="#1c65ac"
          >
            ログイン
          </v-btn>
        </router-link>
      </div>
    </template>
  </v-navigation-drawer>
</template>

<script>
import { mapGetters } from "vuex";

export default {
  computed: {
    ...mapGetters(["user"]),
    isAutheniticated() {
      return this.user !== null
    }
  },
  methods: {
    logout() {
      if (confirm('ログアウトしてもよろしいですか？')) {
        this.$store.dispatch("logout")
      }
    },
  }
}
</script>

<style scoped>
.button {
  text-decoration: none;
  color: white;
  cursor: pointer;
}
</style>