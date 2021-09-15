import Vue from 'vue';
import Router from 'vue-router';
import TopPage from '../pages/Top.vue';
import SignupPage from '../pages/Signup.vue';

Vue.use(Router);

export default new Router({
  mode: 'history',
  routes: [{path: '/', component: TopPage},
           {path: '/signup', component: SignupPage} 
  ]       
})