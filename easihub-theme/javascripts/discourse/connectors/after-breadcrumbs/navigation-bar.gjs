import Component from "@glimmer/component";
import { tracked } from '@glimmer/tracking';
import { LinkTo } from '@ember/routing';
import { service } from '@ember/service';
import { DomainSoftwareNavTabsComponent } from '../../../components/nav-tabs';


export default class NavigationBarComponent extends Component {
  @service('url-differentiator') urld;

  @tracked navItems = [];
  @tracked shouldShowModelNav = false;

  onRouteChange = () => {
    const route = this.urld.router.currentRoute;
    this.#updateNavItems(route);
    this.shouldShowModelNav = route.name === 'discovery.categories';
  };


  constructor() {
    super(...arguments);

    // run it once on init
    this.onRouteChange();

    this.urld.addObserver('routeName', this.onRouteChange);
  }

  willDestroy() {
    super.willDestroy();
    this.urld.removeObserver('routeName', this.onRouteChange);
  }

  #updateNavItems(route) {
    if (this.#isFeedbackCategory(route)) {
      this.navItems = [];
      return;
    }

    let buttonsToShow = [];

    let type;
    switch (route.name) {
      case 'discovery.category':
      case 'tags.showCategory': {
        type = this.urld.routeName.split('.')[2];
      } break;
    }

    switch (type) {
      case 'domain': {
        buttonsToShow = ['Hubs', 'Ask Questions', 'Discussions', 'Articles', 'Jobs'];
      } break;
      case 'software': {
        buttonsToShow = ['Ask Questions', 'Discussions', 'Use Cases', 'Articles', 'Jobs'];
      } break;
      case 'technical-area': {
        buttonsToShow = ['Overview', 'Ask Questions', 'Discussions', 'Use Cases'];
      } break;
    }

    const categoryPath = this.categoryPath(route);

    this.navItems = buttonsToShow.map(buttonName => {
      const routeInfo = this.getRouteInfo(buttonName, categoryPath);
      return {
        ...itemMap[buttonName],
        route: routeInfo.route,
        models: routeInfo.models
      };
    }).filter(Boolean);
  }

  categoryPath(route) {
    return route?.params?.category_slug_path_with_id || '';
  }

  #isFeedbackCategory() {
    return this.urld.routeName === 'discovery.category.feedback';
  }

  getRouteInfo(type, categoryPath) {
    switch (type) {
      case 'Hubs': return { route: 'discovery.category', models: [categoryPath] };
      case 'Overview': return { route: 'tags.showCategory', models: [categoryPath, 'overview'] };
      case 'Articles': return { route: 'tags.showCategory', models: [categoryPath, 'articles'] };
      case 'Events': return { route: 'tags.showCategory', models: [categoryPath, 'events'] };
      case 'Jobs': return { route: 'tags.showCategory', models: [categoryPath, 'jobs'] };
      case 'Browse All Questions': return { route: 'tags.showCategory', models: [categoryPath, 'questions'] };
      case 'Bulletins': return { route: 'tags.showCategory', models: [categoryPath, 'bulletins'] };
      case 'Ask Questions': return { route: 'tags.showCategory', models: [categoryPath, 'questions'] };
      case 'Discussions': return { route: 'tags.showCategory', models: [categoryPath, 'discussions'] };
      case 'Use Cases': return { route: 'tags.showCategory', models: [categoryPath, 'use-cases'] };
      case 'Unanswered': return { route: 'tags.showCategory', models: [categoryPath, 'unanswered'] };
      case 'Latest': return { route: 'tags.showCategory', models: [categoryPath, 'latest'] };
      case 'Hot': return { route: 'tags.showCategory', models: [categoryPath, 'hot'] };
      default: return { route: 'discovery.latest', models: [] };
    }
  }

  <template>
    {{#if this.shouldShowModelNav}}
    <DomainSoftwareNavTabsComponent />
    {{/if}}

    {{#if this.navItems.length}}
      <nav class="eas-tabs d-link-color-black">
        {{#each this.navItems as |item|}}
          <LinkTo @route={{item.route}} @models={{item.models}} class="tab" @activeClass="active">
            <i class="{{item.icon}}"></i>
            <span class="ml-1">{{item.text}}</span>
          </LinkTo>
        {{/each}}
      </nav>
    {{/if}}
  </template>
}

const itemMap = {
  "Overview": { text: "Overview", icon: "fas fa-home" },
  "Hubs": { text: "Hubs", icon: "fas fa-network-wired" },
  "Browse All Questions": { text: "Browse All Questions", icon: "fas fa-question-circle" },
  "Ask Questions": { text: "Ask Questions", icon: "fas fa-question" },
  "Discussions": { text: "Discussions", icon: "fas fa-comments" },
  "Use Cases": { text: "Use Cases", icon: "fas fa-lightbulb" },
  "Articles": { text: "Articles", icon: "fas fa-file-alt" },
  "Bulletins": { text: "Bulletins", icon: "fas fa-thumbtack" },
  "Events": { text: "Events", icon: "fas fa-calendar-alt" },
  "Jobs": { text: "Jobs", icon: "fas fa-briefcase" },
  "Unanswered": { text: "Unanswered", icon: "fas fa-question-circle" },
  "Latest": { text: "Latest", icon: "fas fa-clock" },
  "Hot": { text: "Hot", icon: "fas fa-fire" }
};
