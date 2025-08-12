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
    this.routeName = transition.to.name;

    const controller = getOwner(this).lookup(`controller:${this.routeName}`);
    this.model = controller.model;
  }

  constructor() {
    super(...arguments);
    this.router.on('routeDidChange', this.#callback);
  }

  willDestroy() {
    this.router.destroy('routeDidChange', this.#callback);
  }
}