<template>
  <div>
    <template v-if="loading">
      <v-row
        justify="center"
        class="loader mt-14"
      >
        <vue-loaders-line-spin-fade-loader
          color="#D63D17" 
          scale="2"
        />
      </v-row>
    </template>
    <v-container class="mt-14">
      <v-row justify="center">
        <v-col
          cols="10"
          offset="1"
          class="mt-10"
        >
          <div class="text-left text-h6 text-md-h5">
            ダイエットに有効な1食の摂取カロリーの目安は・・・？
          </div>
        </v-col>
        <v-col
          cols="10"
          class="mt-15"
        >
          <h1 class="text-color text-center">
            {{ ingestionCal["calorie"] }}kcal
          </h1>
        </v-col>
        <v-col
          cols="10"
          offset="1"
          class="mt-10"
        >
          <div class="text-left text-h6 text-md-h5">
            あなたの1食の各栄養素の目安は・・・？
          </div>
        </v-col>
        <v-col
          cols="10"
          class="mt-15"
        >
          <h2 class="text-color text-center">
            たんぱく質{{ ingestionCal["protein"] }}g
          </h2>
        </v-col>
        <v-col
          cols="10"
          class="mt-15"
        >
          <h2 class="text-color text-center">
            炭水化物{{ ingestionCal["carbohydrate"] }}g
          </h2>
        </v-col>
        <v-col
          cols="10"
          class="mt-15"
        >
          <h2 class="text-color text-center">
            脂質{{ ingestionCal["lipid"] }}g
          </h2>
        </v-col>
        <v-col
          cols="10"
          class="mt-15"
        >
          <p class="text-body-2 text-md-body-1">
            ※数値はあくまで目安です。参考にして体重が増えるようであれば、摂取量を減らしてみるなど、
            調整してみましょう。
          </p>
        </v-col>
      </v-row>
    </v-container>
    <v-container>
      <v-row>
        <v-col
          cols="10"
          offset="1"
        >
          <div
            class="text-color text-center text-h5 text-md-h4"
            style="margin-top: 200px; margin-bottom: 80px;"
          >
            数値を元に検索してみましょう
          </div>
          <p class="text-body-2 text-md-body-1">
            ※上記の数値を参考に、値が入力されています。画面下部にある<strong>「この条件で検索」</strong>ボタンを押してください。
          </p>
        </v-col>
      </v-row>
      <v-row
        justify="center"
        style="margin-bottom: 150px;"
      >
        <template v-if="nullValidation">
          <v-container class="mt-5">
            <v-row
              justify="center"
              class="error_message"
            >
              {{ errorMessage }}
            </v-row>
          </v-container>
        </template>
        <FoodNutrientSearchForm 
          :carbohydrate-minimum.sync="nutrients.carbohydrateValue.minimum"
          :carbohydrate-maximum.sync="nutrients.carbohydrateValue.maximum"
          :protein-minimum.sync="nutrients.proteinValue.minimum"
          :protein-maximum.sync="nutrients.proteinValue.maximum"
          :lipid-minimum.sync="nutrients.lipidValue.minimum"
          :lipid-maximum.sync="nutrients.lipidValue.maximum"
          @search-nutrient="searchNutrient"
        />
      </v-row>
    </v-container>
  </div>
</template>

<script>
import { mapGetters } from "vuex";
import FoodNutrientSearchForm from "../food/components/FoodNutrientSearchForm.vue"

export default {
  components: {
    FoodNutrientSearchForm
  },
  data() {
    return {
      loading: false,
      nullValidation: false,
      errorMessage: null,
      nutrients: {
        proteinValue: { minimum: null, maximum: null },
        carbohydrateValue: { minimum: null, maximum: null },
        lipidValue: { minimum: null, maximum: null },
      },
    }
  },
  computed: {
    ...mapGetters(["ingestionCal"]),
  },
  created() {
    if (this.ingestionCal.protein) {
      this.nutrients.proteinValue.minimum = this.ingestionCal.protein - 20
      this.nutrients.proteinValue.maximum = this.ingestionCal.protein
      this.nutrients.carbohydrateValue.minimum = this.ingestionCal.carbohydrate - 30
      this.nutrients.carbohydrateValue.maximum = this.ingestionCal.carbohydrate
      this.nutrients.lipidValue.minimum　= this.ingestionCal.lipid - 10
      this.nutrients.lipidValue.maximum　= this.ingestionCal.lipid
    }
  },
  methods: {
    toSearchPage() {
      this.$router.push('/search')
    },
      checkNumericNull() {
      let array = []
      Object.values(this.nutrients.proteinValue).forEach(function (value) {
        array.push(value)
      })
      Object.values(this.nutrients.carbohydrateValue).forEach(function (value) {
        array.push(value)
      })
      Object.values(this.nutrients.lipidValue).forEach(function (value) {
        array.push(value)
      })
      array = array.filter(v => v)
      return array.length ? true : false
    },
    searchNutrient() {

      if (this.checkNumericNull()) {
        this.loading = true
        this.$store.dispatch("searchNutrient", this.nutrients) 
      } else {
        this.nullValidation = true
        this.errorMessage = "数値を入力してください"
      }
    }
  }
}
</script>

<style scoped>
.text-color {
  color: #D63D17;
}
.error_message {
  color: red;
}
</style>