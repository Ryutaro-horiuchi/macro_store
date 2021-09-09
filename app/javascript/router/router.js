import Vue from 'vue';
import Router from 'vue-router';
import TopIndex from '../pages/top/index.vue'

Vue.use(Router);

export default new Router({
  mode: 'history',
  routes: [{path: '/', component: TopIndex}]
})