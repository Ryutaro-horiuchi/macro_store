<template>
  <v-container>
    <v-row>
      <v-col cols="10" offset="1" v-for="food in foods" :key="food.id">
        <v-card class="my-5" outlined> 
          <v-row justify="center">
            <v-col cols="4">
              <!-- <v-img :src="food.image.url"></v-img> -->
              <v-card-title class="text-h6">{{ food.name }}</v-card-title>
              <v-card-subtitle>税抜{{ food.price }}円</v-card-subtitle>
            </v-col>
            <v-col cols="6">
              <FoodBarChart :food="food"></FoodBarChart>
            </v-col>
          </v-row>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import { mapGetters } from "vuex";
import FoodBarChart from "./components/FoodBarChart.vue"

export default {
  components: {
    FoodBarChart
  },
  computed: {
    ...mapGetters(["foods"])
  }
}
</script>