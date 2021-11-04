import Vue from 'vue'
import Vuex from 'vuex'
import axios from '../plugins/axios'
import router from '../router/index'

Vue.use(Vuex);

export default new Vuex.Store({
  state: {
    drawer: false,
    user: null,
    foods: null
  },
  getters: {
    drawer: state => state.drawer,
    user: state => state.user,
    foods: state => state.foods
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
    nutrientSearch({ commit }, proteinValue) {
      if (proteinValue.minimum === null) {
        proteinValue.minimum = 0
      }
      return axios.post('/search/nutrient', proteinValue)
      .then(res => {
        commit('foodList', res.data)
      })
      .catch(err => {
        console.log(err)
      })
    }
  }
})