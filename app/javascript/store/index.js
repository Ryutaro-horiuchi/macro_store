import Vue from 'vue'
import Vuex from 'vuex'
import createPersistedState from 'vuex-persistedstate'
import axios from '../plugins/axios'
import router from '../router/index'

Vue.use(Vuex);

export default new Vuex.Store({
  plugins: [createPersistedState(
    {
      key: 'MacroStore',
      paths: [
        'foods',
        'selectFoods',
        'current_nutrients'
      ]
    }
  )
  ],
  state: {
    drawer: false,
    foodDialog: false,
    endDialog: false,
    user: null,
    foods: null,
    food: null,
    ingestionCal: {},
    selectFoods: [],
    current_nutrients: { calorie: 0, carbohydrate: 0, protein: 0, lipid: 0 }
  },
  getters: {
    drawer: state => state.drawer,
    foodDialog: state => state.foodDialog,
    endDialog: state => state.endDialog,
    user: state => state.user,
    foods: state => state.foods,
    food: state => state.food,
    ingestionCal: state => state.ingestionCal,
    current_nutrients: state => state.current_nutrients,
    selectFoods: state => state.selectFoods
  },
  mutations: {
    changeDrawer(state) {
      state.drawer = !state.drawer;
    },
    setUser(state, data) {
      state.user = data
    },
    foodList(state, data) {
      state.foods = data
      router.push('foods')
    },
    openDialog(state, food_data) {
      state.food = food_data
      state.foodDialog = true
    },
    closeDialog(state) {
      state.foodDialog = false
    },
    openEndDialog(state) {
      state.endDialog = true
    },
    closeEndDialog(state) {
      state.endDialog = false
    },
    roundOff(state) {
      // キーの配列を取得し、それらをforEachで要素ごとに四捨五入を実行する
      Object.keys(state.current_nutrients).forEach(function (key) {
        state.current_nutrients[key] =  Math.round(state.current_nutrients[key] * 100) / 100;
      })
    },
    addNutrients(state, food) {
      state.current_nutrients["calorie"] += food.calorie
      state.current_nutrients["carbohydrate"] += food.carbohydrate
      state.current_nutrients["protein"] += food.protein
      state.current_nutrients["lipid"] += food.lipid
      // キーの配列を取得し、それらをforEachで要素ごとに四捨五入を実行する
    },
    removeNutrients(state, food) {
     state.current_nutrients["calorie"] -= food.calorie * food.quantity
      state.current_nutrients["carbohydrate"] -= food.carbohydrate * food.quantity
      state.current_nutrients["protein"] -= food.protein * food.quantity
      state.current_nutrients["lipid"] -= food.lipid * food.quantity
    },
    multiplyNutrient(state, multiplyData) {
      // multiplyData[0]には前回の数量との差の値が入っている。[1]はfoodのオブジェクト。[2]は新しく指定した数量の値
      state.current_nutrients["calorie"] += multiplyData[1].calorie * multiplyData[0]
      state.current_nutrients["carbohydrate"] += multiplyData[1].carbohydrate * multiplyData[0]
      state.current_nutrients["protein"] += multiplyData[1].protein * multiplyData[0]
      state.current_nutrients["lipid"] += multiplyData[1].lipid * multiplyData[0]
      // multiplyData[2には新しい数値が入っている]
      state.selectFoods.find((food) => {
        if (food.id === multiplyData[1].id) {
          food.quantity = multiplyData[2]
        }
      })
    },
    selectFood(state, food) {
      food["quantity"] = 1
      state.selectFoods.push(food)
    },
    deleteFood(state, deleteFood) {
      state.selectFoods = state.selectFoods.filter((food) => {
        return food.id !== deleteFood.id
      })
    },
    removeAllSelectedFood(state) {
      state.selectFoods = []
      Object.keys(state.current_nutrients).forEach(function (key) {
        state.current_nutrients[key] = 0
      })
      state.foods = null
      localStorage.removeItem('MacroStore')
    },
    saveIngestionCal(state, calorie ) {
      state.ingestionCal = calorie
      Object.keys(state.ingestionCal).forEach(function (key) {
        state.ingestionCal[key] =  Math.round(state.ingestionCal[key])
      })
    }
  },
  actions: {
    changeDrawer({ commit }) {
      commit('changeDrawer');
    },
    async fetchAuthUser({ commit , state }) {
      if(!localStorage.idToken) return null
      if(state.user) return state.user

      const userResponse = await axios.get('users/me')
      .catch((err) => {
        return null
      })
      if (!userResponse) return null

      const authUser = userResponse.data
      if (authUser) {
        commit('setUser', authUser)
      } else {
        commit('setUser', null)
      }
    },
    signUp({ commit }, user ) {
      return axios.post('/users', user)
      .then(res => {
        router.push('/login')
      })
      .catch(err => {
        console.log(err)
      })
    },
    login({ commit }, user ) {
      return axios.post('/login', user)
      .then(res => {
        localStorage.setItem('idToken', res.data.token);
        commit('setUser', res.data.user)
        router.push('/')
      })
      .catch(err => {
        console.log(err)
      })
    },
    logout({ commit }) {
      localStorage.removeItem('idToken')
      commit('setUser', null)
    },
    nameSearch({ commit }, name) {
      return axios.post('/search', name)
      .then(res => {
        commit('foodList', res.data)
      })
      .catch(err => {
        console.log(err)
      })
    },
    nutrientsSearch({ commit },value) {
    // 最小値がnullであれば、0を代入する。冗長なのでリファクタリングする
      if (value.carboValue.minimum === null) {
        value.carboValue.minimum = 0
      }
      if (value.proteinValue.minimum === null) {
        value.proteinValue.minimum = 0
      }
      if (value.lipidValue.minimum === null) {
        value.lipidValue.minimum = 0
      }
      return axios.post('/search/nutrient', value)
      .then(res => {
        commit('foodList', res.data)
      })
      .catch(err => {
        console.log(err)
      })
    },
    openDialog({ commit }, food_data) {
      commit('openDialog', food_data)
    },
    closeDialog({ commit }) {
      commit('closeDialog')
    },
    openEndDialog({ commit }) {
      commit('openEndDialog')
    },
    closeEndDialog({ commit }) {
      commit('closeEndDialog')
    },
    async addNutrients({ commit }, food) {
      await commit('addNutrients', food)
      commit('roundOff')
      commit('closeDialog')
    },
    async removeNutrients({ commit }, food) {
      await commit('removeNutrients', food)
      commit('roundOff')
    },
    async multiplyNutrient({ commit }, multiplyData) {
      await commit('multiplyNutrient', multiplyData)
      commit('roundOff')
    },
    selectFood({ commit }, food) {
      commit('selectFood', food)
    },
    deleteFood({ commit }, deleteFood) {
      commit('deleteFood', deleteFood)
    },
    removeAllSelectedFood({ commit }) {
      commit('removeAllSelectedFood')
    },
    saveIngestionCal({ commit }, calorie) {
      console.log(calorie)
      commit('saveIngestionCal', calorie)
    }
  }
})
