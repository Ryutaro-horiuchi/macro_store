<template>
  <div>
    <v-container v-if="isSelected">
        <h2 class="text-left mt-10">以下の食品を選択しています</h2>
      <FoodCurrentNutrient />
      <v-row justify="center">
        <v-col
          v-for="food in selectFoods"
          :key="food.id"
          cols="10"
          offset="1"
        >
          <v-card
            class="my-5"
            outlined
            @click="openDialog(food)"
          >
            <v-row justify="center">
              <template>
                <v-col cols="4">
                  <!-- <v-img :src="food.image.url"></v-img> -->
                  <v-card-title class="text-h5">
                    {{ food.name }}
                  </v-card-title>
                  <v-card-subtitle class="text-h6">
                    税抜{{ food.price }}円
                  </v-card-subtitle>
                  <v-card-subtitle class="text-h6">
                    {{ food.calorie }}kcal
                  </v-card-subtitle>
                  <v-row justify="center">
                    <v-col cols="6">
                      <v-select
                        :items="items"
                        :value="food.quantity"
                        label="数量"
                        @click.stop
                        @change="multiplyNutrient(food, $event)"
                      ></v-select>                        
                    </v-col>
                  </v-row>             
                </v-col>
                <v-col cols="6">
                  <FoodBarChart :food="food"
                                :key="food.id" 
                  />
                </v-col>
              </template>
              <v-col cols="2" class="my-auto">
                <v-btn
                  icon
                  @click.stop="removeConfirm(food)"
                >
                  <v-icon color="blue darken-1" x-large>mdi-trash-can</v-icon>
                </v-btn>              
              </v-col>
            </v-row>
          </v-card>
        </v-col>
      </v-row>
      <v-dialog
        v-model="foodDialog"
        width="600"
        max-height="300"
        persistent
        @click:outside="closeDialog"
      >
        <Dialog />
      </v-dialog>
      <v-row justify="center">
        <v-btn
          class="mx-15"
          x-large
          outlined
          elevation="3"
          cols="4"
          offset="1"
          @click="toFoodResultPage"
        >
          戻る
        </v-btn>
        <v-btn
          class="mx-15"
          x-large
          outlined
          elevation="3"
          cols="4"
          offset="1"
        >
          <!-- v-model="endDialog" -->
          決定
        </v-btn>
      </v-row>
    </v-container>
    <v-dialog
        width="600"
        max-height="300"
        persistent
      >
        <!-- v-model="endDialog" -->

        <!-- <EndDialog /> -->
      </v-dialog>
    <v-container v-if="!isSelected">
      <v-row justify="center">
        <v-col cols="12">
          <h2 class="text-center mt-10">選択した食品がありません</h2>
        </v-col>
        <v-row justify="center" class="mt-10">
            <v-btn
              class="mx-auto"
              x-large
              outlined
              elevation="3"
              @click="toSearchPage"
            >
              食品を探す
            </v-btn>
        </v-row>
      </v-row>
    </v-container>
  </div>
</template>

<script>
import { mapGetters, mapActions } from "vuex";
import FoodCurrentNutrient from './components/FoodCurrentNutrient.vue';
import FoodBarChart from './components/FoodBarChart.vue';
import Dialog from './dialog.vue';

export default {
  data() {
    return {
      items: [1, 2, 3, 4, 5]
    }
  },
  components: {
    FoodCurrentNutrient, FoodBarChart, Dialog
  },
  computed: {
    ...mapGetters(["foods", "selectFoods", "foodDialog"]),
    isSelected() {
      return this.selectFoods.length !== 0
    }
  },
  methods: {
    ...mapActions(["openDialog", "closeDialog", "deleteFood"]),
    toFoodResultPage() {
      this.$router.push('/foods')
    },
    toSearchPage() {
      this.$router.push('/search')
    },
    removeConfirm(food) {
      if (confirm('削除してもよろしいですか？')) {
        this.removeNutrients(food)
        this.deleteFood(food)
      }
    },
    removeNutrients(food) {
      this.$store.dispatch("removeNutrients", food)
    },
    multiplyNutrient(food, number) {
      // 新しく選択した数値から、以前の数値をひく
      const calculatedNumber = number - food.quantity
      const multiplyData = [calculatedNumber, food, number]
      this.$store.dispatch("multiplyNutrient", multiplyData)
    }
  }
}
</script>
