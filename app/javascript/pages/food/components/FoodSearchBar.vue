<template>
  <v-container pt-0>
    <v-row justify="center">
      <v-col
        cols="10"
        md="8"
        lg="6"
      >
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
          <v-icon 
            class="ml-3"
            style="cursor: pointer"
            @click="nameSearch"
          >
            large
            mdi-magnify
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
