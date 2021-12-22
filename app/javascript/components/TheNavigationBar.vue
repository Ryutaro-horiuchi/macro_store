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
      <v-list-item-group 
        v-model="group"
        active-class="deep-purple--text text--accent-4"
      >
        <router-link
          to="/login"
          class="button"
        >
          <v-list-item
            class="my-8"
          >
            <v-list-item-icon>
              <v-icon>mdi-login</v-icon>
            </v-list-item-icon>
            <v-list-item-title>ログイン</v-list-item-title>
          </v-list-item>
        </router-link>
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
        <!-- <v-list-item class="my-8">
          <v-list-item-icon>
            <v-icon>mdi-medal</v-icon>
          </v-list-item-icon>
          <v-list-item-title>ランキング</v-list-item-title>
        </v-list-item>
        <v-list-item class="my-8">
          <v-list-item-icon>
            <v-icon>mdi-food-drumstick</v-icon>
          </v-list-item-icon>
          <v-list-item-title>
            お気に入り食品
          </v-list-item-title>
        </v-list-item>
        <v-list-item class="my-8">
          <v-list-item-icon>
            <v-icon>mdi-account</v-icon>
          </v-list-item-icon>
          <v-list-item-title>ユーザーぺージ</v-list-item-title>
        </v-list-item> -->
      </v-list-item-group>
    </v-list>
  </v-navigation-drawer>
</template>

<script>
export default {
  data: () => ({
      group: null,
    }),
}
</script>

<style scoped>
.button {
  text-decoration: none;
  color: white;
  cursor: pointer;
}
</style>