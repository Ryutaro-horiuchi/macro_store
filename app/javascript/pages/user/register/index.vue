<template>
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
        <input
          id="checkbox"
          v-model="checkbox"
          type="checkbox"
        >
        <label for="checkbox"><span
          id="terms"
          @click.prevent="openDialog"
        >利用規約</span>に同意する</label>
        <v-dialog
          v-model="dialog"
          max-width="600px"
          @click:outside="closeDialog"
        >
          <v-card>
            <TermsOfUse />
          </v-card>
        </v-dialog>
      </v-form>
      <v-row
        justify="center"
        style="margin-top: 80px"
      >
        <v-col cols="6">
          <v-btn
            :disabled="!isValid || !checkbox || loading"
            :loading="loading"
            color="#1c65ac"
            dark
            block
            @click="signUp"
          >
            <!-- disabledはtrueの場合にボタンを無効にする。この時はvalidが有効ではない時がtrueであり、無効になる。 -->
            <span>登録する</span>
          </v-btn>
        </v-col>
      </v-row>
    </template>
  </UserForm> 
</template>

<script>
import UserForm from "../components/UserForm.vue"
import UserFormName from "../components/UserFormName.vue"
import UserFormEmail from "../components/UserFormEmail.vue"
import UserFormPassword from "../components/UserFormPassword.vue"
import UserFormPasswordConfirmation from "../components/UserFormPasswordConfirmation.vue"
import TermsOfUse from "../../top/components/TermsOfUse.vue";

export default {
  components: {
    UserForm,
    UserFormName,
    UserFormEmail,
    UserFormPassword,
    UserFormPasswordConfirmation,
    TermsOfUse
  },
  data() {
    return {
      title: "ユーザー登録",
      dialog: false,
      isValid: false,
      loading: false,
      checkbox: false,
      params: { user: { name: '', email: '', password: '', password_confirmation: '' } },
    }
  },
  methods: {
    signUp() {
      this.loading = true
      this.$store.dispatch('signUp', this.params)
      setTimeout(() => {
        this.formReset()
        this.loading = false
      }, 1500)
    },
    openDialog() {
      this.dialog = true
    },
    closeDialog() {
      this.dialog = false
    },
    formReset() {
      this.params = { user: {name: '', email: '', password: '', password_confirmation: ''} }
    }
  }
}
</script>

<style scoped>
#terms {
  color: #337ef6;
  text-decoration: underline;
  text-decoration-color: #337ef6;
  cursor: pointer;
}

#checkbox {
  transform: scale(1.5);
  margin: 0 10px;
}
</style>