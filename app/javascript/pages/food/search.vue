<template>
  <v-container fluid pt-0>
  <FoodSearchBar
    :name.sync="params.name"
    @nameSearch="nameSearch"
  />
    <v-row justify="center">
      <v-col
        cols="10"
        class="text-left my-10"
      >
        <h2>栄養素量から探す</h2>
        <v-form
            ref="form"
        > 
          <v-container>
            <v-row
              class="my-5"
              justify="center"
            >
              <v-col cols="5">
                <v-text-field 
                  v-model.number="nutrients.proteinValue.minimum"
                  label="たんぱく質"
                  dense
                  placeholder="0g"
                  outlined
                  :rules="rules"
                />
              </v-col>
              <h2 class="my-5 text-center">
                &sim;
              </h2>
              <v-col
                cols="5"
              >
                <v-text-field
                  v-model.number="nutrients.proteinValue.maximum"
                  dense
                  placeholder="上限なし"
                  outlined
                  :rules="rules"
                />
              </v-col>
              <v-col cols="5">
                <v-text-field 
                  v-model.number="nutrients.carboValue.minimum"
                  label="炭水化物"
                  dense
                  placeholder="0g"
                  outlined
                  :rules="rules"
                />
              </v-col>
              <h2 class="my-5 text-center">
                &sim;
              </h2>
              <v-col
                cols="5"
              >
                <v-text-field
                  v-model.number="nutrients.carboValue.maximum"
                  dense
                  placeholder="上限なし"
                  outlined
                  :rules="rules"
                />
              </v-col>
              <v-col cols="5">
                <v-text-field 
                  v-model.number="nutrients.lipidValue.minimum"
                  label="脂質"
                  dense
                  placeholder="0g"
                  outlined
                  :rules="rules"
                />
              </v-col>
              <h2 class="my-5 text-center">
                &sim;
              </h2>
              <v-col
                cols="5"
              >
                <v-text-field
                  v-model.number="nutrients.lipidValue.maximum"
                  dense
                  placeholder="上限なし"
                  outlined
                  :rules="rules"
                />
              </v-col>
            </v-row>
          </v-container>
        </v-form>        
      </v-col>
    </v-row>
    <v-row justify="center">
      <!-- <v-col cols="10"> -->
      <v-col
        cols="6"
      >
        <v-row
          justify="center"
          class="ma-5"
        >
          <v-btn
            class="mx-auto"
            x-large
            outlined
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
            x-large
            outlined
            elevation="3"
            @click="nutrientsSearch"
          >
            この条件で検索
          </v-btn>
        </v-row>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import FoodSearchBar from "./components/FoodSearchBar.vue"

export default {
  components: {
    FoodSearchBar
  },
  data() {
    return {
      params: { name: '' },
      rules: [
        v => /^[\d]+$/.test(v) || '',
        v => /^[\d]{1,3}$/.test(v) || '1桁〜3桁の間で入力してください'
      ],
      nutrients: {
        proteinValue: { minimum: null, maximum: null },
        carboValue: { minimum: null, maximum: null },
        lipidValue: { minimum: null, maximum: null },
      } 
    }
  },
  methods: {
    reset() {
      this.$refs.form.reset()
    },
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