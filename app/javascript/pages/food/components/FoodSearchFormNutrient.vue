<template>
  <v-container class="mt-5">
    <v-row justify="center">
      <v-col
        cols="10"
        class="text-left"
      >
        <div class="text-left text-h6 text-md-h4">
          栄養素から探す
        </div>
        <slot />
        <v-form ref="form">
          <v-container>
            <v-row justify="center">
              <v-col cols="5">
                <label>たんぱく質</label>
                <v-text-field
                  id="proteinMin"
                  v-model.number="nutrients.proteinMinimum"
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
              <v-col cols="5">
                <v-text-field
                  id="proteinMax"
                  v-model.number="nutrients.proteinMaximum"
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
                  v-model.number="nutrients.carbohydrateMinimum"
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
              <v-col cols="5">
                <v-text-field
                  id="carboMax"
                  v-model.number="nutrients.carbohydrateMaximum"
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
                  v-model.number="nutrients.lipidMinimum"
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
              <v-col cols="5">
                <v-text-field
                  id="lipidMax"
                  v-model.number="nutrients.lipidMaximum"
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
      <v-col cols="6">
        <v-row justify="center">
          <BaseButton @my-click="reset">
            クリア
          </BaseButton>
        </v-row>
      </v-col>
      <v-col cols="6">
        <v-row justify="center">
          <BaseButton @my-click="searchNutrient">
            この条件で検索
          </BaseButton>
        </v-row>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import { mapGetters } from "vuex";
import BaseButton from "../../../components/BaseButton.vue"

export default {
  components: {
    BaseButton
  },
  data() {
    return {
      nutrients: {
        proteinMinimum: null,
        proteinMaximum: null,
        carbohydrateMinimum: null,
        carbohydrateMaximum: null,
        lipidMinimum: null,
        lipidMaximum: null,
      },
      rules: [
        (v) =>
          /^[\d]{1,3}$/.test(v) || "1桁〜3桁の半角英数字で入力してください",
      ],
    };
  },
  computed: {
    ...mapGetters(["ingestionCal", "user"]),
  },
  created() {
    this.turnOnValueForm();
  },
  methods: {
    turnOnValueForm() {
      if (this.user && this.user.protein && (this.$route.path == '/search')) {
        this.nutrients.proteinMinimum = this.user.protein - 30;
        this.nutrients.proteinMaximum = this.user.protein;
        this.nutrients.carbohydrateMinimum = this.user.carbohydrate - 30;
        this.nutrients.carbohydrateMaximum = this.user.carbohydrate;
        this.nutrients.lipidMinimum = this.user.lipid - 10;
        this.nutrients.lipidMaximum = this.user.lipid;
        this.checkNegative();
      } else if (this.ingestionCal) {
        this.nutrients.proteinMinimum = this.ingestionCal.protein - 30;
        this.nutrients.proteinMaximum = this.ingestionCal.protein;
        this.nutrients.carbohydrateMinimum = this.ingestionCal.carbohydrate - 30;
        this.nutrients.carbohydrateMaximum = this.ingestionCal.carbohydrate;
        this.nutrients.lipidMinimum = this.ingestionCal.lipid - 10;
        this.nutrients.lipidMaximum = this.ingestionCal.lipid;
        this.checkNegative();
      }
    },
    checkNegative() {
      Object.keys(this.nutrients).forEach((key) => {
        if (Math.sign(this.nutrients[key]) === -1) {
          this.nutrients[key] = 0;
        }
      });
    },
    reset() {
      this.$refs.form.reset();
    },
    // 栄養素フォームのnullチェック。全てnullだった場合falseを返す
    checkNumericNull() {
      let array = [];
      Object.values(this.nutrients).forEach(function (value) {
        array.push(value);
      });
      array = array.filter((v) => !!v);
      return array.length ? true : false;
    },
    searchNutrient() {
      if (this.checkNumericNull()) {
        this.$emit("loading", true);
        this.$emit("search-nutrient", this.nutrients);
      } else {
        this.$emit("null-validation", true)
        this.$emit("error-message", "数値を入力してください")
      }
    },
  }
};
</script>