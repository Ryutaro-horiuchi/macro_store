<template>
  <v-container
    pt-0
    style="margin-top: 90px"
  >
    <v-row justify="center">
      <v-col
        cols="10"
        md="8"
        lg="6"
      >
        <v-toolbar
          shaped
          class="toolbar"
          dense
          color="#FFFFFF"
        >
          <v-text-field
            v-model="params.name"
            hide-details
            background-color="#EEEEEE"
            placeholder="名前検索"
          />
          <v-icon
            id="magnify"
            class="ml-3"
            color="#D63D17"
            style="cursor: pointer"
            large
            @click="searchName"
          >
            large mdi-magnify
          </v-icon>
        </v-toolbar>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
export default {
  data() {
    return {
      params: { name: null }
    }
  },
  methods: {
    // 名前フォームのnullチェック。
    checkStringNull() {
      return this.params.name ? true : false;
    },
    searchName() {
      if (this.checkStringNull()) {
        this.$emit("loading", true)
        this.$emit("search-name", this.params);
      } else {
        this.$emit("null-validation", true);
        this.$emit("error-message", "文字を入力してください");
      }
    }
  }
};
</script>
