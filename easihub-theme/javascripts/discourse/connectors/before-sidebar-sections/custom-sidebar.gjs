import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { fn } from '@ember/helper';
import { on } from '@ember/modifier';
import { action } from '@ember/object';

  /**
   * @typedef {Object} MenuItem
   * @property {string?} id
   * @property {string} label
   * @property {string} href
   * @property {string} icon
   * @property {Object} badge
   * @property {number} badge.count
   * @property {string} badge.class
   * @property {boolean} active
   * @property {boolean} expanded
   * @property {boolean} dots
   * @property {MenuItem[]} children
   */

export default class CustomSidebarComponent extends Component {
  @tracked expandedPath = [];
  @tracked activeItem = null;

   /** @type {MenuItem[]} */
  @tracked
  items = [
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
  ];

  categories = [];

  constructor() {
    super(...arguments);
    this.setupKeyboardNavigation();
    this.setupAutoExpand();
  }

  willDestroy() {
    super.willDestroy();
    document.removeEventListener('keydown', this.handleKeydown);
  }

  @action
  toggleSubmenu(clickedItem) {
    // 1. Get the path to the clicked item
    let newPath = findItemPath(this.items, clickedItem);

    // 2. If item is already in expandedPath, we're collapsing
    if (this.expandedPath.includes(clickedItem)) {
      // Find index of clicked item in expandedPath (not newPath)
      let expandedIndex = this.expandedPath.indexOf(clickedItem);

      // Keep only the parents (everything before clicked item in expandedPath)
      this.expandedPath = this.expandedPath.slice(0, expandedIndex);

      // Close the item that was clicked
      clickedItem.expanded = false;
    } else {
      // 3. We're expanding - close current path first
      this.expandedPath.forEach(item => item.expanded = false);

      // 4. Set new expanded path and expand all items in path
      this.expandedPath = newPath.filter(item => item.children); // Only items with children
      this.expandedPath.forEach(item => item.expanded = true);
    }

    // Force reactivity by reassigning the array
    this.items = [...this.items];
  };

  @action
  handleMenuClick (clickedItem) {
    // Clear previous active item
    if (this.activeItem) {
      this.activeItem.isActive = false;
    }

    // Set new active item
    this.activeItem = clickedItem;
    clickedItem.isActive = true;

    // Force reactivity by reassigning the array
    this.items = [...this.items];
  };

  @action
  handleSubmenuClick(clickedChild) {
    // Clear previous active item
    if (this.activeItem) {
      this.activeItem.isActive = false;
    }

    // Set new active item
    this.activeItem = clickedChild;
    clickedChild.isActive = true;

    // Force reactivity by reassigning the array
    this.items = [...this.items];
  };

  setupKeyboardNavigation() {
    this.handleKeydown = (event) => {
      if (event.key === 'Escape') {
        this.closeAllMenus();
      }
    };
    document.addEventListener('keydown', this.handleKeydown);
  }

  closeAllMenus() {
    this.expandedPath.forEach(item => {
      item.expanded = false;
    });
    this.expandedPath = [];
  }

  setupAutoExpand() {
    // Auto-expand menu if submenu item is active on page load
    const activeSubmenuItem = this.findActiveSubmenuItem(this.items);
    if (activeSubmenuItem) {
      const path = findItemPath(this.items, activeSubmenuItem.parent);
      if (path) {
        this.expandedPath = path.filter(item => item.children);
        this.expandedPath.forEach(item => item.expanded = true);
      }
    }
  }

  findActiveSubmenuItem(items, parent = null) {
    for (let item of items) {
      if (item.children) {
        const found = this.findActiveSubmenuItem(item.children, item);
        if (found) {
          return found;
        }
      } else if (item.isActive) {
        return { item, parent };
      }
    }
    return null;
  }







  <template>
    <div id="custom-sidebar">
      <ul>
        {{#each this.items as |item|}}
          <li class="menu-item {{if item.children 'has-submenu'}} {{if item.expanded 'expanded'}}">
            {{#if item.children}}
              <div class="menu-link" {{on "click" (fn this.toggleSubmenu item)}}>
                <svg class="menu-icon" viewBox="0 0 24 24">
                  {{item.icon}}
                </svg>
                <span class="menu-text">{{item.label}}</span>
                {{#if item.badge}}
                  <span class="badge {{item.badge.classes}}">{{item.badge.count}}</span>
                {{/if}}
                {{#if item.showDots}}
                  <span class="menu-dots">...</span>
                {{/if}}
                <svg class="expand-icon" viewBox="0 0 24 24">
                  <polyline points="6,9 12,15 18,9"></polyline>
                </svg>
              </div>
              <ul class="submenu">
                {{#each item.children as |child|}}
                  <li>
                    <a href={{child.href}} class="submenu-item {{if child.isActive 'active'}}" {{on "click" (fn this.handleSubmenuClick child)}}>
                      <svg class="submenu-icon" viewBox="0 0 24 24">
                        {{child.icon}}
                      </svg>
                      <span>{{child.label}}</span>
                    </a>
                  </li>
                {{/each}}
              </ul>
            {{else}}
              <a href={{item.href}} class="menu-link {{if item.isActive 'active'}}" {{on "click" (fn this.handleMenuClick item)}}>
                <svg class="menu-icon" viewBox="0 0 24 24">
                  {{item.icon}}
                </svg>
                <span class="menu-text">{{item.label}}</span>
                {{#if item.badge}}
                  <span class="badge {{item.badge.classes}}">{{item.badge.count}}</span>
                {{/if}}
                {{#if item.showDots}}
                  <span class="menu-dots">...</span>
                {{/if}}
              </a>
            {{/if}}
          </li>
        {{/each}}
      </ul>
    </div>
  </template>
}

function findItemPath(items, targetItem, currentPath = []) {
  for (let item of items) {
    let newPath = [...currentPath, item];

    if (item === targetItem) {
      return newPath; // Found the target, return the path
    }

    if (item.children) {
      let foundPath = findItemPath(item.children, targetItem, newPath);
      if (foundPath) {
        return foundPath;
      }
    }
  }
  return null; // Not found in this branch
}