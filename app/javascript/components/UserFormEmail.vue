<template>
  <v-text-field
    v-model="setEmail"
    label="メールアドレス"
    outlined>
  </v-text-field>
</template>

<script>
export default {
  props:{
    email:{
      type: String,
      default: ''
    }
  },
  computed: {
    setEmail: {
      get() { return this.email },
      set(newValue) { return this.$emit('update:email', newValue) }
    }
  }
}
</script>