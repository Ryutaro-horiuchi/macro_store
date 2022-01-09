<template>
  <FoodList
    :foods="foods"
  >
    <template #message>
      <div class="text-center text-h6 text-md-h5 my-10">
        気になる食品をタップし、<strong>「選択する」</strong>を押してください
      </div>
      <div class="text-right text-body-2 text-md-body-1">
        <strong>{{ foods.length }}件ヒットしました</strong>
      </div>
    </template>
    <template #noData>
      <div class="text-center text-body-1 text-md-h5">
        条件に合致するデータがありません。<br>
        数値検索の場合は、値を調整して再度試してみてください。
      </div>
    </template>
  </FoodList>
</template>

<script>
import { mapGetters } from "vuex";
import FoodList from "./components/FoodList.vue";

export default {
  components: {
    FoodList
  },
  computed: {
    ...mapGetters(["foods"]),
  }
}
</script>
