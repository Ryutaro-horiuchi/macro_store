/* eslint no-console: 0 */
// Run this example by adding <%= javascript_pack_tag 'hello_vue' %> (and
// <%= stylesheet_pack_tag 'hello_vue' %> if you have styles in your component)
// to the head of your layout file,
// like app/views/layouts/application.html.erb.
// All it does is render <div>Hello Vue</div> at the bottom of the page.

import Vue from 'vue'
import App from '../app.vue'
import vuetify from '../plugins/vuetify'
import axios from '../plugins/axios'
import router from '../router'
import store from '../store'
import VueLoaders from 'vue-loaders';
import 'vue-loaders/dist/vue-loaders.css';

Vue.use(VueLoaders)
Vue.prototype.$axios = axios

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    vuetify,
    router,
    store,
    render: h => h(App)
  }).$mount()
  document.body.appendChild(app.$el)
})

// ページ遷移のたびに実行。fetchAuthUserを取得し、ログインが必要なページであれば、ログインページに遷移するようにする。

router.beforeEach((to, from, next) => {
  store.dispatch('fetchAuthUser').then((authUser) => {
    if (to.matched.some(record => record.meta.requiredAuth) && !authUser) {
      next(('/login'));
    } else {
      next();
    }
  })
})
