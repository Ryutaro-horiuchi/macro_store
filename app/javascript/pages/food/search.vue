<template>
  <v-container
    fluid
    pt-0
    style="margin-bottom: 150px;"
  >
    <template v-if="loading">
      <v-row
        justify="center"
        class="loader"
      >
        <vue-loaders-line-spin-fade-loader
          color="#D63D17" 
          scale="2"
        />
      </v-row>
    </template>
    <template v-if="!loading">
      <FoodNameSearchForm
        :name.sync="params.name"
        @searchName="searchName"
      />
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
      >
        <p class="text-body-2 text-md-body-1">
          ※摂取カロリー計算の質問に応えていただくと、おすすめの数値が反映されます。
        </p>
      </FoodNutrientSearchForm>
    </template>
  </v-container>
</template>

<script>
import FoodNameSearchForm from "./components/FoodNameSearchForm.vue"
import FoodNutrientSearchForm from "./components/FoodNutrientSearchForm.vue"
import { mapGetters } from "vuex";

export default {
  components: {
    FoodNameSearchForm,
    FoodNutrientSearchForm
  },
  data() {
    return {
      loading: false,
      errorMessage: null,
      nullValidation: false,
      params: { name: null },
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
    this.nutrients.proteinValue.minimum = this.ingestionCal.protein - 30
    this.nutrients.proteinValue.maximum = this.ingestionCal.protein
    this.nutrients.carbohydrateValue.minimum = this.ingestionCal.carbohydrate - 30
    this.nutrients.carbohydrateValue.maximum = this.ingestionCal.carbohydrate
    this.nutrients.lipidValue.minimum　= this.ingestionCal.lipid - 10
    this.nutrients.lipidValue.maximum　= this.ingestionCal.lipid
    }

  },
  methods: {
    // 名前フォームのnullチェック。
    checkStringNull() {
      return this.params.name?  true : false
    },
    // 栄養素フォームのnullチェック。全てnullだった場合falseを返す
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
      array = array.filter(v => !!v)
      return array.length ? true : false
    },
    searchName() {
      if (this.checkStringNull()) {
        this.loading = true
        this.$store.dispatch("searchName", this.params)
      } else {
        this.nullValidation = true
        this.errorMessage = "文字を入力してください"
      }
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
h2 {
  font-weight: normal;
}
.loader {
  margin-top: 200px;
}
.error_message {
  color: red;
}
</style>