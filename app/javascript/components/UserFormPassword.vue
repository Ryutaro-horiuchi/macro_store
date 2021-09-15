<template>
  <v-text-field
    v-model="setEmail"
    label="パスワード"
    outlined
    >
  </v-text-field>
</template>

<script>
export default {
  props:{
    password:{
      type: String,
      default: ''
    }
  },
  computed: {
    setPassword: {
      get() { return this.password },
      set(newValue) { return this.$emit('update:password', newValue) }
    }
  }
}
</script>