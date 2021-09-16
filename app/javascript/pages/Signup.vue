<template>
    <v-app>
    <v-card class="mx-auto overflow-hidden" height="100%" width="100%">
      <Header></Header>
      <NavigationBar></NavigationBar>   
      <LoginForm>
        <template v-slot:form-card-content>
          <!-- 以下form-card-contentととして、LoginFormコンポーネントに渡している -->
          <v-form ref="form" v-model="isValid">
            <UserFormName :name.sync="params.user.name"></UserFormName>
            <UserFormEmail :email.sync="params.user.email"></UserFormEmail>
            <UserFormPassword :password.sync="params.user.password"></UserFormPassword>
          </v-form>
          <v-btn
            :disabled="!isValid || loading"
            :loading="loading"
            block
            color="green" 
            class="white-text"
            @click="signup">
            <!-- disabledはtrueの場合にボタンを無効にする。この時はvalidが有効ではない時がtrueであり、無効になる。 -->
            <span>登録する</span>
          </v-btn>
        </template>
      </LoginForm> 
    </v-card>
      <v-card-text>
        {{ params }}
      </v-card-text>
  </v-app>
</template>

<script>
export default {
  data() {
    return {
      isValid: false,
        // v-formタグ内のバリデーションが有効なときにtrueを返す
      loading: false,
      params: { user: { name: '', email: '', password: '' }},
    }
  },
  methods: {
    signup() {
      this.loading = true
      setTimeout(() => {
        this.formReset()
        this.loading = false
      }, 1500)
    },
    formReset() {
      this.$refs.form.reset()
      this.params = { user: {name: '', email: '', password: ''} }
    }
  }
}
</script>