import Service, { service } from '@ember/service';
import { getOwner } from '@ember/application';
import { tracked } from '@glimmer/tracking';

export class UrlDifferentiatorService extends Service {
  static init(api) {
    api.container.registry.register('service:url-differentiator', UrlDifferentiatorService);
    api.container.lookup('service:url-differentiator');
  }

  @service router;

  @tracked routeName;
  @tracked model;

  #callback = (transition) => {
    const route = transition.to;

    const controller = getOwner(this).lookup(`controller:${route.name}`);
    this.model = controller.model;

    // this must be done last as it is being observed by
    // other components/services
    this.routeName = this.#computeRouteName(route);
  }

  constructor() {
    super(...arguments);
    this.router.on('routeDidChange', this.#callback);
  }

  willDestroy() {
    this.router.destroy('routeDidChange', this.#callback);
  }

  #computeRouteName = (route) => {
    switch (route.name) {
      case 'discovery.category':
      case 'tags.showCategory': {
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

    return route.name;
  }
}

const numeric = /^\d+$/;
const genericTopicsPattern = /^generic-.+-topics$/;