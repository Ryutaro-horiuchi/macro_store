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
        offset="7"
      >
        <v-img
          :src="sevenImg"
          height="32"
          width="32"
        />
      </v-col>
      <template v-if="!isBookmarked">
        <v-col cols="2">
          <v-icon
            color="blue"
            large
            @click.stop="makeBookmark(food)"
          >
            mdi-star-outline
          </v-icon>
        </v-col>
      </template>
      <template v-if="isBookmarked">
        <v-col cols="2">
          <v-icon
            color="blue"
            large
            @click.stop="removeBookmark(food)"
          >
            mdi-star
          </v-icon>
        </v-col>
      </template> 
    </v-row>
    <v-row justify="center">
      <v-col cols="10">
        <v-img :src="food.image.url" />
      </v-col>
    </v-row>
    <v-row justify="center">
      <v-col cols="9">
        <FoodBarChart
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
            x-large
            elevation="3"
            @click="closeDialog"
          >
            閉じる
          </v-btn>
        </v-row>
      </v-col>
      <template v-if="!isSelected">
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
              x-large
              elevation="3"
              @click="addNutrients(); selectFood(food)"
            >
              選択する<v-icon>mdi-cart</v-icon>
            </v-btn>        
          </v-row>
        </v-col>
      </template>
    </v-row>
  </v-card>
</template>

<script>
import { mapActions, mapGetters } from "vuex";
import FoodBarChart from './components/FoodBarChart.vue'

export default {
  components: {
    FoodBarChart
  },
  data() {
    return {
      add_nutrients: { calorie: 0, carbohydrate: 0, protein: 0, lipid: 0 },
      sevenImg: require("../../../assets/images/seven_eleven.logo")
    }
  },
  computed: {
    ...mapGetters(["foodDialog", "food", "selectFoods", "bookmarkedFoods"]),
    isSelected() {
      return this.selectFoods.some(food => food.id === this.food.id)
    },
    isBookmarked() {
      return this.bookmarkedFoods.some(food => food.id === this.food.id)
    }
  },
  methods: {
    ...mapActions(["closeDialog", "selectFood", "makeBookmark", "removeBookmark"]),
    addNutrients() {
      this.$store.dispatch("addNutrients", this.food)
    },
  }
}
</script>

<style scoped>

</style>