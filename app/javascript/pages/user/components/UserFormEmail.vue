<template>
  <v-text-field
    v-model="setEmail"
    :rules="rules"
    label="メールアドレス"
    prepend-inner-icon="mdi-email"
    outlined
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
        v => /[\w+\-.]+@[a-z\d\-.]+\.[a-z]+/.test(v) || ''
      ]
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