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
    <v-row justify="center">
      <v-col cols="9">
        <v-img :src="food.image.url" />
      </v-col>
      <v-col cols="9">
        <FoodBarChart
          :key="food.id"
          :food="food"
        />
      </v-col>
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
      <template v-if="isNotSelected">
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
      add_nutrients: { calorie: 0, carbohydrate: 0, protein: 0, lipid: 0 }
    }
  },
  computed: {
    ...mapGetters(["foodDialog", "food", "selectFoods"]),
    isNotSelected() {
      return !this.selectFoods.includes(this.food)
    }
  },
  methods: {
    ...mapActions(["closeDialog", "selectFood"]),
    addNutrients() {
      this.$store.dispatch("addNutrients", this.food)
    },
  }
}
</script>

<style scoped>

</style>