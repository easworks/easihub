import Component from "@glimmer/component";
import { tracked } from '@glimmer/tracking';
import { LinkTo } from '@ember/routing';
import { service } from '@ember/service';

export default class NavigationBarComponent extends Component {
  @service('url-differentiator') urld;

  @tracked navItems = [];

  onRouteChange = () => {
    const route = this.urld.router.currentRoute;
    this.#updateNavItems(route);
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
        buttonsToShow = ['Hubs', 'Articles', 'Events', 'Jobs'];
      } break;
      case 'software': {
        buttonsToShow = ['Hubs', 'Browse All Questions', 'Articles', 'Bulletins', 'Events', 'Jobs'];
      } break;
      case 'technical-area': {
        buttonsToShow = ['Overview', 'Ask Questions', 'Discussion', 'Use Cases'];
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
      case 'Discussion': return { route: 'tags.showCategory', models: [categoryPath, 'discussion'] };
      case 'Use Cases': return { route: 'tags.showCategory', models: [categoryPath, 'use-cases'] };
      case 'Unanswered': return { route: 'tags.showCategory', models: [categoryPath, 'unanswered'] };
      case 'Latest': return { route: 'tags.showCategory', models: [categoryPath, 'latest'] };
      case 'Hot': return { route: 'tags.showCategory', models: [categoryPath, 'hot'] };
      default: return { route: 'discovery.latest', models: [] };
    }
  }

  <template>
    {{#if this.navItems.length}}
      <nav class="navigation-bar">
        <ul class="nav-list">
          {{#each this.navItems as |item|}}
            <li>
              <LinkTo @route={{item.route}} @models={{item.models}} class="nav-button" @activeClass="active">
                <i class="{{item.icon}}"></i>
                <span>{{item.text}}</span>
              </LinkTo>
            </li>
          {{/each}}
        </ul>
      </nav>
    {{/if}}
  </template>
}

const itemMap = {
  "Overview": { text: "Overview", icon: "fas fa-home" },
  "Hubs": { text: "Hubs", icon: "fas fa-network-wired" },
  "Browse All Questions": { text: "Browse All Questions", icon: "fas fa-question-circle" },
  "Ask Questions": { text: "Ask Questions", icon: "fas fa-question" },
  "Discussion": { text: "Discussion", icon: "fas fa-comments" },
  "Use Cases": { text: "Use Cases", icon: "fas fa-lightbulb" },
  "Articles": { text: "Articles", icon: "fas fa-file-alt" },
  "Bulletins": { text: "Bulletins", icon: "fas fa-thumbtack" },
  "Events": { text: "Events", icon: "fas fa-calendar-alt" },
  "Jobs": { text: "Jobs", icon: "fas fa-briefcase" },
  "Unanswered": { text: "Unanswered", icon: "fas fa-question-circle" },
  "Latest": { text: "Latest", icon: "fas fa-clock" },
  "Hot": { text: "Hot", icon: "fas fa-fire" }
};
