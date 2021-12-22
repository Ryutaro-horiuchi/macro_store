<template>
  <div style="margin-top: 100px; margin-bottom: 150px;">
    <v-container
      v-if="isSelected"
    >
      <h2 class="text-left">
        以下の食品を選択しています
      </h2>
      <FoodCurrentNutrient />
      <v-row justify="center">
        <v-col
          v-for="food in selectFoods"
          :key="food.id"
          cols="11"
        >
          <v-card
            class="my-5"
            outlined
            @click="openDialog(food)"
          >
            <v-row justify="center">
              <v-col
                cols="4"
                md="5"
              >
                <v-img :src="food.image.url" />
                <v-card-subtitle class="text-xs-body-1 text-md-h5">
                  {{ food.name }}
                </v-card-subtitle>
                <v-card-subtitle class="text-xs-body-1 text-md-h6">
                  税抜{{ food.price }}円<br>
                  {{ food.calorie }}kcal
                </v-card-subtitle>             
              </v-col>
              <v-col
                cols="8"
                md="5"
              >
                <FoodBarChart
                  :key="food.id"
                  :food="food" 
                />
              </v-col>
            </v-row>
            <v-row justify="center">
              <v-col
                cols="3"
                md="2"
              >
                <v-select
                  :items="items"
                  :value="food.quantity"
                  label="数量"
                  @click.stop
                  @change="multiplyNutrient(food, $event)"
                />                        
              </v-col>
              <v-col
                cols="3"
                md="2"
                offset="2"
                class="my-auto"
              >
                <v-btn
                  icon
                  @click.stop="removeConfirm(food)"
                >
                  <v-icon
                    color="blue darken-1"
                    x-large
                  >
                    mdi-trash-can
                  </v-icon>
                </v-btn>              
              </v-col>
            </v-row>
          </v-card>
        </v-col>
      </v-row>
      <!-- width="600" -->
      <v-dialog
        v-model="foodDialog"
        persistent
        @click:outside="closeDialog"
      >
        <Dialog />
      </v-dialog>
      <v-row
        justify="center"
        class="mb-2"
      >
        <v-col
          cols="4"
        >
          <v-row justify="center">
            <v-btn
              color="#1c65ac"
              dark
              x-large
              elevation="3"
            >
              戻る
            </v-btn> 
          </v-row>
        </v-col>
        <v-col
          cols="4"
        >
          <v-row justify="center">  
            <v-btn
              color="#1c65ac"
              dark
              x-large
              elevation="3"
              @click="openEndDialog"
            >
              決定
            </v-btn>
          </v-row>
        </v-col>
      </v-row>
    </v-container>
    <v-dialog
      v-model="endDialog"
      persistent
      @click:outside="closeEndDialog"
    >
      <EndDialog />
    </v-dialog>
    <v-container
      v-if="!isSelected"
    >
      <v-row justify="center">
        <v-col cols="12">
          <h2 class="text-center">
            選択した食品がありません
          </h2>
        </v-col>
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
      </v-row>
    </v-container>
  </div>
</template>

<script>
import { mapGetters, mapActions } from "vuex";
import FoodCurrentNutrient from './components/FoodCurrentNutrient.vue';
import FoodBarChart from './components/FoodBarChart.vue';
import Dialog from './dialog.vue';
import EndDialog from './endDialog.vue'

export default {
  components: {
    FoodCurrentNutrient, FoodBarChart, Dialog, EndDialog
  },
  data() {
    return {
      items: [1, 2, 3, 4, 5]
    }
  },
  computed: {
    ...mapGetters(["foods", "selectFoods", "foodDialog", "endDialog"]),
    isSelected() {
      return this.selectFoods.length !== 0
    }
  },
  methods: {
    ...mapActions(["openDialog", "closeDialog", "deleteFood", "openEndDialog", "closeEndDialog"]),
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
