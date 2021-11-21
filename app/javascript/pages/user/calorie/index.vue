<template>
  <v-container>
    <v-row class="text-left">
      <v-col cols="10" offset="1" class="mt-10">
        <h3>Q1. 性別を選択してください</h3>
        <v-row justify="center" class="mt-5">
          <v-col
            cols="4"
            offset="1"
          >
            <v-btn
              class="mx-auto"
              x-large
              outlined
              elevation="3"
            >
              男性
            </v-btn>
          </v-col>
          <v-col
            cols="4"
            offset="1"
          >
            <v-btn
              class="mx-auto"
              x-large
              outlined
              elevation="3"
            >
              女性
            </v-btn>
          </v-col>
        </v-row>
      </v-col>
      <v-col cols="10" offset="1" class="mt-10">
        <h3>Q2. 年齢を選択してください</h3>
        <v-row justify="center" class="mt-5">
          <v-col
            cols="6"
          >
            <v-select
              :items="items"
              outlined
              suffix="歳"
            ></v-select>
          </v-col>
        </v-row>
      </v-col>
      <v-col cols="10" offset="1" class="mt-10">
        <h3>Q3. 体重を入力してください</h3>
        <v-row justify="center" class="mt-5">
          <v-col cols="6">
            <v-form>
              <v-text-field
                    outlined
                    suffix="Kg"
                    >
              </v-text-field>
            </v-form>
          </v-col>
        </v-row>
      </v-col>
      <v-col cols="10" offset="1" class="mt-10">
        <h3>Q4. 運動量を以下より選択してください</h3>
        <v-row cols="8" offset="4" justify="left" class="mt-5">
          <v-radio-group>
            <v-radio
              v-for="exercise in exercises"
              :key="exercise"
              :label="exercise"
              :value="n"
              class="mt-5">
            </v-radio>
          </v-radio-group>
        </v-row>
      </v-col>
    </v-row>
    <v-row justify="center" class="mt-15">
      <v-col
        cols="4"
        offset="1"
      >
        <v-btn
          class="mx-auto"
          large
          outlined
          elevation="3"
        >
          戻る
        </v-btn>
      </v-col>
      <v-col
        cols="4"
        offset="1"
      >
        <v-btn
          class="mx-auto"
          large
          outlined
          elevation="3"
        >
          計算する
        </v-btn>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
export default {
  data() {
    return {
      items: ['12 ~ 14', '15 ~ 17', '18 ~ 29', '30 ~ 49', '50 ~ 69', '70'],
      exercises: [
                  '安静にしていることが多い。通勤などの歩行を除いて座っている時間が長い',
                  '歩行時間が長い。立った姿勢での作業も比較的多い',
                  '1日1時間程度、ウォーキングやサイクリングなど体を動かしている',
                  '1日1時間程度、激しいトレーニングや運搬など体に負荷がかかることをしている'
                ]
    }
  }
}
</script>