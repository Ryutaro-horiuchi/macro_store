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
          <h1>
            コンビニ食品から<br>
            理想の体作りをサポート
          </h1>
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
      >
        <v-col cols="6">
          <h4 class="text-left">
            コンビニ食品を名前や、炭水化物、たんぱく質、脂質別に検索できます。
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
            １日の適切な摂取カロリーの目安を知ることができます。
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
            会員登録をすると食品のお気に入り保存や、自身の摂取カロリー量を保存して、検索できるようになります。
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
              x-large
              outlined
              elevation="3"
              @click="toCalculationPage"
            >
              摂取カロリー目安量を計算する
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
              x-large
              outlined
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
      foodImg: require("../../../assets/images/undraw_online_groceries_a02y.png"),
      dataImg: require("../../../assets/images/undraw_app_data_re_vg5c.png"),
      swipeImg: require("../../../assets/images/undraw_swipe_options_2e4v.png")
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
  height: 100vh;
}

.top-page h1 {
  color: #fff;
}
</style>