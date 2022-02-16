<template>
  <v-btn
    color="#1c65ac"
    dark
    large
    elevation="3"
    @click="myClick"
  >
    <slot />
  </v-btn>
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