<template>
  <v-container>
    <v-row align="center"
    >
      <v-col cols="12" class="my-8 text-center">
        <h1 class="text-h5 font-weight-bold">
          会員登録
        </h1>
      </v-col>

      <v-card
        flat
        width="80%"
        max-width="320"
        color="transparent"
        class="mx-auto"
      > <!-- テンプレートを差し込むスロット -->
        <slot name="form-card-content" />
      </v-card>
    </v-row>
  </v-container>
</template>

<script>
export default {
  
}
</script>