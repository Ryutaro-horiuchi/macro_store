<template>
  <div>
    <v-container
      pt-0
      fluid
      class="top-page"
    >
      <v-row>
        <v-col
          cols="10"
          md="12"
          class="logo"
        > 
          <v-img
            :src="logoImg"
            max-height="300"
            max-width="600"
          />
        </v-col>
      </v-row>
    </v-container>
    <v-container mt-15>
      <v-row>
        <v-col>
          <div
            class="text-center text-h5 text-md-h3"
            style="margin-bottom: 80px; margin-top: 50px;"
          >
            Macro Storeでできること
          </div>
        </v-col>
      </v-row>
      <v-row
        class="my-10"
        align-content="center"
      >
        <v-col
          cols="6"
          md="5"
          offset-md="1"
        >
          <div class="text-left text-body-1 text-md-h5 font-weight-bold">
            検索機能
          </div>
          <br>
          <div class="text-left text-body-2 text-md-h6">
            コンビニ食品を名前で検索したり、摂取したい栄養素量（炭水化物、たんぱく質、脂質別)に検索できます。
          </div>
        </v-col>
        <v-col cols="6">
          <v-img
            :src="foodImg"
            max-height="300"
            max-width="400"
            contain
          />
        </v-col>
      </v-row>
      <v-divider />
      <v-row
        class="my-10"
        align-content="center"
        justify="center"
      >
        <v-col
          cols="6"
          md="5"
          offset-md="1"
        >
          <v-img
            :src="dataImg"
            max-height="300"
            max-width="400"
          />
        </v-col>
        <v-col
          cols="6"
          md="5"
        >
          <div class="text-left text-body-1 text-md-h5 font-weight-bold">
            カロリー計算機能
          </div>
          <br>
          <div class="text-left text-body-2 text-md-h6">
            4つの質問に答えることで、ダイエットに有効な１食分の摂取カロリーの目安を知ることができます。
          </div>
        </v-col>
      </v-row>
      <v-divider />
      <v-row
        class="my-10"
        align-content="center"
      >
        <v-col
          cols="6"
          md="5"
          offset-md="1"
        >
          <div class="text-left text-body-1 text-md-h5 font-weight-bold">
            その他にも...
          </div>
          <br>
          <div class="text-left text-body-2 text-md-h6">
            会員登録をすると食品のお気に入り保存や、自分の摂取カロリー量を保存して、検索できるようになります。(仮リリース版では未実装)
          </div>
        </v-col>
        <v-col cols="6">
          <v-img
            :src="swipeImg"
            max-height="300"
            max-width="400"
            contain
          />
        </v-col>
      </v-row>
    </v-container>
    <v-container style="margin-top: 50px; margin-bottom: 200px">
      <div
        class="text-center text-h5 text-md-h3"
        style="margin-top: 100px; margin-bottom: 100px;"
      >
        カロリー計算から始めよう
      </div>
      <CalCalculation />
    </v-container>
  </div>
</template>

<script>
import CalCalculation from "./components/CalCalculation.vue";

export default {
  components: {
    CalCalculation,
  },
  data() {
    return {
      foodImg: require("../../../assets/images/undraw_online_groceries_a02y (1).png"),
      dataImg: require("../../../assets/images/undraw_app_data_re_vg5c (2).png"),
      swipeImg: require("../../../assets/images/undraw_swipe_options_2e4v (2).png"),
      logoImg: require("../../../assets/images/MacroStore-logo.png")
    }
  }
}

</script>

<style scoped>
.top-page {
  background: url("../../../assets/images/shellfish-pasta-pizza-and-italian-food.jpg");
  background-size: cover;
  background-position: center;
  position: relative;
  width: 100%;
  height: 80vh;
}

.top-page::before {
  background-color: rgba(0,0,0,0.4);
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  content: '';
}

.logo {
  position: absolute;
  left: 20px;
  top: 90px
}

.text-center {
  color: #D63D17;
}

.text-left {
  line-height: 200%;
}
</style>