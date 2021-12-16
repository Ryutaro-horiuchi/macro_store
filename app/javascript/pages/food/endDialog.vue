<template>
  <v-card>
    <v-container>
      <v-row justify="center">
        <v-col cols="10">
          <v-card-title class="text-xs-subtitle-1 text-md-h4 mt-5">
            <v-row justify="center">
              <p>
                ナイスチョイス！！
                お疲れ様でした！
              </p>
            </v-row>
          </v-card-title>
        </v-col>
      </v-row>
      <v-row justify="center">
        <v-col
          cols="7"
          md="4"
        >
          <v-img
            :src="flyImg"
            max-height="300"
            max-width="400"
          />
        </v-col>
        <v-col
          cols="7"
          md="4"
        >
          <v-card-subtitle class="text-xs-subtitle-1 text-md-h6 mt-5">
            <p>[豆知識]</p>
            {{ message }}
          </v-card-subtitle> 
        </v-col>
      </v-row>
      <v-row
        class="my-8"
      >
        <v-col
          cols="2"
          offset="2"
          md="4"
        >
          <v-row justify="left">
            <v-btn
              color="#1c65ac"
              dark
              x-large
              elevation="3"
              @click="closeEndDialog"
            >
              戻る
            </v-btn>
          </v-row>
        </v-col>
        <v-col
          cols="2"
          offset="2"
          md="4"
        >
          <v-row justify="right">
            <v-btn
              color="#1c65ac"
              dark
              x-large
              elevation="3"
              @click="toTopPage(); closeEndDialog()"
            >
              終了する
            </v-btn>
          </v-row>
        </v-col>
      </v-row>
    </v-container>
  </v-card>
</template>

<script>
import { mapActions } from "vuex";

export default {
  data() {
    return {
      flyImg: require("../../../assets/images/undraw_i_can_fly_7egl (2).png"),
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
    ...mapActions(["closeEndDialog"]),
    toTopPage() {
      this.$router.push('/')
      this.$store.dispatch("removeAllSelectedFood")
    },
  }
}
</script>

