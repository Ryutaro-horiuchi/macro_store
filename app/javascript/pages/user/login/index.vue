<template>
  <UserForm title="ログイン">
    <template #form-card-content>
      <!-- 以下form-card-contentととして、LoginFormコンポーネントに渡している -->
      <v-form
        ref="form"
        v-model="isValid"
      >
        <UserFormEmail :email.sync="params.email" />
        <UserFormPassword
          no-validation
          :password.sync="params.password"
        />
        <v-card-actions>
          <router-link to="#">
            パスワードを忘れた場合
          </router-link>
        </v-card-actions>
        <v-card-text class="px-0">
          <v-btn
            :disabled="!isValid || loading"
            :loading="loading"
            block
            color="green"
            class="white-text"
            @click="login"
          >
            <span>ログインする</span>
          </v-btn> 
        </v-card-text>
      </v-form>
    </template>
  </UserForm> 
</template>

<script>
import UserForm from "../components/UserForm.vue"
import UserFormEmail from "../components/UserFormEmail.vue"
import UserFormPassword from "../components/UserFormPassword.vue"


export default {
  components: {
    UserForm,
    UserFormEmail,
    UserFormPassword
  },
  data() {
    return {
      isValid: false,
      loading: false,
      params: { email: '', password: '' },
    }
  },
  methods: {
    login() {
      this.loading = true
      this.$store.dispatch('login', this.params)
      setTimeout(() => {
        this.loading = false
      }, 1500)
    }
  }
}
</script>