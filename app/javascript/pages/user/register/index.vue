<template>
  <UserForm :title="title">
    <template v-slot:form-card-content>
      <!-- 以下form-card-contentととして、LoginFormコンポーネントに渡している -->
      <v-form ref="form" v-model="isValid">
        <UserFormName :name.sync="params.user.name"></UserFormName>
        <UserFormEmail :email.sync="params.user.email"></UserFormEmail>
        <UserFormPassword :password.sync="params.user.password"></UserFormPassword>
        <UserFormPasswordConfirmation :password_confirmation.sync="params.user.password_confirmation"
                                      :password="params.user.password">
        </UserFormPasswordConfirmation>
      </v-form>
      <v-btn
        :disabled="!isValid || loading"
        :loading="loading"
        block
        color="green" 
        class="white-text"
        @click="signUp">
        <!-- disabledはtrueの場合にボタンを無効にする。この時はvalidが有効ではない時がtrueであり、無効になる。 -->
        <span>登録する</span>
      </v-btn>
    </template>
  </UserForm> 
</template>

<script>
import UserForm from "../components/UserForm.vue"
import UserFormName from "../components/UserFormName.vue"
import UserFormEmail from "../components/UserFormEmail.vue"
import UserFormPassword from "../components/UserFormPassword.vue"
import UserFormPasswordConfirmation from "../components/UserFormPasswordConfirmation.vue"

export default {
  components: {
    UserForm,
    UserFormName,
    UserFormEmail,
    UserFormPassword,
    UserFormPasswordConfirmation
  },
  data() {
    return {
      title: "会員登録",
      isValid: false,
        // v-formタグ内のバリデーションが有効なときにtrueを返す
      loading: false,
      params: { user: { name: '', email: '', password: '', password_confirmation: '' } },
    }
  },
  methods: {
    signUp() {
      this.$store.dispatch('signUp', this.params)
      setTimeout(() => {
        this.formReset()
        this.loading = false
      }, 1500)
    },
    formReset() {
      // this.$refs.form.reset() この関数があると、paramsの値がnullになるため一度保留
      this.params = { user: {name: '', email: '', password: '', password_confirmation: ''} }
    }
  }
}
</script>