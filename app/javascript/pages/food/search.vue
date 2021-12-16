<template>
  <v-container
    fluid
    pt-0
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
      <FoodSearchBar
        :name.sync="params.name"
        @searchName="searchName"
      />
      <v-row justify="center">
        <v-col
          cols="10"
          class="text-left my-10"
        >
          <h2>栄養素量から探す</h2>
          <template v-if="nullValidation">
            <v-container>
              <v-row
                justify="center"
                class="error_message"
              >
                {{ errorMessage }}
              </v-row>
            </v-container>
          </template>
          <v-form
            ref="form"
          > 
            <v-container>
              <v-row
                class="my-5"
                justify="center"
              >
                <v-col cols="5">
                  <label>たんぱく質</label>
                  <v-text-field 
                    v-model.number="nutrients.proteinValue.minimum"
                    dense
                    background-color="white"
                    placeholder="0"
                    outlined
                    :rules="rules"
                  />
                </v-col>
                <h2 class="my-10 text-center">
                  &sim;
                </h2>
                <v-col
                  cols="5"
                >
                  <v-text-field
                    v-model.number="nutrients.proteinValue.maximum"
                    dense
                    background-color="white"      
                    placeholder="上限なし"
                    outlined
                    :rules="rules"
                    class="my-6"
                  />
                </v-col>
                <v-col cols="5">
                  <label>炭水化物</label>
                  <v-text-field 
                    v-model.number="nutrients.carbohydrateValue.minimum"
                    dense
                    background-color="white"
                    placeholder="0"
                    outlined
                    :rules="rules"
                  />
                </v-col>
                <h2 class="my-10 text-center">
                  &sim;
                </h2>
                <v-col
                  cols="5"
                >
                  <v-text-field
                    v-model.number="nutrients.carbohydrateValue.maximum"
                    dense
                    background-color="white"
                    placeholder="上限なし"
                    outlined
                    :rules="rules"
                    class="my-6"
                  />
                </v-col>
                <v-col cols="5">
                  <label>脂質</label>
                  <v-text-field 
                    v-model.number="nutrients.lipidValue.minimum"
                    dense
                    background-color="white"
                    placeholder="0"
                    outlined
                    :rules="rules"
                  />
                </v-col>
                <h2 class="my-10 text-center">
                  &sim;
                </h2>
                <v-col
                  cols="5"
                >
                  <v-text-field
                    v-model.number="nutrients.lipidValue.maximum"
                    dense
                    background-color="white"
                    placeholder="上限なし"
                    outlined
                    :rules="rules"
                    class="mt-6"
                  />
                </v-col>
              </v-row>
            </v-container>
          </v-form>        
        </v-col>
      </v-row>
      <v-row justify="center">
        <v-col
          cols="6"
        >
          <v-row
            justify="center"
            class="ma-5"
          >
            <v-btn
              class="mx-auto"
              color="#1c65ac"
              dark
              x-large
              elevation="3"
              @click="reset"
            >
              クリア
            </v-btn>
          </v-row>
        </v-col>
        <v-col
          cols="6"
        >
          <v-row
            justify="center"
            class="ma-5"
          >
            <v-btn
              class="mx-auto"
              color="#1c65ac"
              dark
              x-large
              elevation="3"
              @click="searchNutrient"
            >
              この条件で検索
            </v-btn>
          </v-row>
        </v-col>
      </v-row>
    </template>
  </v-container>
</template>

<script>
import FoodSearchBar from "./components/FoodSearchBar.vue"

export default {
  components: {
    FoodSearchBar,
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
      rules: [
        v => /^[\d]{1,3}$/.test(v) || '1桁〜3桁の半角英数字で入力してください'
      ],
    }
  },
  methods: {
    reset() {
      this.$refs.form.reset()
    },
    // 名前フォームのnullチェック。
    checkStringNull() {
      return this.params.name?  true : false
    },
    // 栄養素フォームのnullチェック。全てnullだった場合falseを返す
    checkNumericNull() {
      let array = []
      Object.values(this.nutrients.proteinValue).forEach(function (values) {
        array.push(values)
      })
      Object.values(this.nutrients.carbohydrateValue).forEach(function (values) {
        array.push(values)
      })
      Object.values(this.nutrients.lipidValue).forEach(function (values) {
        array.push(values)
      })
      array = array.filter(v => v)
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
  margin-top: 300px;
}
.error_message {
  color: red;
}
</style>