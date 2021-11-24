<template>
  <v-container
    fluid
    pt-0
  >
    <FoodSearchBar />
    <v-container>
      <template v-if="currentNutrientsExist">
        <FoodCurrentNutrinet />
      </template>
      <v-row>
        <v-col
          v-for="food in getFoods"
          :key="food.id"
          cols="12"
          md="6"
        >
          <v-card
            class="my-5"
            outlined
            @click="openDialog(food)"
          > 
            <v-row
              justify="center"
              align-content="center"
            >
              <v-col
                cols="4"
                md="6"
              >
                <v-img :src="food.image.url" />
                <v-card-subtitle class="text-xs-body-1 text-md-h5">
                  {{ food.name }}
                </v-card-subtitle>
                <v-card-subtitle class="text-md-h6">
                  税抜{{ food.price }}円
                </v-card-subtitle>
                <v-card-subtitle class="text-md-h6">
                  {{ food.calorie }}kcal
                </v-card-subtitle>
              </v-col>
              <v-col
                cols="8"
                md="6"
                align-content="center"
              >
                <FoodBarChart :food="food" />
              </v-col>
            </v-row>
          </v-card>
        </v-col>
      </v-row>
      <v-dialog
        v-model="foodDialog"
        width="600"
        max-height="600"
        persistent
        @click:outside="closeDialog"
      >
        <Dialog />
      </v-dialog>
      <infinite-loading
        v-if="hasNext"
        spinner="spiral"
        class="mt-10"
        @infinite="infiniteHandler"
      >
        <div slot="no-more">
          全件取得しました
        </div>
        <div slot="no-results">
          条件に合致するデータがありません
        </div>
      </infinite-loading>
    </v-container>
  </v-container>
</template>

<script>
import { mapGetters, mapActions } from "vuex";
import Dialog from './dialog.vue'
import FoodCurrentNutrinet from './components/FoodCurrentNutrient.vue'
import InfiniteLoading from 'vue-infinite-loading';
import FoodBarChart from "./components/FoodBarChart.vue"
import FoodSearchBar from "../food/components/FoodSearchBar.vue"

export default {
  components: {
    Dialog,
    FoodCurrentNutrinet,
    InfiniteLoading,
    FoodBarChart,
    FoodSearchBar,
  },
  data() {
    return {
      getFoods: [],
      start: 0,
      end: 0,
      totalPages: 0,  // 総ページ数
      pageSize: 20, // １ページに表示するデータ件数
      initialized: false, //初回データアクセスが完了した後にtrueを設定するフラグ
    }
  },
  computed: {
    ...mapGetters(["foods", "foodDialog", "current_nutrients"]),
    hasNext() {
      return this.initialized
    },
    currentNutrientsExist() {
      return this.current_nutrients["calorie"] !== 0;
    }
  },
  mounted() {
    // 現在表示中のページ番号をURLに設定する為に、スクロールイベントを監視
    window.addEventListener("scroll", ()=> this.scroll())

    // 現在のページ番号を取得する。
    const urlParams = new URLSearchParams(window.location.search);
    const page = urlParams.get('page');

    if(page) {
      // URLパラメータでページ番号が指定された場合、指定ページから表示
      this.start = parseInt(page, 10) // 取得した文字列を10進数で数字へ変換
      this.end = parseInt(page, 10)
    } else {
      // ページ番号を取得できない場合は1ページ目を表示
      this.start = 1
      this.end = 1
    }
    // getItemsメソッドにより、表示するデータを取得
    this.fetchFoods(null, this.start, false)
  },
  methods: {
    ...mapActions(["openDialog", "closeDialog"]),
    infiniteHandler($state) {
      if (this.end >= this.totalPages) {
      // 全てのページが読まれたことをプラグインに伝える
        $state.complete();
      } else {
        // 表示するページがまだある場合、次ページのデータを取得する
        this.fetchFoods($state, this.end + 1, true)
      }
    },
    fetchFoods($state, page, next) {
      // setTimeout(() => {
        let data = []
        if (this.foods.length >= page * 20) {
          data = this.foods.slice(page * 20 - 20, page * 20)
        } else {
          data = this.foods.slice(page * 20 - 20, this.foods.length)
        }
        this.totalPages = Math.ceil(this.foods.length / 20)

        this.getFoods = this.getFoods.concat(data)
        this.end = page

        if ($state) $state.loaded();
        this.$nextTick(() => {
          this.initialized = true
        })
      // }, 1000)
    },
    scroll() {
      // 現在のスクロールY座標から、画面に表示されているページ番号を計算する
      let scroll_position = window.pageYOffset || document.documentElement.scrollTop
      let page = Math.ceil(((scroll_position + 0.5) / 7234))
      // replaceStateでurlを書き換え（urlパラメータにページ番号を設定)
      window.history.replaceState(null, null, "/?page=" + page)
    }
  }
}
</script>