<template>
  <v-container fluid>
    <v-row justify="center">
      <v-col
        cols="12"
        md="9"
        class="text-md-h6"
      >
        選択した栄養素の合計　{{ current_nutrients.calorie }}Kcal<br>
        <v-row
          justify="center"
          class="text-md-subtitle-1"
        >
          <v-col
            cols="4"
            md="3"
          >
            <p>
              たんぱく質<br>
              {{ current_nutrients.protein }}g
            </p>
          </v-col>
          <v-col
            cols="4"
            md="3"
          >
            <p>
              炭水化物<br>
              {{ current_nutrients.carbohydrate }}g
            </p>
          </v-col>
          <v-col
            cols="4"
            md="3"
          >
            <p>
              脂質<br>
              {{ current_nutrients.lipid }}g
            </p>
          </v-col>
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
  },
  methods: {
    toConfirmationPage() {
      this.$router.push("confirmation")
    }
  }
}
</script>