<template>
  <v-footer
    padless
    absolute
  >
    <v-card
      flat
      tile
      width="100%"
      color="#D63D17"
      dark
      class="text-center"
    >
      <v-card-text>
        <v-row class="text-center">
          <v-col
            cols="4"
            class="text-caption text-md-body-2"
          >
          <router-link to="/terms" class="link">
            <strong>利用規約</strong>
          </router-link>
          </v-col>
          <v-divider
            vertical
          />
          <v-col
            cols="4"
            class="text-caption text-md-body-2"
          >
          <router-link to="/privacy" class="link">
            <strong>プライバシーポリシー</strong>
          </router-link>
          </v-col>
          <v-divider
            vertical
          />
          <v-col
            cols="4"
            class="text-caption text-md-body-2"
          >
            <a
              href="https://forms.gle/8teFTLdYvMkJpD5f9"
              class="link"
            >
              <strong>お問い合わせ</strong>
            </a>
          </v-col>
        </v-row>
      </v-card-text>
      <v-card-text class="white--text body-2">
        &copy; 2021 - Macro Store
      </v-card-text>
    </v-card>
  </v-footer>
</template>

<style scoped>
.link {
  text-decoration: none;
  color: rgba(255, 255, 255, 0.733);
  cursor: pointer;
}
</style>