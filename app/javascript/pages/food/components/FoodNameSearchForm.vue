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
            v-model="setSearchFood"
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
  props: {
    name: {
      type: String,
      default: "",
    },
  },
  computed: {
    setSearchFood: {
      get() {
        return this.name;
      },
      set(newVal) {
        return this.$emit("update:name", newVal);
      },
    },
  },
  methods: {
    searchName() {
      this.$emit("searchName");
    },
  },
};
</script>

<style>
</style>
