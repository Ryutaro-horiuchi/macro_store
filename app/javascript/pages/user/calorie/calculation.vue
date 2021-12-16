<template>
  <v-container class="mt-14">
    <v-form v-model="isValid">
      <v-row class="text-left">
        <v-col
          cols="10"
          offset="1"
          class="mt-10"
        >
          <h3>Q1. 性別を選択してください</h3>
          <v-row
            justify="center"
            class="mt-5"
          >
            <v-radio-group
              v-model="selectedSex"
              row
              :rules="selectRules"
            >
              <v-radio
                label="男性"
                value="male"
              />
              <v-radio
                label="女性"
                value="female"
              />
            </v-radio-group>
          </v-row>
        </v-col>
        <v-col
          cols="10"
          offset="1"
          class="mt-10"
        >
          <h3>Q2. 年齢を選択してください</h3>
          <v-row
            justify="center"
            class="mt-5"
          >
            <v-col
              cols="6"
            >
              <template v-if="isMale">
                <v-select
                  v-model="selectedAge"
                  :items="maleAge"
                  outlined
                  background-color="white"
                  suffix="歳"
                  item-text="showLabel"
                  item-value="selectedValue"
                  :rules="selectRules"
                />
              </template>
              <template v-if="!isMale">
                <v-select
                  v-model="selectedAge"
                  :items="femaleAge"
                  outlined
                  background-color="white"
                  suffix="歳"
                  item-text="showLabel"
                  item-value="selectedValue"
                  :rules="selectRules"
                />  
              </template>
            </v-col>
          </v-row>
        </v-col>
        <v-col
          cols="10"
          offset="1"
          class="mt-10"
        >
          <h3>Q3. 体重を入力してください</h3><br>
          <v-col offset="1">
            <p>※小数点第一位以下は切り捨て</p>
          </v-col>
          <v-row
            justify="center"
            class="mt-5"
          >
            <v-col cols="6">
              <v-form>
                <v-text-field
                  v-model="weight"
                  outlined
                  background-color="white"
                  suffix="kg"
                  :rules="weightRules"
                />
              </v-form>
            </v-col>
          </v-row>
        </v-col>
        <v-col
          cols="10"
          offset="1"
          class="mt-10"
        >
          <h3>Q4. 日々の運動量に近いものを選択してください</h3>
          <v-row class="mt-5">
            <v-col>
              <v-radio-group
                v-model="selectedExercise"
                :rules="selectRules"
              >
                <v-radio
                  label="安静にしていることが多い。通勤などの歩行を除いて座っている時間が長い"
                  value="1.3"
                  class="mt-5"
                />
                <v-radio
                  label="2時間程度の歩行や、家事等立った姿勢での作業が比較的多い"
                  value="1.5"
                  class="mt-5"
                />
                <v-radio
                  label="1日1時間程度、ウォーキングやジョギング、農作業など体に負荷がかかることをしている"
                  value="1.7"
                  class="mt-5"
                />
                <v-radio
                  label="1日1時間程度、運搬や激しいトレーニングなど、激しく体に負荷がかかることをしている"
                  value="1.9"
                  class="mt-5"
                />
              </v-radio-group>
            </v-col>
          </v-row>
        </v-col>
      </v-row>
      <v-row
        justify="center"
        class="my-10"
      >
        <v-col
          cols="6"
        >
          <v-row justify="center">
            <v-btn
              color="#1c65ac"
              dark
              x-large
              elevation="3"
              @click="toTopPage"
            >
              戻る
            </v-btn>
          </v-row>
        </v-col> 
        <v-col
          cols="6"
        >
          <v-row justify="center">
            <v-btn
              :disabled="!isValid"
              color="#1c65ac"
              dark
              x-large
              elevation="3"
              @click="calculateCalorie"
            >
              計算する
            </v-btn>
          </v-row>
        </v-col>
      </v-row>
    </v-form>
  </v-container>
</template>

<script>
export default {
  data() {
    return {
      isValid: false,
      selectedSex: null,
      selectedAge: null,
      weight: null,
      selectedExercise: null,
      consumedCalorie: { calorie: 0, carbohydrate: 0, protein: 0, lipid: 0 },
      weightRules: [
        v => !!v || '',
        v => /^[\d]+$/.test(v) || '数値を入力してください',
        v => /^[\d]{2,3}$/.test(v) || '2桁〜3桁の間で入力してください'
      ],
      selectRules: [
        v => !!v || '選択されていません'
      ],
      maleAge: [
        {selectedValue: '31.0', showLabel: '12 ~ 14'},
        {selectedValue: '27.0', showLabel: '15 ~ 17'},
        {selectedValue: '24.0', showLabel: '18 ~ 29'},
        {selectedValue: '22.3', showLabel: '30 ~ 49'}, 
        {selectedValue: '21.5', showLabel: '50 ~ 69'},
        {selectedValue: '21.5', showLabel: '70'}
      ],
      femaleAge: [
        {selectedValue: '29.6', showLabel: '12 ~ 14'},
        {selectedValue: '25.3', showLabel: '15 ~ 17'},
        {selectedValue: '22.1', showLabel: '18 ~ 29'},
        {selectedValue: '21.7', showLabel: '30 ~ 49'}, 
        {selectedValue: '20.7', showLabel: '50 ~ 69'},
        {selectedValue: '20.7', showLabel: '70'}
      ],
    }
  },
  computed: {
    isMale() {
      return this.selectedSex === 'male'
    }
  },
  methods: {
    calculateCalorie() {
      this.consumedCalorie["calorie"]　= (this.selectedAge * this.weight * this.selectedExercise - 300) / 3;
      this.consumedCalorie["carbohydrate"] = this.consumedCalorie["calorie"] * 0.55 / 4 
      this.consumedCalorie["protein"] = this.consumedCalorie["calorie"] * 0.25 / 4 
      this.consumedCalorie["lipid"] = this.consumedCalorie["calorie"] * 0.2 / 9 
      this.$store.dispatch("saveIngestionCal", this.consumedCalorie)
      this.$router.push('/result')
    },
    toTopPage() {
      this.$router.push('/')
    }
  }
}
</script>

<style scoped>
</style>