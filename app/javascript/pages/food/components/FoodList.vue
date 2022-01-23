<template>
  <v-container
    fluid
    style="margin-top: 50px;
           margin-bottom: 150px;"
  >
    <v-container>
      <template v-if="foods.length">
        <slot name="message" />
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
            id="food_card"
          > 
            <v-row>
              <v-col cols="6">
                <v-img :src="food.image.url" />
              </v-col>
              <v-col cols="6">
                <v-card-subtitle class="text-xs-body-1 text-md-h5">
                  {{ food.name }}<br>
                </v-card-subtitle>
                <v-card-subtitle class="text-xs-body-1 text-md-h5 text-right">
                  {{ food.calorie }}kcal
                </v-card-subtitle>
                <v-row>
                  <v-col
                    cols="4"
                    offset="2"
                  >
                    <v-img
                      :src="sevenImg"
                      height="32"
                      width="32"
                    />
                  </v-col>
                  <template v-if="!isBookmarked(food)">
                    <v-col cols="2">
                      <v-icon
                        color="blue"
                        id="star"
                        large
                        @click.stop="makeBookmark(food)"
                      >
                        mdi-star-outline
                      </v-icon>
                    </v-col>
                  </template>
                  <template v-if="isBookmarked(food)">
                    <v-col cols="2">
                      <v-icon
                        color="blue"
                        id="star"
                        large
                        @click.stop="removeBookmark(food)"
                      >
                        mdi-star
                      </v-icon>
                    </v-col>
                  </template> 
                </v-row>
              </v-col>
            </v-row>
            <v-row justify="center"> 
              <v-col
                cols="10"
                md="8"
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
      <!-- 下スクロールした時に、次のページを取得するコンポーネント
            @infiniteで画面最下部までスクロールした際に発火 -->
      <infinite-loading
        v-if="hasNext"
        spinner="bubbles"
        class="mt-10"
        @infinite="infiniteHandler"
      >
        <div
          slot="no-more"
          class="text-center text-body-1 text-md-h5"
        >
          全件取得しました
        </div>
        <div slot="no-results">
          <slot name="noData" />
        </div>
      </infinite-loading>
    </v-container>
  </v-container>
</template>

<script>
import { mapGetters, mapActions } from "vuex";
import Dialog from '../dialog.vue'
import InfiniteLoading from 'vue-infinite-loading';
import FoodBarChart from './FoodBarChart.vue';

export default {
  components: {
    Dialog,
    InfiniteLoading,
    FoodBarChart,
  },
  props: {
    foods: {
      type: Array,
      default: null
    }
  },
  data() {
    return {
      getFoods: [], //foodListから切り取ったデータを格納。この配列データがブラウザに表示される
      foodList: [], // 新しく取得した全データ。
      page: 0,
      pageSize: 20, // １ページに表示するデータ件数
      initialized: false, //データアクセスが完了した後にtrueを設定するフラグ
      sevenImg: require("../../../../assets/images/seven_eleven.logo.png")
    }
  },
  computed: {
    ...mapGetters(["foodDialog", "current_nutrients", "bookmarkedFoods"]),
    hasNext() {
      return this.initialized 
    },

  },
  mounted() {
    // 現在表示中のページ番号をURLに設定する為に、スクロール時にイベントを発火
    window.addEventListener("scroll", ()=> this.scroll())

    // 現在のページ番号を取得する。
    const urlParams = new URLSearchParams(window.location.search);
    const page = urlParams.get('page');

    // URLパラメータでページ番号が指定された場合、指定ページから表示
    if(page) {
      this.page = parseInt(page, 10)
    } else {
      // ページ番号を取得できない場合は1ページ目を表示
      this.page = 1
    }

    // 初期データ取得をする
    this.fetchFoods(null, this.page)
  },
  methods: {
    toSearchPage() {
      this.$emit("to-search-page")
    }
  },
  methods: {
    ...mapActions(["openDialog", "closeDialog", "makeBookmark", "removeBookmark"]),
    isBookmarked(food) {
      return this.bookmarkedFoods.some(v => v.id === food.id)
    },
    infiniteHandler($state) {
      // 商品がそもそもなければ、completeでno-resultを呼ぶ
      if (!this.foods.length) {
        $state.complete();
      } 
      // 取得できた全食品一覧が20件以下の場合は、終了する
        else if (this.foods.length <= 20) {
        $state.loaded();
        $state.complete();
      // リロード後取得したデータが19件以下の場合は、終了する
      } else if (this.foodList.length <= 19) {
        $state.complete();
      } else {
        // 新しく取得するデータがある場合、次ページのデータを取得する
        this.fetchFoods($state, this.page + 1)
      }
    },
    fetchFoods($state, page) {
      setTimeout(() => {
        this.foodList = this.foods.slice(page * this.pageSize - this.pageSize, page * this.pageSize)
        this.getFoods = this.getFoods.concat(this.foodList)
        this.page = page

        // $state.loaded()でデータの読込完了を通知する
        if($state) $state.loaded();
        this.$nextTick(() => {
          this.initialized = true
        })
      }, 500)
    },
    scroll() {
      // 現在のスクロールY座標から、画面に表示されているページ番号を計算する
      let scroll_position = window.pageYOffset || document.documentElement.scrollTop
      let page = Math.ceil(((scroll_position + 0.5) / 7234))
      // urlを書き換え（urlパラメータにページ番号を設定)
      window.history.replaceState(null, null, "/?page=" + page)
    }
  }
}
</script>
