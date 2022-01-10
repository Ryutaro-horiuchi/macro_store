<template>
  <v-container style="margin-top: 100px; margin-bottom: 150px;">
    <v-row
      align="center"
    >
      <v-col
        cols="12"
        class="my-8 text-center"
      >
        <h1 class="text-h5 font-weight-bold">
          {{ title }}
        </h1>
      </v-col>

      <v-card
        flat
        width="80%"
        max-width="500"
        color="transparent"
        class="mx-auto"
      >
        <slot name="form-card-content" />
      </v-card>
    </v-row>
  </v-container>
</template>

<script>
export default {
  props: {
    title: {
      type: String,
      required: true,
    }
  }
}
</script>