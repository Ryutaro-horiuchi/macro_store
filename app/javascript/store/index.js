import Vue from 'vue'
import Vuex from 'vuex'
import axios from '../plugins/axios'

Vue.use(Vuex);

export default new Vuex.Store({
  state: {
    drawer: false
  },
  getters: {
    drawer: state => state.drawer
  },
  mutations: {
    changeDrawer(state) {
      state.drawer = !state.drawer;
    },
    loggedIn(state, payload) {
      state.loggedIn = payload
    }
  },
  actions: {
    changeDrawer(context) {
      context.commit('changeDrawer');
    },
    signUp(context, user) {
      return axios.post('/users', user)
      .then(res => {
        console.log(user)
      })
      .catch(err => {
        console.log(err)
      })
    },
    login(context) {
      context.commit('loggedIn', true)
    }
  }
})