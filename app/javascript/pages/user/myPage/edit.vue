<template>
  <UserForm :title="title">
    <template #form-card-content>
      <v-form
        ref="form"
        v-model="isValid"
      >
        <UserFormName :name.sync="params.user.name" />
        <UserFormEmail :email.sync="params.user.email" />
      </v-form>
      <v-row
        justify="center"
        style="margin-top: 80px"
      >
        <v-col cols="6">
          <v-btn
            :disabled="!isValid || loading"
            :loading="loading"
            color="#1c65ac"
            dark
            block
            @click="update"
          >
            <!-- disabledはtrueの場合にボタンを無効にする。この時はvalidが有効ではない時がtrueであり、無効になる。 -->
            <span>更新する</span>
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
import { mapGetters } from "vuex"

export default {
  components: {
    UserForm,
    UserFormName,
    UserFormEmail
  },
  data() {
    return {
      title: "アカウント編集",
      isValid: false,
      loading: false,
      params: { user: { name: '', email: ''} }
    }
  },
  computed: {
    ...mapGetters(["user"])
  },
  created() {
    this.params.user.name = this.user.name
    this.params.user.email = this.user.email
  },
  methods: {
    update() {
      this.loading = true
      this.$store.dispatch('update', this.params)
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