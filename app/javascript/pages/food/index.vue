<template>
  <v-container>
    <v-row>
      <v-col cols="10" offset="1" v-for="food in foods">
        <v-card class="my-5" outlined> 
          <v-row justify="center">
            <v-col cols="5">
              <!-- <v-img :src="food.image.url"></v-img> -->
              <v-card-title class="text-h6">{{ food.name }}</v-card-title>
              <v-card-subtitle>税抜{{ food.price }}円</v-card-subtitle>
            </v-col>
            <v-col cols="5">
              <v-card-text class="">タンパク質 {{ food.protein }}g</v-card-text>
              <v-card-text>炭水化物 {{ food.carbohydrate }}g</v-card-text>
              <v-card-text>脂質 {{ food.lipid }}g</v-card-text>
            </v-col>
          </v-row>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import { mapGetters } from "vuex";

export default {
  computed: {
    ...mapGetters(["foods"])
  },
}
</script>