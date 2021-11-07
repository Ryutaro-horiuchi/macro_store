<template>
  <div>
    <FoodSearchBar :name.sync="params.name"
                   @nameSearch="nameSearch"></FoodSearchBar>
    <v-container>
      <v-row justify="center">
        <v-col cols="10" class="text-left my-10">
          <h2>栄養素量から探す</h2>
          <v-form> 
            <v-container>
              <v-row class="my-5" justify="center">
                <v-col cols="5">
                  <v-text-field 
                    v-model.number="nutrients.proteinValue.minimum"
                    label="たんぱく質"
                    dense
                    placeholder="0g"
                    outlined />
                </v-col>
                <h2 class="my-5 text-center">~</h2>
                <v-col cols="5" class="ml-4">
                  <v-text-field
                    v-model.number="nutrients.proteinValue.maximum"
                    dense
                    placeholder="上限なし"
                    outlined />
                </v-col>
                <v-col cols="5">
                  <v-text-field 
                    v-model.number="nutrients.carboValue.minimum"
                    label="炭水化物"
                    dense
                    placeholder="0g"
                    outlined />
                </v-col>
                <h2 class="my-5 text-center">~</h2>
                <v-col cols="5" class="ml-4">
                  <v-text-field
                    v-model.number="nutrients.carboValue.maximum"
                    dense
                    placeholder="上限なし"
                    outlined />
                </v-col>
                <v-col cols="5">
                  <v-text-field 
                    v-model.number="nutrients.lipidValue.minimum"
                    label="脂質"
                    dense
                    placeholder="0g"
                    outlined />
                </v-col>
                <h2 class="my-5 text-center">~</h2>
                <v-col cols="5" class="ml-4">
                  <v-text-field
                    v-model.number="nutrients.lipidValue.maximum"
                    dense
                    placeholder="上限なし"
                    outlined />
                </v-col>
              </v-row>
            </v-container>
          </v-form>        
        </v-col>
      </v-row>
      <v-row>
        <v-col col="10" offset="1" class="text-left my-10"> 
          <h2>登録した数値から探す</h2>
        </v-col>
      </v-row>
      <v-row justify="center">
        <!-- <v-col cols="10"> -->
          <v-col cols="3" offset="1">
            <v-btn
              class="mx-auto"
              x-large
              outlined
              elevation="3">
            クリア
            </v-btn>
          </v-col>
          <v-col cols="3">
            <v-btn
              class="mx-auto"
              x-large
              outlined
              elevation="3"
              @click="nutrientsSearch">
            この条件で検索
            </v-btn>
          </v-col>
        <!-- </v-col> -->
      </v-row>
    </v-container>
  </div>
</template>

<script>
import FoodSearchBar from "./components/FoodSearchBar.vue"

export default {
  data() {
    return {
      params: { name: '' },
      nutrients: {
        proteinValue: { minimum: null, maximum: null },
        carboValue: { minimum: null, maximum: null },
        lipidValue: { minimum: null, maximum: null },
      } 
    }
  },
  components: {
    FoodSearchBar
  },
  methods: {
    nameSearch() {
      this.$store.dispatch("nameSearch", this.params)
    },
    nutrientsSearch() {
      this.$store.dispatch("nutrientsSearch", this.nutrients)
    }
  }
}
</script>

<style scoped>
h2 {
  font-weight: normal;
}
</style>