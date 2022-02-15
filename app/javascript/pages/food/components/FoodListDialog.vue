<template>
  <v-card>
    <v-card-title>
      {{ food.name }}
      <v-spacer />
      税抜{{ food.price }}円
    </v-card-title>
    <v-card-subtitle class="text-right text-h6">
      <p>{{ food.calorie }}kcal</p>
    </v-card-subtitle>
    <v-row>
      <v-col
        cols="2"
        offset="9"
      >
        <v-img
          :src="sevenImg"
          height="32"
          width="32"
        />
      </v-col>
    </v-row>
    <v-row justify="center">
      <v-col cols="10">
        <v-img :src="food.image.url" />
      </v-col>
    </v-row>
    <v-row justify="center">
      <v-col cols="9">
        <FoodListBarChart
          :key="food.id"
          :food="food"
        />
      </v-col>
    </v-row>
    <v-row>
      <v-col
        cols="6"
      >
        <v-row
          justify="center"
          class="mb-5"
        >
          <v-btn
            color="#1c65ac"
            dark
            elevation="3"
            @click="closeDialog"
          >
            閉じる
          </v-btn>
        </v-row>
      </v-col>
      <template v-if="!isBookmarked">
        <v-col
          cols="5"
        >
          <v-row
            justify="center"
            class="mb-5"
          >
            <v-btn
              color="#1c65ac"
              dark
              elevation="3"
              @click="makeBookmark(food)"
            >
              お気に入りに追加
            </v-btn>        
          </v-row>
        </v-col>
      </template>
      <template v-if="isBookmarked">
        <v-col
          cols="5"
        >
          <v-row
            justify="center"
            class="mb-5"
          >
            <v-btn
              color="#1c65ac"
              dark
              elevation="3"
              @click="removeBookmark(food)"
            >
              お気に入りから削除
            </v-btn>        
          </v-row>
        </v-col>
      </template> 
    </v-row>
  </v-card>
</template>

<script>
import { mapActions, mapGetters } from "vuex";
import FoodListBarChart from './FoodListBarChart.vue'

export default {
  components: {
    FoodListBarChart
  },
  data() {
    return {
      add_nutrients: { calorie: 0, carbohydrate: 0, protein: 0, lipid: 0 },
      sevenImg: require("../../../../assets/images/seven_eleven.logo.png")
    }
  },
  computed: {
    ...mapGetters(["food", "foodDialog", "bookmarkedFoods"]),
    isBookmarked() {
      return this.bookmarkedFoods.some(food => food.id === this.food.id)
    }
  },
  methods: {
    ...mapActions(["closeDialog", "makeBookmark", "removeBookmark"]),
  }
}
</script>

<style scoped>

</style>