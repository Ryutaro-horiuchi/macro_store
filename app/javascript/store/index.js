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
        'current_nutrients',
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
    drawer: false,
    foodDialog: false,
    endDialog: false,
    user: null,
    foods: null,
    food: null,
    selectFoods: [],
    bookmarkedFoods: [],
    ingestionCal: null,
    current_nutrients: { calorie: 0, carbohydrate: 0, protein: 0, lipid: 0 }
  },
  getters: {
    flashMessage: state => state.flashMessage,
    flashColor :state => state.flashColor,
    flashStatus: state => state.flashStatus,
    drawer: state => state.drawer,
    foodDialog: state => state.foodDialog,
    endDialog: state => state.endDialog,
    user: state => state.user,
    bookmarkedFoods: state => state.bookmarkedFoods,
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
    saveIngestionCal(state, calorie) {
      state.ingestionCal = calorie
      Object.keys(state.ingestionCal).forEach(function (key) {
        state.ingestionCal[key] =  Math.round(state.ingestionCal[key])
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
    async fetchAuthUser({ commit , state }) {
      if(!localStorage.idToken) return null
      if(state.user) return state.user
      
      const userResponse = await axios.get('users/me')
      .catch((err) => {
        return null
      })
      if (!userResponse) return null
      

      if (userResponse) {
        commit('setUser', userResponse.data.user)
        commit('setBookmarkedFoods', userResponse.data.foods )
      } else {
        commit('setUser', null)
      }
    },
    signUp(context, params ) {
      if (context.getters.ingestionCal !== null) {
        params.user["calorie"] = context.getters.ingestionCal["calorie"]
        params.user["carbohydrate"] = context.getters.ingestionCal["carbohydrate"]
        params.user["protein"] = context.getters.ingestionCal["protein"] 
        params.user["lipid"] = context.getters.ingestionCal["lipid"]
      } 
      return axios.post('/signUp', params)
      .then(res => {
        router.push('/login')
        context.dispatch('flashMessage', {
          message: 'ユーザー登録が完了しました',
          color: 'success',
          status: 'true',
        })
      })
      .catch(err => {
        context.dispatch('flashMessage', {
          message: '無効なメールアドレスです',
          color: 'orange',
          status: 'true',
        })
      })
    },
    login(context,  user) {
      return axios.post('/login', user)
      .then(res => {
        localStorage.idToken = res.data.token
        axios.defaults.headers.common['Authorization'] = `Bearer ${localStorage.idToken}`
        const loginUser = res.data.user
        context.commit('setUser', loginUser)
        if (loginUser.calorie) {
          const ingestionCal = {}
          ingestionCal["calorie"] = loginUser.calorie
          ingestionCal["carbohydrate"] = loginUser.carbohydrate
          ingestionCal["protein"] = loginUser.protein
          ingestionCal["lipid"] = loginUser.lipid
          context.commit('saveIngestionCal', ingestionCal)
        }
        context.commit('setBookmarkedFoods', res.data.foods)
        context.dispatch('flashMessage', {
          message: 'ログインしました',
          color: 'success',
          status: 'true',
        })
        router.push('/')
      })
      .catch(err => {
        context.dispatch('flashMessage', {
          message: 'ログインに失敗しました',
          color: 'orange',
          status: 'true',
        }) 
      })
    },
    logout(context) {
      localStorage.removeItem('idToken')
      context.commit('setUser', null)
      context.commit('clearIngestionCal')
      context.dispatch('flashMessage', {
        message: 'ログアウトしました',
        color: 'success',
        status: 'true',
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
    searchNutrient({ commit }, value) {
      setTimeout(() => {
    // 最小値がnullであれば、0を代入する。リファクタリングする
        if (value.carbohydrateValue.minimum === null) {
          value.carbohydrateValue.minimum = 0
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
      }, 1000);
    },
    makeBookmark(context, food) {
      if (context.state.user === null) {
          context.dispatch('flashMessage', {
            message: 'ログインが必要です',
            color: 'blue',
            status: 'true',
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
    flashMessage({ commit }, {message, color, status}) {
      commit('setMessage', message)
      commit('setColor', color)
      commit('setStatus', status)
      setTimeout(() => {
        commit('setStatus', false)
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
      commit('saveIngestionCal', calorie)
    }
  }
})
