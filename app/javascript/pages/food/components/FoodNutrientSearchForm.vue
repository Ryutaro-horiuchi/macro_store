<template>
  <v-container class="mt-5">
    <v-row justify="center">
      <v-col
        cols="10"
        class="text-left"
      >
        <div class="text-left text-h6 text-md-h4">
          栄養素量から探す
        </div>
        <slot />
        <v-form
          ref="form"
        > 
          <v-container>
            <v-row
              justify="center"
            >
              <v-col cols="5">
                <label>たんぱく質</label>
                <v-text-field 
                  id="proteinMin"
                  v-model.number="setProteinMinimum"
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
                  id="proteinMax"
                  v-model.number="setProteinMaximum"
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
                  id="carboMin"
                  v-model.number="setCarbohydrateMinimum"
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
                  id="carboMax"
                  v-model.number="setCarbohydrateMaximum"
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
                  id="lipidMin"
                  v-model.number="setLipidMinimum"
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
                  id="lipidMax"
                  v-model.number="setLipidMaximum"
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
  </v-container>
</template>

<script>
export default {
  props: {
    proteinMinimum: {
      type: Number,
      default: null
    },
    proteinMaximum: {
      type: Number,
      default: null
    },
    carbohydrateMinimum: {
      type: Number,
      default: null
    },
    carbohydrateMaximum: {
      type: Number,
      default: null
    },
    lipidMinimum: {
      type: Number,
      default: null
    },
    lipidMaximum: {
      type: Number,
      default: null
    },
  },
  data() {
    return {
      rules: [
        v => /^[\d]{1,3}$/.test(v) || '1桁〜3桁の半角英数字で入力してください'
      ],
    }
  },
  computed: {
    setProteinMinimum: {
      get () { return this.proteinMinimum },
      set (newVal) { return this.$emit('update:protein-minimum', newVal) }
    },
    setProteinMaximum: {
      get () { return this.proteinMaximum },
      set (newVal) { return this.$emit('update:protein-maximum', newVal) }
    },
    setCarbohydrateMinimum: {
      get () { return this.carbohydrateMinimum },
      set (newVal) { return this.$emit('update:carbohydrate-minimum', newVal) }
    },
    setCarbohydrateMaximum: {
      get () { return this.carbohydrateMaximum },
      set (newVal) { return this.$emit('update:carbohydrate-maximum', newVal) }
    },
    setLipidMinimum: {
      get () { return this.lipidMinimum },
      set (newVal) { return this.$emit('update:lipid-minimum', newVal) }
    },
    setLipidMaximum: {
      get () { return this.lipidMaximum },
      set (newVal) { return this.$emit('update:lipid-maximum', newVal) }
    },
  },
  methods: {
    reset() {
      this.$refs.form.reset()
    },
    searchNutrient() {
      this.$emit('search-nutrient')
    }
  }
}
</script>