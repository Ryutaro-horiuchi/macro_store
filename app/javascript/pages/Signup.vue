<template>
    <v-app>
    <v-card class="mx-auto overflow-hidden" height="100%" width="100%">
      <Header></Header>
      <NavigationBar></NavigationBar>   
      <LoginForm>
        <template v-slot:form-card-content>
          <!-- 以下form-card-contentととして、LoginFormコンポーネントに渡している -->
          <v-form v-model="isValid">
            <UserFormName></UserFormName>
            <UserFormEmail></UserFormEmail>
            <UserFormPassword></UserFormPassword>
          </v-form>
          <v-btn
            :disabled="!isValid"
            block
            color="myblue"
            class="white-text">
            登録する
          </v-btn>
        </template>
      </LoginForm> 
    </v-card>
  </v-app>
</template>

<script>
export default {
  data() {
    return {
      isvalid: false
    }
  }
}
</script>