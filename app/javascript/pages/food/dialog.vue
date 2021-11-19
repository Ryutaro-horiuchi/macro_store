<template>
  <v-card>
    <v-card-title class="text-h5 white">
      <p>{{ food.name }}</p>
      <v-spacer />
      <p>税抜{{ food.price }}円</p>
    </v-card-title>
    <v-card-subtitle class="text-h6 text-right">
      <p>{{ food.calorie }}kcal</p>
    </v-card-subtitle>
    <v-row justify="center">
      <v-col cols="10">
        <!-- <v-img :src="food.image.url" /> -->
      </v-col>
      <v-col cols="10">
        <FoodBarChart
          :key="food.id"
          :food="food"
        />
      </v-col>
      <template v-if="isNotSelected">
        <v-col
          cols="4"
          offset="1"
        >
          <v-btn
            class="mx-auto"
            x-large
            outlined
            elevation="3"
            @click="addNutrients(); selectFood(food)"
          >
            選択する
          </v-btn>
        </v-col>
      </template>
      <v-col
        cols="4"
        offset="1"
      >
        <v-btn
          class="mx-auto"
          x-large
          outlined
          elevation="3"
          @click="closeDialog"
        >
          閉じる
        </v-btn>
      </v-col>
    </v-row>
  </v-card>
</template>

<script>
import { mapActions, mapGetters } from "vuex";
import FoodBarChart from './components/FoodBarChart.vue'

export default {
  data() {
    return {
      add_nutrients: { calorie: 0, carbohydrate: 0, protein: 0, lipid: 0 }
    }
  },
  components: {
    FoodBarChart
  },
  computed: {
    ...mapGetters(["food_dialog", "food", "selectFoods"]),
    isNotSelected() {
      return !this.selectFoods.includes(this.food)
    }
  },
  methods: {
    ...mapActions(["closeDialog", "selectFood"]),
    addNutrients() {
      // this.add_nutrients["calorie"] = this.food.calorie
      // this.add_nutrients["carbohydrate"] = this.food.carbohydrate
      // this.add_nutrients["protein"] = this.food.protein
      // this.add_nutrients["lipid"] = this.food.lipid
      this.$store.dispatch("addNutrients", this.food)
    },
  }
}
</script>

<style scoped>

</style>