import { tracked } from '@glimmer/tracking';
import { getOwner } from '@ember/application';
import Service, { service } from '@ember/service';
import { SPECIAL_CATEGORIES } from '../consts';

export default class UrlDifferentiatorService extends Service {
  @service router;

  @tracked routeName;
  @tracked model;

  #callback = (transition) => {
    const route = transition.to;

    this.#processRoute(route);
  };

  constructor() {
    super(...arguments);
    this.router.on('routeDidChange', this.#callback);
    if (this.router.currentRoute) {
      this.#processRoute(this.router.currentRoute);
    }
  }

  willDestroy() {
    this.router.destroy('routeDidChange', this.#callback);
  }

  #processRoute(route) {
    const controller = getOwner(this).lookup(`controller:${route.name}`);
    if (controller) {
      this.model = controller.model;
    }
    else {
      this.model = null;
    }


    // this must be done last as it is being observed by
    // other components/services
    this.routeName = this.#computeRouteName(route);

    // console.debug('[url]', route.name, this.routeName);
  }

  #computeRouteName(route) {
    switch (route.name) {
      case 'discovery.category':
        if (this.model?.category.id === SPECIAL_CATEGORIES.feedback) {
          return `${route.name}.feedback`;
        }
        return this.#parseCategoryRoute(route, this.model.category);
      case 'tags.showCategory':
        return this.#parseCategoryRoute(route, this.model.category);
    }

    if (isAdminRoute(route)) {
      if (!route.name.startsWith('admin.')) {
        return `admin.${route.name}`;
      }
    }

    return route.name;
  }

  #parseCategoryRoute(route, category) {
    {
      switch (true) {
        case (category.isOfType('hub', 'domain')):
          return `${route.name}.domain`;
        case (category.isOfType('hub', 'software')):
          return `${route.name}.software`;
        default: {
          return route.name;
        }
      }
    }
  }
}

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