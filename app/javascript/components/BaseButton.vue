<template>
<v-col cols="6">
  <v-row justify="center">
    <v-btn
      color="#1c65ac"
      dark
      large
      elevation="3"
      @click="myClick"
    >
    <slot />
    </v-btn>
  </v-row>
</v-col>
</template>

<script>
export default {
  methods: {
    myClick() {
      this.$emit("my-click")
    }
  }
}
</script>