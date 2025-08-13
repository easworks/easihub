import Component from "@glimmer/component";
import { LinkTo } from '@ember/routing';
import { service } from '@ember/service';

export default class NavigationBarComponent extends Component {
  @service('url-differentiator') urld;
  @service router;

  LinkTo = LinkTo;

  allNavItems = {
    "Hubs": { text: "Hubs", icon: "M12 2L2 7v10c0 5.55 3.84 10 9 11 5.16-1 9-5.45 9-11V7l-10-5z" },
    "Browse All Questions": { text: "Browse All Questions", icon: "M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm1 17h-2v-2h2v2zm2.07-7.75l-.9.92C13.45 12.9 13 13.5 13 15h-2v-.5c0-1.1.45-2.1 1.17-2.83l1.24-1.26c.37-.36.59-.86.59-1.41 0-1.1-.9-2-2-2s-2 .9-2 2H8c0-2.21 1.79-4 4-4s4 1.79 4 4c0 .88-.36 1.68-.93 2.25z" },
    "Ask Questions": { text: "Ask Questions", icon: "M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm1 17h-2v-2h2v2zm2.07-7.75l-.9.92C13.45 12.9 13 13.5 13 15h-2v-.5c0-1.1.45-2.1 1.17-2.83l1.24-1.26c.37-.36.59-.86.59-1.41 0-1.1-.9-2-2-2s-2 .9-2 2H8c0-2.21 1.79-4 4-4s4 1.79 4 4c0 .88-.36 1.68-.93 2.25z" },
    "Discussion": { text: "Discussion", icon: "M21 6h-2v9H6v2c0 .55.45 1 1 1h11l4 4V7c0-.55-.45-1-1-1zm-4 6V3c0-.55-.45-1-1-1H3c-.55 0-1 .45-1 1v14l4-4h11c.55 0 1-.45 1-1z" },
    "Use Cases": { text: "Use Cases", icon: "M19 3H5c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2zm-5 14H7v-2h7v2zm3-4H7v-2h10v2zm0-4H7V7h10v2z" },
    "Articles": { text: "Articles", icon: "M14 2H6c-1.1 0-1.99.9-1.99 2L4 20c0 1.1.89 2 2 2h12c1.1 0 2-.9 2-2V8l-6-6zm2 16H8v-2h8v2zm0-4H8v-2h8v2zm-3-5V3.5L18.5 9H13z" },
    "Bulletins": { text: "Bulletins", icon: "M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z" },
    "Events": { text: "Events", icon: "M17 12h-5v5h5v-5zM16 1v2H8V1H6v2H5c-1.11 0-1.99.9-1.99 2L3 19c0 1.1.89 2 2 2h14c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2h-1V1h-2zm3 18H5V8h14v11z" },
    "Jobs": { text: "Jobs", icon: "M20 6h-2.5l-1.5-1.5h-5L9.5 6H7c-1.1 0-2 .9-2 2v10c0 1.1.9 2 2 2h13c1.1 0 2-.9 2-2V8c0-1.1-.9-2-2-2zm0 12H7V8h2.5l1.5-1.5h5L17.5 8H20v10z" },
    "Unanswered": { text: "Unanswered", icon: "M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm1 17h-2v-2h2v2zm2.07-7.75l-.9.92C13.45 12.9 13 13.5 13 15h-2v-.5c0-1.1.45-2.1 1.17-2.83l1.24-1.26c.37-.36.59-.86.59-1.41 0-1.1-.9-2-2-2s-2 .9-2 2H8c0-2.21 1.79-4 4-4s4 1.79 4 4c0 .88-.36 1.68-.93 2.25z" },
    "Latest": { text: "Latest", icon: "M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z" },
    "Hot": { text: "Hot", icon: "M13.5.67s.74 2.65.74 4.8c0 2.06-1.35 3.73-3.41 3.73-2.07 0-3.63-1.67-3.63-3.73l.03-.36C5.21 7.51 4 10.62 4 14c0 4.42 3.58 8 8 8s8-3.58 8-8C20 8.61 17.41 3.8 13.5.67zM11.71 19c-1.78 0-3.22-1.4-3.22-3.14 0-1.62 1.05-2.76 2.81-3.12 1.77-.36 3.6-1.21 4.62-2.58.39 1.29.59 2.65.59 4.04 0 2.65-2.15 4.8-4.8 4.8z" }
  };

  buttonTextMap = {
    'questions': 'Ask Question',
    'discussion': 'Start Discussion',
    'use-cases': 'Share Use Case',
    'articles': 'Propose Article',
    'bulletins': 'Post Bulletin',
    'events': 'Add Event',
    'jobs': 'Post Job'
  };

  get categoryPath() {
    const currentRoute = this.router.currentRoute;
    return currentRoute?.params?.category_slug_path_with_id || '';
  }

  get currentPath() {
    return this.router.currentURL;
  }

  getRouteInfo(type) {
    const { categoryPath } = this;

    switch (this.urld.routeName) {
      case 'discovery.category.domain':
      case 'tags.showCategory.domain':
        switch (type) {
          case 'Hubs': return { route: 'discovery.category', models: [categoryPath] };
          case 'Articles': return { route: 'tags.showCategory', models: [categoryPath, 'articles'] };
          case 'Events': return { route: 'tags.showCategory', models: [categoryPath, 'events'] };
          case 'Jobs': return { route: 'tags.showCategory', models: [categoryPath, 'jobs'] };
        }
        break;
      case 'discovery.category.software':
      case 'tags.showCategory.software':
        switch (type) {
          case 'Hubs': return { route: 'discovery.category', models: [categoryPath] };
          case 'Browse All Questions': return { route: 'tags.showCategory', models: [categoryPath, 'questions'] };
          case 'Articles': return { route: 'tags.showCategory', models: [categoryPath, 'articles'] };
          case 'Bulletins': return { route: 'tags.showCategory', models: [categoryPath, 'bulletins'] };
          case 'Events': return { route: 'tags.showCategory', models: [categoryPath, 'events'] };
          case 'Jobs': return { route: 'tags.showCategory', models: [categoryPath, 'jobs'] };
        }
        break;
      case 'discovery.category.technical-area':
      case 'tags.showCategory.technical-area':
        switch (type) {
          case 'Ask Questions': return { route: 'tags.showCategory', models: [categoryPath, 'questions'] };
          case 'Discussion': return { route: 'tags.showCategory', models: [categoryPath, 'discussion'] };
          case 'Use Cases': return { route: 'tags.showCategory', models: [categoryPath, 'use-cases'] };
          case 'Unanswered': return { route: 'tags.showCategory', models: [categoryPath, 'unanswered'] };
          case 'Latest': return { route: 'tags.showCategory', models: [categoryPath, 'latest'] };
          case 'Hot': return { route: 'tags.showCategory', models: [categoryPath, 'hot'] };
        }
        break;
    }
    return { route: 'discovery.latest', models: [] };
  }



  get navItems() {
    let buttonsToShow = [];

    switch (this.urld.routeName) {
      case 'discovery.category.domain':
      case 'tags.showCategory.domain': {
        buttonsToShow = ['Hubs', 'Articles', 'Events', 'Jobs'];
      } break;
      case 'discovery.category.software':
      case 'tags.showCategory.software': {
        buttonsToShow = ['Hubs', 'Browse All Questions', 'Articles', 'Bulletins', 'Events', 'Jobs'];
      } break;
      case 'discovery.category.technical-area':
      case 'tags.showCategory.technical-area': {
        buttonsToShow = ['Ask Questions', 'Discussion', 'Use Cases', 'Unanswered', 'Latest', 'Hot'];
      } break;
    }

    return buttonsToShow.map(buttonName => {
      const routeInfo = this.getRouteInfo(buttonName);
      return {
        ...this.allNavItems[buttonName],
        route: routeInfo.route,
        models: routeInfo.models
      };
    }).filter(Boolean);
  }

  <template>
    {{#if this.navItems.length}}
      <nav class="navigation-bar">
        <ul class="nav-list">
          {{#each this.navItems as |item|}}
            <li>
              <this.LinkTo @route={{item.route}} @models={{item.models}} class="nav-button" @activeClass="active">
                <svg class="nav-icon" viewBox="0 0 24 24" width="16" height="16">
                  <path d={{item.icon}}/>
                </svg>
                <span>{{item.text}}</span>
              </this.LinkTo>
            </li>
          {{/each}}
        </ul>
      </nav>
    {{/if}}
  </template>
}