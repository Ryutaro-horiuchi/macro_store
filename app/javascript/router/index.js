import Vue from 'vue';
import Router from 'vue-router';
import top from '../pages/top/index.vue';
import register from '../pages/user/register/index.vue';
import login from '../pages/user/login/index.vue';
import calorie from '../pages/user/calorie/index.vue';
import search from '../pages/food/search.vue';
import food from '../pages/food/index.vue'
import confirmation from '../pages/food/confirmation.vue';

Vue.use(Router);

export default new Router({
  mode: 'history',
  routes: [{path: '/', component: top},
           {path: '/signup', component: register},
           {path: '/login', component: login},
           {path: '/calorie', component: calorie},
           {path: '/search', component: search},
           {path: '/foods', component: food},
           {path: '/confirmation', component: confirmation}
  ]       
})