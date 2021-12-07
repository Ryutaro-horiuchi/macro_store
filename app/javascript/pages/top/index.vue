<template>
  <div>
    <v-container
      pt-0
      fluid
      class="top-page"
    >
      <FoodSearchBar />
      <v-container>
        <v-row>
          <v-col class="my-10">
            <h1>Macro Store</h1>
          </v-col>
        </v-row>
        <v-row>
          <v-col>
            <h2>
              コンビニ食品から<br>
              理想の体作りをサポート
            </h2>
          </v-col>
        </v-row>
      </v-container>
    </v-container>
    <v-container mt-15>
      <v-row>
        <v-col>
          <h1 class="text-center">
            what can I do ?
          </h1>
        </v-col>
      </v-row>
      <v-divider />
      <v-row
        class="my-10"
        align-content="center"
        justify="center"
      >
        <v-col cols="6">
          <h4 class="text-left">
            コンビニ食品を名前で検索したり、摂取したい栄養素量（炭水化物、たんぱく質、脂質別)に検索できます。
          </h4>
          <br>
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
      >
        <v-col cols="6">
          <v-img
            :src="dataImg"
            max-height="300"
            max-width="400"
            contain
          />
        </v-col>
        <v-col cols="6">
          <h4 class="text-left">
            4つの質問に答えることで、ダイエットに有効な１日の摂取カロリーの目安を知ることができます。
          </h4>
          <br>
        </v-col>
      </v-row>
      <v-divider />
      <v-row
        class="my-10"
        align-content="center"
      >
        <v-col cols="6">
          <h4 class="text-left">
            会員登録をすると食品のお気に入り保存や、自分の摂取カロリー量を保存して、検索できるようになります。(仮リリース版では未実装)
          </h4>
          <br>
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
      <v-divider />
    </v-container>
    <v-container>
      <v-row>
        <v-col
          cols="12"
          md="6"
        >
          <v-row
            justify="center"
            class="ma-10"
          >
            <v-btn
              class="mx-auto"
              color="#00ADB5"
              dark
              x-large
              elevation="3"
              @click="toCalculationPage"
            >
              摂取カロリーを知る
            </v-btn>
          </v-row>
        </v-col>
        <v-col
          cols="12"
          md="6"
        >
          <v-row
            justify="center"
            class="ma-10"
          >
            <v-btn
              class="mx-auto"
              color="#00ADB5"
              dark
              x-large
              elevation="3"
              @click="toSearchPage"
            >
              食品を探す
            </v-btn>
          </v-row>
        </v-col>
      </v-row>
    </v-container>
  </div>
</template>

<script>
import FoodSearchBar from "../food/components/FoodSearchBar.vue"

export default {
  components: {
    FoodSearchBar,
  },
  data() {
    return {
      foodImg: require("../../../assets/images/undraw_online_groceries_a02y (2).png"),
      dataImg: require("../../../assets/images/undraw_app_data_re_vg5c (1).png"),
      swipeImg: require("../../../assets/images/undraw_swipe_options_2e4v (1).png")
    }
  },
  methods: {
    toSearchPage() {
      this.$router.push('/search')
    },
    toCalculationPage() {
      this.$router.push('/calculation')
    }
  }
}

</script>

<style scoped>
.top-page {
  background: url("../../../assets/images/eggy-breakfast.jpg");
  background-size: cover;
  background-position: center;
  width: 100%;
  height: 65vh;
}

.top-page h1, h2 {
  color: #fff;
}
</style>