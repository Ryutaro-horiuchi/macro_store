import Vue from 'vue'
import Vuex from 'vuex'
import axios from '../plugins/axios'
import router from '../router/index'

Vue.use(Vuex);

export default new Vuex.Store({
  state: {
    drawer: false,
    user: null
  },
  getters: {
    drawer: state => state.drawer,
    user: state => state.user
  },
  mutations: {
    changeDrawer(state) {
      state.drawer = !state.drawer;
    },
    setUser(state, data) {
      state.user = data
    },
  },
  actions: {
    changeDrawer(context) {
      context.commit('changeDrawer');
    },
    signUp(context, user) {
      return axios.post('/users', user)
      .then(res => {
        console.log(res)
      })
      .catch(err => {
        console.log(err)
      })
    },
    login(context, user) {
      return axios.post('/login', user)
      .then(res => {
        localStorage.setItem('idToken', res.data.token);
        context.commit('setUser', res.data.user)
      })
      .catch(err => {
        console.log(err)
      })
    },
    logout(context) {
      localStorage.removeItem('idToken')
      context.commit('setUser', null)
    }
  }
})