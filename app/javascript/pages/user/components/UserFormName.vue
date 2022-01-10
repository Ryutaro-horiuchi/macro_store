<template>
  <v-text-field
    v-model="setName"
    :rules="rules"
    :counter="max"
    label="ユーザー名"
    prepend-inner-icon="mdi-account"
    outlined
    background-color="white"
  />
</template>
<script>
export default {
  props:{
    name:{
      type: String,
      default: ''
    }
  },
  data() {
    const max = 30
    return {
      max,
      rules: [
        v => !!v || '',
        v => (!!v && max >= v.length) || `${max}文字以内で記述してください`
      ]
    }
  },
  computed: {
    setName: {
      get() { return this.name },
      set(newVal) { return this.$emit('update:name', newVal) }
    }
  }
}
</script>