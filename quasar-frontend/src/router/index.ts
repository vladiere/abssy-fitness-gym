import { route } from 'quasar/wrappers';
import { Platform } from 'quasar';
import {
  createMemoryHistory,
  createRouter,
  createWebHashHistory,
  createWebHistory,
} from 'vue-router';

import useAuthStore from 'stores/auth-store';
import routes from './routes';

/*
 * If not building with SSR mode, you can
 * directly export the Router instantiation;
 *
 * The function below can be async too; either use
 * async/await or return a Promise which resolves
 * with the Router instance.
 */

export default route(function (/* { store, ssrContext } */) {
  const auth = useAuthStore();
  const createHistory = process.env.SERVER
    ? createMemoryHistory
    : (process.env.VUE_ROUTER_MODE === 'history' ? createWebHistory : createWebHashHistory);

  const Router = createRouter({
    scrollBehavior: () => ({ left: 0, top: 0 }),
    routes,

    // Leave this as is and make changes in quasar.conf.js instead!
    // quasar.conf.js -> build -> vueRouterMode
    // quasar.conf.js -> build -> publicPath
    history: createHistory(process.env.VUE_ROUTER_BASE),
  });

  Router.beforeEach((to, from, next) => {

    if (Platform.is.electron) {
      console.log('Proceeding for electron route...')

      if (to.meta.auth && !auth.isAuthenticated && !auth.getAccessToken) {
        next({ name: 'login' })
      } else if (!to.meta.auth && auth.isAuthenticated && auth.getAccessToken) {
        next({ name: 'dashboard' })
      } else {
        next()
      }

    } else {
      console.log('Proceeding for not electron route...')
      if (to.meta.auth && !auth.isAuthenticated && !auth.getAccessToken) {
        next({ name: 'login' })
      } else if (!to.meta.auth && auth.isAuthenticated && auth.getAccessToken) {
        next({ name: 'dashboard' })
      } else {
        next()
      }
    }
  })

  return Router;
});
