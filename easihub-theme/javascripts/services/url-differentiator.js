import Service, { service } from '@ember/service';
import { getOwner } from '@ember/application';
import { tracked } from '@glimmer/tracking';

export default class UrlDifferentiatorService extends Service {
  @service router;

  @tracked routeName;
  @tracked model;

  #callback = (transition) => {
    const route = transition.to;

    this.#processRoute(route);
  }

  constructor() {
    super(...arguments);
    this.router.on('routeDidChange', this.#callback);
    if (this.router.currentRoute)
      this.#processRoute(this.router.currentRoute);
  }

  willDestroy() {
    this.router.destroy('routeDidChange', this.#callback);
  }

  #processRoute(route) {
    const controller = getOwner(this).lookup(`controller:${route.name}`);
    this.model = controller.model;

    // this must be done last as it is being observed by
    // other components/services
    this.routeName = this.#computeRouteName(route);
  }

  #computeRouteName(route) {
    switch (route.name) {
      case 'discovery.category':
      case 'tags.showCategory': {
        if (route.params.category_slug_path_with_id === 'feedback/179') {
          return `${route.name}.feedback`
        }

        const segments = route.params.category_slug_path_with_id.split('/');

        if (segments.length === 2 && numeric.test(segments[1]))
          return `${route.name}.domain`;

        if (segments.length === 3 && numeric.test(segments[2])) {
          if (genericTopicsPattern.test(segments[1]))
            return `${route.name}.technical-area`;
          return `${route.name}.software`;
        }

        if (segments.length === 4 && numeric.test(segments[3]))
          return `${route.name}.technical-area`;
      }
    }

    if (isAdminRoute(route)) {
      if (!route.name.startsWith('admin.'))
        return `admin.${route.name}`;
    }

    return route.name;
  }
}

const numeric = /^\d+$/;
const genericTopicsPattern = /^generic-.+-topics$/;

function isAdminRoute(route) {
  let currentRoute = route;

  while (currentRoute) {
    if (currentRoute.name === 'admin') {
      return true;
    }
    currentRoute = currentRoute.parent;
  }

  return false;
}