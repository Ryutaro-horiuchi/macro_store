<template>
  <FoodList
    :foods="bookmarkedFoods"
    @to-search-page="toSearchPage"
  >
    <template #message>
      <v-container>
        <v-row justify="center">
          <div
            class="text-center text-h6 text-md-h4"
            style="margin-top: 50px; margin-bottom: 30px;"
          >
            お気に入り
          </div>
        </v-row>
      </v-container>
    </template>
    <template #noData>
      <h2 style="margin-top: 100px;">
        お気に入り食品がありません
      </h2>
      <v-row
        justify="center"
        class="mt-10"
      >
        <BaseButton @my-click="toSearchPage">
          食品を探す
        </BaseButton>
      </v-row>
    </template>
  </FoodList>
</template>

<script>
import { mapGetters } from "vuex";
import FoodList from "../../food/components/FoodList.vue";
import BaseButton from "../../../components/BaseButton.vue";


export default {
  components: {
    FoodList,
    BaseButton
  },
  computed: {
    ...mapGetters(["bookmarkedFoods"])
  },
  methods: {
    toSearchPage() {
      this.$router.push('/search')
    }
  }
}
</script>