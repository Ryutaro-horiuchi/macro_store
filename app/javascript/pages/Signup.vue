<template>
    <v-app>
    <v-card class="mx-auto overflow-hidden" height="100%" width="100%">
      <Header></Header>
      <NavigationBar></NavigationBar>   
      <LoginForm>
        <template v-slot:form-card-content>
          <!-- 以下form-card-contentととして、LoginFormコンポーネントに渡している -->
          <v-form v-model="isValid">
            <UserFormName :name.sync="params.user.name"></UserFormName>
            <UserFormEmail :email.sync="params.user.email"></UserFormEmail>
            <UserFormPassword :password.sync="params.user.password"></UserFormPassword>
          </v-form>
          <v-btn
            :disabled="!isValid"
            block
            color="myblue"
            class="white-text">
            <!-- disabledはtrueの場合にボタンを無効にする。この時はvalidが有効ではない時がtrueであり、無効になる。 -->
            登録する
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
      isvalid: false,
        // v-formタグ内のバリデーションが有効なときにtrueを返す
      params: { user: { name: '', email: '', password: '' }}
    }
  }
}
</script>