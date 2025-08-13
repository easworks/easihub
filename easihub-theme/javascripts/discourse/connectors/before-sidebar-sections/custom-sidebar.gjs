import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { concat } from '@ember/helper';
import { on } from '@ember/modifier';
import { action } from '@ember/object';

class MenuItemBadge {
  @tracked count;
  @tracked class;

  constructor(data) {
    this.count = data.count;
    this.class = data.class;
  }
}

class MenuItem {

  static fromArray(rawItems) {
    return rawItems.map(item => new MenuItem(item));
  }

  @tracked id;
  @tracked label;
  @tracked href;
  @tracked icon;
  @tracked badge;
  @tracked isActive;
  @tracked expanded;
  @tracked showDots;
  @tracked children;
  @tracked level;
  parent;

  constructor(data, parent = null) {
    this.id = data.id;
    this.label = data.label;
    this.href = data.href;
    this.icon = data.icon;
    this.badge = data.badge ? new MenuItemBadge(data.badge) : null;
    this.isActive = data.isActive || false;
    this.expanded = data.expanded || false;
    this.showDots = data.showDots || false;
    this.parent = parent;
    this.level = parent ? parent.level + 1 : 0;
    this.children = data.children ? data.children.map(child => new MenuItem(child, this)) : null;
  }

  @action
  toggleExpansion() {
    if(!this.children) {
      return;
    }

    this.expanded = !this.expanded;
  }
}

const menuItems = MenuItem.fromArray([
  {
    id: 'home',
    label: 'Home',
    href: 'https://easihub.com/home',
    icon: 'fa-home',
  },
  {
    id: 'my-posts',
    label: 'My Posts',
    href: 'https://easihub.com/my-posts',
    icon: 'fa-clipboard',
    badge: { count: 12, classes: '' }
  },
  {
    id: 'more',
    label: 'More',
    icon: 'fa-cog',
    children: [
      {
        id: 'about',
        label: 'About',
        href: 'https://easihub.com/about',
        icon: 'fa-user'
      },
      {
        id: 'faqs',
        label: 'FAQs',
        href: 'https://easihub.com/faqs',
        icon: 'fa-question-circle'
      },
      {
        id: 'groups',
        label: 'Groups',
        href: 'https://easihub.com/groups',
        icon: 'fa-users'
      },
      {
        id: 'badges',
        label: 'Badges',
        href: 'https://easihub.com/badges',
        icon: 'fa-star'
      }
    ]
  },
  {
    id: 'hubs',
    label: 'Hubs',
    icon: 'fa-play-circle',
    children: [
      {
        id: 'hub1',
        label: 'Hub1',
        href: 'https://easihub.com/hub1',
        icon: 'fa-play-circle'
      },
      {
        id: 'hub2',
        label: 'Hub2',
        href: 'https://easihub.com/hub2',
        icon: 'fa-play-circle'
      }
    ]
  },
  {
    id: 'all-hubs',
    label: 'All Hubs',
    href: 'https://easihub.com/all-hubs',
    icon: 'fa-book',
    showDots: true
  },
  {
    id: 'questions',
    label: 'Questions',
    href: 'https://easihub.com/questions',
    icon: 'fa-question-circle'
  },
  {
    id: 'tags',
    label: 'Tags',
    href: 'https://easihub.com/tags',
    icon: 'fa-tag'
  },
  {
    id: 'all-tags',
    label: 'All Tags',
    href: 'https://easihub.com/all-tags',
    icon: 'fa-tag',
    showDots: true
  },
  {
    id: 'drafts',
    label: 'Drafts',
    href: 'https://easihub.com/drafts',
    icon: 'fa-file-alt'
  },
  {
    id: 'users',
    label: 'Users',
    href: 'https://easihub.com/users',
    icon: 'fa-users'
  },
  {
    id: 'companies',
    label: 'Companies',
    icon: 'fa-building',
    children: [
      {
        id: 'jobs',
        label: 'Jobs',
        href: 'https://easihub.com/jobs',
        icon: 'fa-briefcase'
      }
    ]
  },
  {
    id: 'messages',
    label: 'Messages',
    icon: 'fa-envelope',
    badge: { count: 7, classes: '' },
    children: [
      {
        id: 'inbox',
        label: 'Inbox',
        href: 'https://easihub.com/inbox',
        icon: 'fa-inbox'
      },
      {
        id: 'new-message',
        label: 'New',
        href: 'https://easihub.com/new-message',
        icon: 'fa-plus'
      },
      {
        id: 'unread',
        label: 'Unread',
        href: 'https://easihub.com/unread',
        icon: 'fa-envelope'
      },
      {
        id: 'sent',
        label: 'Sent',
        href: 'https://easihub.com/sent',
        icon: 'fa-paper-plane'
      },
      {
        id: 'archive',
        label: 'Archive',
        href: 'https://easihub.com/archive',
        icon: 'fa-archive'
      }
    ]
  },
  {
    id: 'discussions',
    label: 'Discussions',
    href: 'https://easihub.com/discussions',
    icon: 'fa-comments',
    badge: { count: 23, classes: 'secondary' }
  },
  {
    id: 'articles',
    label: 'Articles',
    href: 'https://easihub.com/articles',
    icon: 'fa-file-alt'
  },
  {
    id: 'use-cases',
    label: 'Use Cases',
    href: 'https://easihub.com/use-cases',
    icon: 'fa-briefcase'
  },
  {
    id: 'events',
    label: 'Events',
    href: 'https://easihub.com/events',
    icon: 'fa-calendar-alt'
  },
  {
    id: 'bulletins',
    label: 'Bulletins',
    href: 'https://easihub.com/bulletins',
    icon: 'fa-bell'
  }
]);

export default class CustomSidebarComponent extends Component {
  @tracked expandedPath = [];
  @tracked activeItem = null;

  @action
  itemClicked(item) {
    item.toggleExpansion();
  }

  <template>
    <div id="custom-sidebar">
      <TreeComponent @items={{menuItems}} />
    </div>
  </template>
}

class TreeComponent extends Component {
  countExpanded(items) {
    let count = items.length; // count current items

    items.forEach(item => {
      if (item.children && item.expanded) {
        count += this.countExpanded(item.children);
      }
    });

    return count;
  }

  get submenuHeight() {
    let height = 0;
    if (this.args.expanded) {
      height = this.countExpanded(this.args.items) * 44;
    }
    return `${height}px`;
  }

  <template>
    <ul class="{{if @child 'submenu'}}"
        style="{{if @child (concat 'max-height: ' this.submenuHeight ';')}}">
      {{#each @items as |item|}}
        {{#if item.children }}
          <BranchTemplate @item={{item}} />
        {{else}}
          <LeafTemplate @item={{item}} />
        {{/if}}
      {{/each}}
    </ul>
  </template>
}

const LeafTemplate =
  <template>
    <li class="menu-item"
        style="{{concat '--level:' @item.level ';'}}">
      <a class="menu-link" href={{@item.href}}>
        <i class="menu-icon fa-icon fas {{@item.icon}}"></i>
        <span class="menu-label">{{@item.label}}</span>
        {{#if @item.badge}}
          <span class="badge {{@item.badge.classes}}">{{@item.badge.count}}</span>
        {{/if}}
        {{#if @item.showDots}}
          <i class="menu-dots fa-solid fa-ellipsis"></i>
        {{/if}}
      </a>
    </li>
  </template>;

const BranchTemplate =
  <template>
    <li class="menu-item {{if @item.expanded 'expanded'}}"
        style="{{concat '--level:' @item.level ';'}}">
      <div class="menu-link" {{on 'click' @item.toggleExpansion}}>
        <i class="menu-icon fa-icon fas {{@item.icon}}"></i>
        <span class="menu-label">{{@item.label}}</span>
        {{#if @item.badge}}
          <span class="badge {{@item.badge.classes}}">{{@item.badge.count}}</span>
        {{/if}}
        <i class="fa-icon fas fa-chevron-down expand-icon"></i>
      </div>
      <TreeComponent @items={{@item.children}} @child=true @expanded={{@item.expanded}}/>
    </li>
  </template>;