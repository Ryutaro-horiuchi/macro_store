<template>
  <v-container class="mt-14">
    <v-row justify="center">
      <v-col
        cols="10"
        offset="1"
        class="mt-10"
      >
        <h4>ダイエットに有効な1日の摂取カロリーの目安は・・・？</h4>
      </v-col>
      <v-col
        cols="10"
        class="mt-15"
      >
        <h1 class="text-center">
          {{ ingestionCal["calorie"] }}kcal
        </h1>
      </v-col>
      <v-col
        cols="10"
        offset="1"
        class="mt-10"
      >
        <h4>あなたの1日の各栄養素の目安は・・・？</h4>
      </v-col>
      <v-col
        cols="10"
        class="mt-15"
      >
        <h2 class="text-center">
          炭水化物{{ ingestionCal["carbohydrate"] }}g
        </h2>
      </v-col>
      <v-col
        cols="10"
        class="mt-15"
      >
        <h2 class="text-center">
          タンパク質{{ ingestionCal["protein"] }}g
        </h2>
      </v-col>
      <v-col
        cols="10"
        class="mt-15"
      >
        <h2 class="text-center">
          脂質{{ ingestionCal["lipid"] }}g
        </h2>
      </v-col>
      <v-col
        cols="10"
        class="mt-15"
      >
        <p class="text-left">
          ※上記の数値はあくまで目安です。<br>
          参考にして体重が増えるようであれば、摂取量を減らしてみるなど、
          調整してみましょう。
        </p>
      </v-col>
      <v-col
        cols="10"
        class="my-15"
      >
        <v-row justify="center">
          <v-btn
            color="#00ADB5"
            dark
            large
            elevation="3"
            @click="toSearchPage"
          >
            食品を探す
          </v-btn>
        </v-row>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import { mapGetters } from "vuex";

export default {
  computed: {
    ...mapGetters(["ingestionCal"])
  },
  methods: {
    toSearchPage() {
      this.$router.push('/search')
    }
  }
}
</script>