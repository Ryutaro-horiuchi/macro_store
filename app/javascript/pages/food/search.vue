<template>
  <v-container
    fluid
    pt-0
    style="margin-bottom: 150px"
  >
    <template v-if="loading">
      <BaseLoading />
    </template>
    <template v-if="!loading">
      <FoodSearchFormName
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
      <FoodSearchFormNutrient
        @loading="loading = $event"
        @search-nutrient="searchNutrient"
        @null-validation="nullValidation = $event"
        @error-message="errorMessage = $event"
      >
        <p class="text-body-2 text-md-body-1">
          ※摂取カロリー計算の質問に応えていただくと、おすすめの数値が反映されます。
        </p>
      </FoodSearchFormNutrient>
    </template>
  </v-container>
</template>

<script>
import FoodSearchFormName from "./components/FoodSearchFormName.vue";
import FoodSearchFormNutrient from "./components/FoodSearchFormNutrient.vue";
import BaseLoading from "../../../javascript/components/BaseLoading.vue";

export default {
  components: {
    FoodSearchFormName,
    FoodSearchFormNutrient,
    BaseLoading
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