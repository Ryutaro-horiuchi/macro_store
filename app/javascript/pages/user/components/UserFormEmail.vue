<template>
  <v-text-field
    v-model="setEmail"
    :rules="rules"
    label="メールアドレス"
    prepend-inner-icon="mdi-email"
    outlined
    background-color="white"
  />
</template>

<script>
export default {
  props:{
    email:{
      type: String,
      default: ''
    }
  },
  data() {
    return {
      rules: [
        v => !!v || '',
        v => /^[\w+\-]+@[a-z\d\-]+\.[a-z]+\.*[a-z]*$/.test(v) || ''
      ]
    }
  },
  computed: {
    setEmail: {
      get() { return this.email },
      set(newVal) { return this.$emit('update:email', newVal) }
    }
  }
}
</script>