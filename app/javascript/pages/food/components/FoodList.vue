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
            id="food_card"
            class="my-5"
            outlined
            @click="openDialog(food)"
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
                        id="star"
                        color="blue"
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
                        id="star"
                        color="blue"
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
                <FoodListBarChart :food="food" />
              </v-col>
            </v-row>
          </v-card>
        </v-col>
      </v-row>
      <v-dialog
        v-model="foodDialog"
        @click:outside="closeDialog"
      >
        <FoodListDialog />
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
import FoodListDialog from './FoodListDialog.vue';
import FoodListBarChart from './FoodListBarChart.vue';
import InfiniteLoading from 'vue-infinite-loading';

export default {
  components: {
    FoodListDialog,
    FoodListBarChart,
    InfiniteLoading,
  },
  props: {
    foods: {
      type: Array,
      default: null
    }
  },
  data() {
    return {
      getFoods: [], //foodListから切り取ったデータを格納。この配列データをブラウザに表示
      foodList: [], // 新しく取得した全データ
      page: 0,
      pageSize: 20, // １ページに表示するデータ件数
      initialized: false, //データアクセスが完了した後にtrueを設定するフラグ
      sevenImg: require("../../../../assets/images/seven_eleven.logo.png"),
      scrollHeight: null
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
    this.$nextTick(function() {
      setTimeout(() => {
        this.scrollHeight = document.documentElement.scrollHeight
      }, 500)
    })
  },
  methods: {
    ...mapActions(["openDialog", "closeDialog", "makeBookmark", "removeBookmark"]),
    toSearchPage() {
      this.$emit("to-search-page")
    },
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

        if($state) $state.loaded();
        this.$nextTick(() => {
          this.initialized = true
        })
      }, 500)
    },
    scroll() {
      // 現在のスクロールY座標から、画面に表示されているページ番号を計算する
      let page = Math.ceil(((window.pageYOffset + 0.5) / this.scrollHeight))
      // urlを書き換え（urlパラメータにページ番号を設定)
      window.history.replaceState(null, null, "/?page=" + page)
    }
  }
}
</script>
