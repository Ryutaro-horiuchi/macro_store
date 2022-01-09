<template>
  <v-snackbar
    v-model="flashStatus"
    transition="slide-y-transition"
    right
    top
    :color="flashColor"
  >
    {{ flashMessage }}
  </v-snackbar>
</template>

<script>
import { mapGetters } from "vuex"
export default {
  computed: {
    ...mapGetters(["flashMessage", "flashColor", "flashStatus"])
  }
}
</script>