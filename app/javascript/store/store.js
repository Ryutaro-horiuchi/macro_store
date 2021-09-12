import Vue from 'vue'
import Vuex from 'vuex'

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
    }
  },
  actions: {
    changeDrawer(context) {
      context.commit('changeDrawer');
    }
  }
})