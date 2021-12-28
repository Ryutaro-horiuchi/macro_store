<template>
  <div style="margin-top: 100px; margin-bottom: 150px;">
    <UserForm :title="title">
      <template #form-card-content>
        <v-form
          ref="form"
          v-model="isValid"
        >
          <UserFormName :name.sync="params.user.name" />
          <UserFormEmail :email.sync="params.user.email" />
          <UserFormPassword :password.sync="params.user.password" />
          <UserFormPasswordConfirmation
            :password_confirmation.sync="params.user.password_confirmation"
            :password="params.user.password"
          />
        </v-form>
        <v-btn
          :disabled="!isValid || loading"
          :loading="loading"
          color="#1c65ac"
          dark
          block
          @click="signUp"
        >
          <!-- disabledはtrueの場合にボタンを無効にする。この時はvalidが有効ではない時がtrueであり、無効になる。 -->
          <span>登録する</span>
        </v-btn>
      </template>
    </UserForm> 
  </div>
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
      this.params = { user: {name: '', email: '', password: '', password_confirmation: ''} }
    }
  }
}
</script>