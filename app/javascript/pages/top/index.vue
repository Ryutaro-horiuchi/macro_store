<template>
  <div>
    <FoodSearchBar />
    <h2>Topページ</h2>
    <v-container>
      <v-row justify="center">
        <v-col
          cols="4"
          offset="1"
        >
          <v-btn
            class="mx-auto"
            x-large
            outlined
            elevation="3"
            @click="toCaloriePage"
          >
            摂取カロリー量を計算する
          </v-btn>
        </v-col>
        <v-col
          cols="4"
          offset="1"
        >
          <v-btn
            class="mx-auto"
            x-large
            outlined
            elevation="3"
            @click="toSearchPage"
          >
            食品を探す
          </v-btn>
        </v-col>
      </v-row>
    </v-container>

  </div>
</template>

<script>
import FoodSearchBar from "../food/components/FoodSearchBar.vue"

export default {
  components: {
    FoodSearchBar,
  },
  methods: {
    toSearchPage() {
      this.$router.push('/search')
    },
    toCaloriePage() {
      this.$router.push('/calorie')
    }
  }
}

</script>

<style scoped>

</style>