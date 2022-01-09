<template>
  <FoodList
    :foods="bookmarkedFoods"
    @to-search-page="toSearchPage"
  >
    <template #message>
      <v-container>
        <v-row justify="center">
          <div
            class="text-center text-h5 text-md-h3"
            style="margin-top: 50px; margin-bottom: 30px;"
          >
            お気に入り
          </div>
        </v-row>
      </v-container>
    </template>
    <template #noData>
      <h2 style="margin-top: 100px;">
        お気に入り食品がありません
      </h2>
      <v-row
        justify="center"
        class="mt-10"
      >
        <v-btn
          color="#1c65ac"
          class="mx-auto"
          dark
          x-large
          elevation="3"
          @click="toSearchPage"
        >
          食品を探す
        </v-btn>
      </v-row>
    </template>
  </FoodList>
</template>

<script>
import FoodList from "../food/components/FoodList.vue";
import { mapGetters } from "vuex";

export default {
  components: {
    FoodList
  },
  computed: {
    ...mapGetters(["bookmarkedFoods"])
  },
  methods: {
    toSearchPage() {
      this.$router.push('/search')
    }
  }
}
</script>