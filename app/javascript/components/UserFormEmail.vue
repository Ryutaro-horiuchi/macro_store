<template>
  <v-text-field
    v-model="setEmail"
    :rules="rules"
    label="メールアドレス"
    prepend-inner-icon="mdi-email"
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
  data() {
    return {
      rules: [
        v => !!v || '',
        v => /.+@.+\..+/.test(v) || ''
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