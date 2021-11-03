<template>
  <div>
    <FoodSearchBar :name.sync="params.name"
                   @nameSearch="nameSearch"></FoodSearchBar>
    <v-container>
      <v-row>
        <v-col col="8" offset="2" class="text-left my-10"> 
          <h2>営業素から探す</h2>
        </v-col>
      </v-row>

      <v-row>
        <v-col col="8" offset="2" class="text-left my-10"> 
          <h2>登録した数値から探す</h2>
        </v-col>
      </v-row>
    </v-container>
  </div>
</template>

<script>
import FoodSearchBar from "./components/FoodSearchBar.vue"

export default {
  data() {
    return {
      params: { name: '' }
    }
  },
  components: {
    FoodSearchBar
  },
  methods: {
    nameSearch() {
      this.$store.dispatch("nameSearch", this.params)
    }
  }
}
</script>

<style scoped>
h2 {
  font-weight: normal;
}
</style>