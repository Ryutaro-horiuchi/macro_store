<template>
  <v-card>
    <v-row justify="center">
      <v-col cols="10">
        <v-card-title class="text-xs-subtitle-1 text-md-h5 mt-5">
          <p>
            ナイスチョイス！！<br>
            お疲れ様でした！
          </p>
        </v-card-title>
        <v-img :src="flyImg" />
        <v-card-subtitle class="text-xs-subtitle-1 text-md-h6 mt-5">
          <p>[豆知識]</p>
          {{ message }}
        </v-card-subtitle> 
      </v-col> 
      <v-row
        justify="center"
        class="my-8"
      >
        <v-col
          cols="2"
          md="4"
        >
          <v-row justify="center">
            <v-btn
              x-large
              outlined
              elevation="3"
              @click="closeEndDialog"
            >
              戻る
            </v-btn>
          </v-row>
        </v-col>
        <v-col
          cols="2"
          offset="4"
          md="4"
        >
          <v-row justify="center">
            <v-btn
              x-large
              outlined
              elevation="3"
              @click="toTopPage"
            >
              終了する
            </v-btn>
          </v-row>
        </v-col>
      </v-row>
    </v-row>
  </v-card>
</template>

<script>
import { mapActions } from "vuex";

export default {
  data() {
    return {
      flyImg: require("../../../assets/images/undraw_i_can_fly_7egl.png"),
      message: null,
      messages: ["炭水化物とたんぱく質は1gあたり4kcalですが、脂質は1gあたり9kcalと多いので取りすぎに注意です！",
                 "朝食の前に有酸素運動をすると、脂肪を燃やしやすいのでおすすめです！",
                 "たんぱく質は筋肉の他にも、肌や髪の毛、骨の材料となっています！",
                 "脂質はカロリーが高いため、取りすぎには要注意ですが、ホルモンや細胞の材料にもなっているので、適切な量を摂取しましょう！",
                 "炭水化物は体を動かすエネルギーであり、極端に減らすと体のだるさ、やる気の低下にもつながってしまいます！"]
    }
  },
  created() {
    this.message = this.messages[Math.floor(Math.random() * this.messages.length)]
  },
  methods: {
    ...mapActions(["closeEndDialog", "removeAllSelectedFood"]),
    toTopPage() {
      this.$router.push('/')
      this.$store.dispatch("removeAllselectedFood")
    },
  }
}
</script>

