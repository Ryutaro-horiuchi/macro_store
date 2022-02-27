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
        'ingestionCal'
      ],
      storage: window.sessionStorage
    }
  )
  ],
  state: {
    flashMessage: "",
    flashColor: null,
    flashStatus: false,
    drawer: false, // ナビゲーションのドロワー
    foodDialog: false, //食品詳細
    user: null,
    foods: null, //検索結果後の食品配列
    food: null, //ダイアログに表示される食品データ
    bookmarkedFoods: [],
    ingestionCal: null,
  },
  getters: {
    flashMessage: state => state.flashMessage,
    flashColor: state => state.flashColor,
    flashStatus: state => state.flashStatus,
    drawer: state => state.drawer,
    foodDialog: state => state.foodDialog,
    user: state => state.user,
    bookmarkedFoods: state => state.bookmarkedFoods,
    foods: state => state.foods,
    food: state => state.food,
    ingestionCal: state => state.ingestionCal,
  },
  mutations: {
    changeDrawer(state) {
      state.drawer = !state.drawer;
    },
    setUser(state, data) {
      state.user = data
    },
    setBookmarkedFoods(state, foods) {
      state.bookmarkedFoods = foods
    },
    addToBookmarkedFoods(state, food) {
      state.bookmarkedFoods.push(food)
    },
    deleteFromBookmarkedFoods(state, deletefood) {
      state.bookmarkedFoods = state.bookmarkedFoods.filter((food) => {
        return food.id !== deletefood.id
      })
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
    saveIngestionCal(state, calorie) {
      state.ingestionCal = calorie
      Object.keys(state.ingestionCal).forEach(function (key) {
        state.ingestionCal[key] = Math.round(state.ingestionCal[key])
      })
    },
    clearIngestionCal(state) {
      state.ingestionCal = null
    },
    setMessage(state, message) {
      state.flashMessage = message
    },
    setColor(state, color) {
      state.flashColor = color
    },
    setStatus(state, status) {
      state.flashStatus = status
    }
  },
  actions: {
    changeDrawer({ commit }) {
      commit('changeDrawer');
    },
    async fetchAuthUser({ commit, state }) {
      if (!localStorage.idToken) return null
      if (state.user) return state.user

      const userResponse = await axios.get('users/me')
        .catch((err) => {
          return null
        })
      if (!userResponse) return null


      if (userResponse) {
        commit('setUser', userResponse.data.user)
        commit('setBookmarkedFoods', userResponse.data.foods)
      } else {
        commit('setUser', null)
      }
    },
    signup(context, params) {
      if (context.getters.ingestionCal !== null) {
        Object.assign(params.user, context.getters.ingestionCal)
      }
      return axios.post('/signup', params)
        .then(res => {
          router.push('/login')
          context.dispatch('flashMessage', {
            message: 'ユーザー登録が完了しました、ログインしてください',
            color: 'success',
            status: true,
          })
        })
        .catch(err => {
          context.dispatch('flashMessage', {
            message: '無効なメールアドレスです',
            color: 'orange',
            status: true,
          })
        })
    },
    login(context, user) {
      return axios.post('/login', user)
        .then(res => {
          localStorage.idToken = res.data.token
          axios.defaults.headers.common['Authorization'] = `Bearer ${localStorage.idToken}`
          const loginUser = res.data.user
          context.commit('setUser', loginUser)
          context.commit('setBookmarkedFoods', res.data.foods)
          context.dispatch('flashMessage', {
            message: 'ログインしました',
            color: 'success',
            status: true,
          })
          router.push('/')
        })
        .catch(err => {
          context.dispatch('flashMessage', {
            message: 'ログインに失敗しました',
            color: 'orange',
            status: true,
          })
        })
    },
    logout(context) {
      localStorage.removeItem('idToken')
      context.commit('setUser', null)
      context.dispatch('flashMessage', {
        message: 'ログアウトしました',
        color: 'success',
        status: true,
      })
      router.push('/')
    },
    update(context, params) {
      axios.patch('/update', params)
        .then(res => {
          context.commit('setUser', res.data)
          router.push('/mypage')
          context.dispatch('flashMessage', {
            message: 'ユーザー情報を更新しました',
            color: 'success',
            status: true,
          })
        })
        .catch(err => {
          context.dispatch('flashMessage', {
            message: '更新に失敗しました',
            color: 'orange',
            status: true,
          })
        })
    },
    searchName({ commit }, name) {
      setTimeout(() => {
        return axios.post('/search/name', name)
          .then(res => {
            commit('foodList', res.data)
          })
          .catch(err => {
            console.log(err)
          })
      }, 1000);
    },
    searchNutrient({ commit }, nutrients) {
      setTimeout(() => {
        // 最小値がnullであれば、0を代入する。リファクタリングする
        if (nutrients.carbohydrateMinimum === null) {
          nutrients.carbohydrateMinimum = 0
        }
        if (nutrients.proteinMinimum === null) {
          nutrients.proteinMinimum = 0
        }
        if (nutrients.lipidMinimum === null) {
          nutrients.lipidMinimum = 0
        }
        return axios.post('/search/nutrient', nutrients)
          .then(res => {
            commit('foodList', res.data)
          })
          .catch(err => {
            console.log(err)
          })
      }, 1000);
    },
    makeBookmark(context, food) {
      if (context.state.user === null) {
        context.dispatch('flashMessage', {
          message: 'ログインが必要です',
          color: 'blue',
          status: true,
        })
        router.push('/login')
      }
      else {
        return axios.post('/bookmarks/create', food)
          .then(res => {
            context.commit('addToBookmarkedFoods', res.data)
          })
          .catch(err => {
            console.log(err)
          })
      }
    },
    removeBookmark({ commit }, food) {
      return axios.post('/bookmarks/destroy', food)
        .then(res => {
          commit('deleteFromBookmarkedFoods', res.data)
        })
        .catch(err => {
          console.log(err)
        })
    },
    flashMessage({ commit }, { message, color, status }) {
      commit('setMessage', message)
      commit('setColor', color)
      commit('setStatus', status)
      setTimeout(() => {
        commit('setStatus', !status)
      }, 1500)
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
    saveIngestionCal({ commit }, calorie) {
      commit('saveIngestionCal', calorie)
    }
  }
})
