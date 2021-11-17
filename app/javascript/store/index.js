import Vue from 'vue'
import Vuex from 'vuex'
import axios from '../plugins/axios'
import router from '../router/index'

Vue.use(Vuex);

export default new Vuex.Store({
  state: {
    drawer: false,
    food_dialog: false,
    user: null,
    foods: null,
    food: null,
    current_nutrients: { calorie: 0, carbohydrate: 0, protein: 0, lipid: 0 }
  },
  getters: {
    drawer: state => state.drawer,
    food_dialog: state => state.food_dialog,
    user: state => state.user,
    foods: state => state.foods,
    food: state => state.food,
    current_nutrients: state => state.current_nutrients
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
      state.food_dialog = true
    },
    closeDialog(state) {
      state.food_dialog = false
    },
    addNutrients(state, nutrients) {
      state.current_nutrients["calorie"] += nutrients.calorie
      state.current_nutrients["carbohydrate"] += nutrients.carbohydrate
      state.current_nutrients["protein"] += nutrients.protein
      state.current_nutrients["lipid"] += nutrients.lipid
      // キーの配列を取得し、それらをforEachで要素ごとに四捨五入を実行する
      Object.keys(state.current_nutrients).forEach(function (key) {
        state.current_nutrients[key] =  Math.round(state.current_nutrients[key] * 100) / 100;
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
    addNutrients({ commit }, nutrients) {
      commit('addNutrients', nutrients)
      commit('closeDialog')
    }
  }
})
