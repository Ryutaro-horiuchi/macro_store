<template>
  <v-row justify="center">
    <v-col cols="6">
      <v-toolbar
        dense
      >
        <v-text-field
          v-model="setSearchFood"
          hide-details
          background-color="#EEEEEE"
          placeholder="名前検索"
          @click="toSearch"
        />
        <!-- フォームボタンを押すと、searchページへ遷移 -->

        <v-icon 
          class="ml-3"
          style="cursor: pointer"
          @click="nameSearch"
        >
          <!-- iconに検索のメソッドを追加する -->
          large
          mdi-magnify
        </v-icon>
      </v-toolbar>
    </v-col>
  </v-row>
</template>

<script>
export default {
  props: {
    name: {
      type: String,
      default: ''
    }
  },
  computed: {
    setSearchFood: {
      get () { return this.name },
      set (newVal) { return this.$emit('update:name', newVal) }
    }
  },
  methods: {
    toSearch() {
      if (this.$route.path !== '/search') {
        this.$router.push('search')
      }
    },
    nameSearch() {
      this.$emit('nameSearch')
    }
  }
}
</script>
