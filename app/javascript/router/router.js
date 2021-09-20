import Vue from 'vue';
import Router from 'vue-router';
import TopPage from '../pages/Top.vue';
import SignupPage from '../pages/Signup.vue';
import LoginPage from '../pages/Login.vue';

Vue.use(Router);

export default new Router({
  mode: 'history',
  routes: [{path: '/', component: TopPage},
           {path: '/signup', component: SignupPage},
           {path: '/login', component: LoginPage}
  ]       
})