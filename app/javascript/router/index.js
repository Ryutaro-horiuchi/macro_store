import Vue from 'vue';
import Router from 'vue-router';
import top from '../pages/top/index.vue';
import privacy from '../pages/top/privacy.vue';
import terms from '../pages/top/terms.vue';
import register from '../pages/user/register/index.vue';
import login from '../pages/user/login/index.vue';
import result from '../pages/calorie/result.vue'
import search from '../pages/food/search.vue';
import food from '../pages/food/index.vue'
import bookmarkFoods from '../pages/food/bookmarkFoods.vue';
import myPage from '../pages/user/myPage/index.vue';
import editPage from '../pages/user/myPage/edit.vue';
import calculation from '../pages/user/calculation/index.vue'

Vue.use(Router);

export default new Router({
  mode: 'history',
  routes: [{path: '/', component: top},
           {path: '/privacy', component: privacy},
           {path: '/terms', component: terms},
           {path: '/signup', component: register},
           {path: '/login', component: login},
           {path: '/result', component: result},
           {path: '/search', component: search},
           {path: '/foods', component: food},
           {path: '/bookmark', component: bookmarkFoods,
            meta: { requiredAuth: true },
           },
           {path: '/mypage', component: myPage,
            meta: { requiredAuth: true },
           },
           {path: '/edit', component: editPage,
            meta: { requiredAuth: true },
           },
           {path: '/calculation', component: calculation},
  ],
  scrollBehavior(to, from, savedPosition) {
    if (savedPosition) {
      return savedPosition
    } else {
      return { x: 0, y: 0 };
    }
  }     
})