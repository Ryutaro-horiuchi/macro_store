import Vue from 'vue';
import Router from 'vue-router';
import top from '../pages/top/index.vue';
import register from '../pages/user/register/index.vue';
import login from '../pages/user/login/index.vue';

Vue.use(Router);

export default new Router({
  mode: 'history',
  routes: [{path: '/', component: top},
           {path: '/signup', component: register},
           {path: '/login', component: login}
  ]       
})