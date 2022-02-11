<template>
  <div style="margin-top: 100px; margin-bottom: 100px">
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
      <v-container class="mt-14">
        <v-row justify="center">
          <v-col
            cols="10"
            offset="1"
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
              class="text-color text-center text-h6 text-md-h4"
              style="margin-top: 100px; margin-bottom: 30px"
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
          style="margin-bottom: 150px"
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
            @loading="loading = $event"
            @search-nutrient="searchNutrient"
            @null-validation="nullValidation = $event"
            @error-message="errorMessage = $event"
          />
        </v-row>
      </v-container>
    </template>
    <v-dialog
      v-model="updateDialog"
      width="600"
      persistent
      @click:outside="closeDialog"
    >
      <v-card
        width="600"
        height="200"
      >
        <v-container>
          <v-card-text class="text-h6 text-md-h5">
            今回の計算結果を保存しますか？
          </v-card-text>
          <v-row style="margin-top: 20px">
            <v-col cols="6">
              <v-row justify="center">
                <v-btn
                  color="#1c65ac"
                  dark
                  large
                  elevation="3"
                  @click="closeDialog"
                >
                  閉じる
                </v-btn>
              </v-row>
            </v-col>
            <v-col cols="6">
              <v-row justify="center">
                <v-btn
                  color="#1c65ac"
                  dark
                  large
                  elevation="3"
                  @click="turnOnCalculationResultParams"
                >
                  保存する
                </v-btn>
              </v-row>
            </v-col>
          </v-row>
        </v-container>
      </v-card>
    </v-dialog>
  </div>
</template>

<script>
import { mapGetters, mapActions } from "vuex";
import FoodNutrientSearchForm from "../food/components/FoodNutrientSearchForm.vue";

export default {
  components: {
    FoodNutrientSearchForm,
  },
  data() {
    return {
      loading: false,
      nullValidation: false,
      errorMessage: null,
      updateDialog: false,
      params: {}
    }
  },
  computed: {
    ...mapGetters(["ingestionCal", "user"])
  },
  created() {
    this.checkDialog();
  },
  methods: {
    ...mapActions(["update"]),
    turnOnCalculationResultParams() {
      Object.assign(this.params, this.ingestionCal);
      this.update(this.params);
    },
    checkDialog() {
      if (this.user) {
        setTimeout(() => {
          this.updateDialog = true;
        }, 1500);
      }
    },
    closeDialog() {
      this.updateDialog = false;
    },
    searchNutrient(nutrients) {
      this.$store.dispatch("searchNutrient", nutrients)
    }
  },
};
</script>

<style scoped>
.text-color {
  color: #d63d17;
}
.error_message {
  color: red;
}
.loader {
  margin-top: 200px;
}
</style>