<template>
  <v-app>
    <v-card class="mx-auto overflow-hidden" height="100%" width="100%">
      <Header></Header>
      <NavigationBar></NavigationBar>   
      <LoginForm title="ログイン">
        <template v-slot:form-card-content>
          <!-- 以下form-card-contentととして、LoginFormコンポーネントに渡している -->
          <v-form ref="form" v-model="isValid">
            <UserFormEmail :email.sync="params.user.email"></UserFormEmail>
            <UserFormPassword :password.sync="params.user.password"></UserFormPassword>
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
                @click="login">
              <span>ログインする</span>
              </v-btn> 
            </v-card-text>
          </v-form>
        </template>
      </LoginForm> 
    </v-card>
  </v-app>
</template>

<script>
export default {
  data() {
    return {
      isValid: false,
      loading: false,
      params: { user: { email: '', password: '' }},
    }
  },
  methods: {
    login() {
      this.loading = true
      setTimeout(() => {
        this.$store.dispatch('login')
        this.$router.replace('/')
      }
      )
    }
  }
}
</script>