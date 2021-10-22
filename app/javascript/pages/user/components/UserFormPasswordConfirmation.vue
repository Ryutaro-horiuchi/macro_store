<template>
  <v-text-field
    v-model="setPassword"
    :rules="confirmPasswordRules"
    :counter="true"
    label="パスワード (確認用)"
    :append-icon="toggle.icon"
    :type="toggle.type"
    outlined
    autocomplete="on"
    @click:append="show = !show"
  />
</template>

<script>
export default {
  props: {
    passwordConfirmation: {
      type: String,
      default: ''
    },
    password: {
      type: String,
      default: ''
    }
  },
  data () {
    return {
      show: false,
    }
  },
  computed: {
    setPassword: {
      get () { return this.passwordConfirmation },
      set (newVal) { return this.$emit('update:password_confirmation', newVal) }
    },
    confirmPasswordRules() {
      const rules = [(this.password_confirmation === this.password) || "パスワードと一致していません"];
      return rules
    },
    toggle () {
      const icon = this.show ? 'mdi-eye' : 'mdi-eye-off'
      const type = this.show ? 'text' : 'password'
      return { icon, type }
    }
  }
}
</script>