import { tracked } from '@glimmer/tracking';
import { action } from '@ember/object';

export class MenuItemBadge {
  @tracked count;
  @tracked class;

  constructor(data) {
    this.count = data.count;
    this.class = data.class;
  }
}

export class MenuItem {

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

export function createMenuItemFromCategory(category, parent) {
  if (!category) {
    return null;
  }

  const href = [
    '/c',
    ...category.ancestors.map(c => c.slug),
    category.id
  ].join('/');

   const data =  {
    id: `category-${category.id}`,
    label: category.name,
    href,
    icon: 'fa-folder',
    badge: category.topic_count > 0 ? {
      count: category.topic_count,
      class: 'category-badge'
    } : null
  };

  return new MenuItem(data, parent);
}

export function constructMenu(user) {
  const menu = MenuItem.fromArray(publicMenu);

  if (user) {
    transformForUser(menu, user);
    if (user.admin) {
      transformForAdmin(menu, user);
    }
  }
  return menu;
};


const publicMenu = [
  {
    id: 'home',
    label: 'Home',
    href: '/',
    icon: 'fa-home',
  },
  {
    id: 'more',
    label: 'More',
    icon: 'fa-ellipsis-h',
    children: [
      {
        id: 'about',
        label: 'About',
        href: '/about-us',
        icon: 'fa-info-circle'
      },
      {
        id: 'faqs',
        label: 'FAQs',
        href: '/faq',
        icon: 'fa-question'
      },
      {
        id: 'groups',
        label: 'Groups',
        href: '/g',
        icon: 'fa-users'
      },
      {
        id: 'badges',
        label: 'Badges',
        href: '/badges',
        icon: 'fa-award'
      }
    ]
  },
  {
    id: 'review',
    label: 'Review',
    href: 'https://easihub.com/review',
    icon: 'fa-star'
  },
  {
    id: 'hubs',
    label: 'Hubs',
    icon: 'fa-network-wired',
    children: [
      // Dynamic categories will be loaded here
      // ERP, CRM, PLM, SCM, HCM, Cloud Platforms, BA/BI, MES, QMS
    ]
  },
  {
    id: 'all-hubs',
    label: 'All Hubs',
    href: '/categories',
    icon: 'fa-list',
    showDots: true
  },
  {
    id: 'questions',
    label: 'Questions',
    href: 'https://easihub.com/tag/questions',
    icon: 'fa-question-circle'
  },
  {
    id: 'tags',
    label: 'Tags',
    icon: 'fa-tags',
    children: [
      // Dynamic tags will be loaded here
    ]
  },
  {
    id: 'all-tags',
    label: 'All Tags',
    href: '/tags',
    icon: 'fa-tag'
  },
  {
    id: 'users',
    label: 'Users',
    href: '/u',
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
        href: '/tag/job',
        icon: 'fa-briefcase'
      }
    ]
  },
  {
    id: 'discussions',
    label: 'Discussions',
    href: 'https://easihub.com/tag/discussion',
    icon: 'fa-comments'
  },
  {
    id: 'articles',
    label: 'Articles',
    href: 'https://easihub.com/tag/articles',
    icon: 'fa-file-alt'
  },
  {
    id: 'use-cases',
    label: 'Use Cases',
    href: 'https://easihub.com/tag/use-cases',
    icon: 'fa-briefcase'
  },
  {
    id: 'events',
    label: 'Events',
    href: 'https://easihub.com/tag/events',
    icon: 'fa-calendar-alt'
  },
  {
    id: 'bulletins',
    label: 'Bulletins',
    href: 'https://easihub.com/tag/bulletins',
    icon: 'fa-bell'
  }
];


function transformForUser(menu, user) {
  menu.splice(1, 0, new MenuItem({
    id: 'my-posts',
    label: 'My Posts',
    href: '#',
    icon: 'fa-clipboard',
  }));

  menu.splice(9, 0, new MenuItem({
    id: 'drafts',
    label: 'Drafts',
    href: '#',
    icon: 'fa-file-alt'
  }));

  menu.splice(12, 0, new MenuItem({
    id: 'messages',
    label: 'Messages',
    icon: 'fa-envelope',
    children: [
      {
        id: 'inbox',
        label: 'Inbox',
        href: 'https://easihub.com/u/easdevub_admin/messages',
        icon: 'fa-inbox'
      },
      {
        id: 'new-message',
        label: 'New',
        href: 'https://easihub.com/u/easdevub_admin/messages/new',
        icon: 'fa-edit'
      },
      {
        id: 'unread',
        label: 'Unread',
        href: 'https://easihub.com/u/easdevub_admin/messages/unread',
        icon: 'fa-envelope-open'
      },
      {
        id: 'sent',
        label: 'Sent',
        href: 'https://easihub.com/u/easdevub_admin/messages/sent',
        icon: 'fa-paper-plane'
      },
      {
        id: 'archive',
        label: 'Archive',
        href: 'https://easihub.com/u/easdevub_admin/messages/archive',
        icon: 'fa-archive'
      }
    ]
  }));
}

function transformForAdmin(menu, user) {
  menu.splice(4, 0, new MenuItem({
    id: 'admin',
    label: 'Admin',
    href: 'https://easihub.com/admin',
    icon: 'fa-cog'
  }));
}
