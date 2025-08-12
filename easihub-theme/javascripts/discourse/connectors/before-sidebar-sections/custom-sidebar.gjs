import Component from '@glimmer/component';

export default class CustomSidebarComponent extends Component {
  categories = [];

  items = [
    { text: 'Home', href: '/', icon: 'fa-home', class: 'home' },
    { text: 'My Posts', href: '#', icon: 'fa-clipboard', class: 'myposts', id: 'myposts-link' },
    { text: 'Review', href: 'https://easihub.com/review', icon: 'fa-review-circle', class: 'review' },
    { text: 'Admin', href: 'https://easihub.com/admin', icon: 'fa-admin-circle', class: 'admin' },
    { text: 'All Hubs', href: '/categories', icon: '', class: 'allhubs' },
    { text: 'Questions', href: 'https://easihub.com/tag/questions', icon: 'fa-question-circle', class: 'questions' },
    { text: 'All Tags', href: '/tags', icon: '', class: 'all-tags allhubs' },
    { text: 'Drafts', href: '#', icon: 'fa-file-alt', class: 'drafts', id: 'drafts-link' },
    { text: 'Users', href: '/u', icon: 'fa-users', class: 'users' },
    { text: 'Discussions', href: 'https://easihub.com/tag/discussion', icon: 'fa-comments', class: 'discussion' },
    { text: 'Articles', href: 'https://easihub.com/tag/articles', icon: 'fa-file-alt', class: 'articles' },
    { text: 'Use Cases', href: 'https://easihub.com/tag/use-cases', icon: 'fa-briefcase', class: 'usercases' },
    { text: 'Events', href: 'https://easihub.com/tag/events', icon: 'fa-calendar-alt', class: 'events' },
    { text: 'Bulletins', href: 'https://easihub.com/tag/bulletins', icon: 'fa-bell', class: 'bulletins' }
  ];

  <template>
    <div id="custom-sidebar" class="w-64 bg-white shadow-md">
      <div class="nbg-gray-100 navigation-cont">
        <ul class="side-navigation-ul">
          {{#each this.items as |item|}}
            <li class="flex items-center hover:bg-gray-200 cursor-pointer {{item.class}}">
              <a href={{item.href}} class="text-gray-8001" id={{item.id}}>
                {{#if item.icon}}
                  <i class="fas {{item.icon}} fa-icon"></i>
                {{/if}}
                <span>{{item.text}}</span>
              </a>
            </li>
          {{/each}}
        </ul>
      </div>
    </div>
  </template>
}
