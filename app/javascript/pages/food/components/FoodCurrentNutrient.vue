<template>
  <v-container>
    <v-row justify="center">
      <v-col cols="9">
        選択した栄養素の合計　{{ current_nutrients.calorie }}Kcal<br>
        <v-row justify="center">
          <v-col cols="3">
            <p>タンパク質{{ current_nutrients.protein }}g</p>
          </v-col>
          <v-col cols="3">
            <p>炭水化物{{ current_nutrients.carbohydrate }}g</p>
          </v-col>
          <v-col cols="3">
            <p>脂質{{ current_nutrients.lipid }}g</p>
          </v-col>
          <template v-if="notConfirmationPage">
            <v-col cols="3">
              <v-btn
                outlined
                large
                elevation="3"
                @click="toConfirmationPage"
              >
                確認画面へ
              </v-btn>
            </v-col>
          </template>
        </v-row>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import { mapGetters } from "vuex";

export default {
  computed: {
    ...mapGetters(["current_nutrients"]),
    notConfirmationPage() {
      return this.$route.path !== "/confirmation"
    }
  },
  methods: {
    toConfirmationPage() {
      this.$router.push("confirmation")
    }
  }
}
</script>