<template>
  <v-container
    fluid
    pt-0
    style="margin-bottom: 150px"
  >
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
      <FoodNameSearchForm
        @loading="loading = $event"
        @search-name="searchName"
        @null-validation="nullValidation = $event"
        @error-message="errorMessage = $event"
      />
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
      >
        <p class="text-body-2 text-md-body-1">
          ※摂取カロリー計算の質問に応えていただくと、おすすめの数値が反映されます。
        </p>
      </FoodNutrientSearchForm>
    </template>
  </v-container>
</template>

<script>
import FoodNameSearchForm from "./components/FoodNameSearchForm.vue";
import FoodNutrientSearchForm from "./components/FoodNutrientSearchForm.vue";

export default {
  components: {
    FoodNameSearchForm,
    FoodNutrientSearchForm,
  },
  data() {
    return {
      loading: false,
      errorMessage: null,
      nullValidation: false,
    };
  },
  methods: {
    searchName(name) {
      this.$store.dispatch("searchName", name);
    },
    searchNutrient(nutrients) {
      this.$store.dispatch("searchNutrient", nutrients);
    },
  },
};
</script>

<style scoped>
h2 {
  font-weight: normal;
}
.loader {
  margin-top: 200px;
}
.error_message {
  color: red;
}
</style>