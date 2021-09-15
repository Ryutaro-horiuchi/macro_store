<template>
  <v-text-field
    v-model="setName"
    label="ユーザー名"
    outlined>
  </v-text-field>
</template>

<script>
export default {
  props:{
    name:{
      type: String,
      default: ''
    }
  },
  computed: {
    setName: {
      get() { return this.name },
      set(newValue) { return this.$emit('update:name', newValue) }
    }
  }
}
</script>