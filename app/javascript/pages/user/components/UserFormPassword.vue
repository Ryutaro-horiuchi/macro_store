<template>
  <v-text-field
    v-model="setPassword"
    :rules="form.rules"
    :counter="!noValidation"
    :hint="form.hint"
    label="パスワード"
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
    password: {
      type: String,
      default: ''
    },
    noValidation: {
      type: Boolean,
      default: false
    }
  },
  data () {
    return {
      show: false
    }
  },
  computed: {
    setPassword: {
      get () { return this.password },
      set (newVal) { return this.$emit('update:password', newVal) }
    },
    form () {
      const min = '8文字以上'
      const msg = `${min}。半角英数字•ﾊｲﾌﾝ•ｱﾝﾀﾞｰﾊﾞｰが使えます`
      const required = v => !!v || ''
      // ログイン時のバリデーション
      const format = v => /^[\w-]{8,72}$/.test(v) || msg
      // 会員登録時のバリデーション
      const rules = this.noValidation ? [required] : [format]
      const hint = this.noValidation ? undefined : msg
      // 会員登録の時のみメッセージを表示する
      return { rules, hint }
    },
    toggle () {
      const icon = this.show ? 'mdi-eye' : 'mdi-eye-off'
      const type = this.show ? 'text' : 'password'
      return { icon, type }
    }
  }
}
</script>