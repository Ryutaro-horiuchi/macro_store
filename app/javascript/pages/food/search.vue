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
          color="#00ADB5" 
          scale="2"
        />
      </v-row>
    </template>
    <template v-if="!loading">
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
          <p>※数値を入力してください</p>
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
                    placeholder="上限なし"
                    outlined
                    :rules="rules"
                    class="my-6"
                  />
                </v-col>
                <v-col cols="5">
                  <label>炭水化物</label>
                  <v-text-field 
                    v-model.number="nutrients.carboValue.minimum"
                    dense
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
                    v-model.number="nutrients.carboValue.maximum"
                    dense
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
              color="#00ADB5"
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
              color="#00ADB5"
              dark
              x-large
              elevation="3"
              @click="nutrientsSearch"
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
import { mapGetters } from 'vuex';

export default {
  components: {
    FoodSearchBar,
  },
  data() {
    return {
      loading: false,
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
  computed: {
  },
  methods: {
    reset() {
      this.$refs.form.reset()
    },
    nameSearch() {
      this.loading = true
      this.$store.dispatch("nameSearch", this.params)
      
    },
    nutrientsSearch() {
      this.loading = true
      this.$store.dispatch("nutrientsSearch", this.nutrients)
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
</style>