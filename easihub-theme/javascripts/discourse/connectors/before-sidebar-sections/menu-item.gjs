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
  @tracked route;
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

    this.route = data.route;
    if (this.route){
      this.route.models ||= [];
    };
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

  const models = [
    category.path.substring(3)
  ];

   const data =  {
    id: `category-${category.id}`,
    label: category.name,
    icon: 'fa-folder',
    badge: category.topic_count > 0 ? {
      count: category.topic_count,
      class: 'category-badge'
    } : null,
    route: {
      name: 'discovery.category',
      models
    }
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
    icon: 'fa-home',
    route: {
      name: 'discovery.categories'
    }
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
        icon: 'fa-info-circle',
        route: {
          name: 'about-us'
        }
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
        icon: 'fa-users',
        route: {
          name: 'groups.index'
        }
      },
      {
        id: 'badges',
        label: 'Badges',
        route: {
          name: 'badges.index'
        }
      }
    ]
  },
  {
    id: 'review',
    label: 'Review',
    icon: 'fa-star',
    route: {
      name: 'review.index'
    }
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
    icon: 'fa-list',
    route: {
      name: 'discovery.categories'
    },
    showDots: true
  },
  {
    id: 'questions',
    label: 'Questions',
    route: {
      name: 'tag.show',
      models: ['question']
    },
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
    route: {
      name: 'tags.index'
    },
    icon: 'fa-tag'
  },
  {
    id: 'users',
    label: 'Users',
    icon: 'fa-users',
    route: {
      name: 'users'
    }
  },
  {
    id: 'companies',
    label: 'Companies',
    icon: 'fa-building',
    children: [
      {
        id: 'jobs',
        label: 'Jobs',
        icon: 'fa-briefcase',
        route: {
          name: 'tag.show',
          models: ['job']
        },
      }
    ]
  },
  {
    id: 'discussions',
    label: 'Discussions',
    icon: 'fa-comments',
    route: {
      name: 'tag.show',
      models: ['discussion']
    },
  },
  {
    id: 'articles',
    label: 'Articles',
    icon: 'fa-file-alt',
    route: {
      name: 'tag.show',
      models: ['articles']
    },
  },
  {
    id: 'use-cases',
    label: 'Use Cases',
    icon: 'fa-briefcase',
    route: {
      name: 'tag.show',
      models: ['use-cases']
    },
  },
  {
    id: 'events',
    label: 'Events',
    icon: 'fa-calendar-alt',
    route: {
      name: 'tag.show',
      models: ['events']
    },
  },
  {
    id: 'bulletins',
    label: 'Bulletins',
    icon: 'fa-bell',
    route: {
      name: 'tag.show',
      models: ['bulletins']
    },
  }
];


function transformForUser(menu, user) {
  menu.splice(1, 0, new MenuItem({
    id: 'my-posts',
    label: 'My Posts',
    icon: 'fa-clipboard',
    route: {
      name: 'userActivity.index',
      models: [user.username]
    }
  }));

  menu.splice(9, 0, new MenuItem({
    id: 'drafts',
    label: 'Drafts',
    icon: 'fa-file-alt',
    route:{
      name: 'userActivity.drafts',
      models: [user.username]
    },
  }));

  menu.splice(12, 0, new MenuItem({
    id: 'messages',
    label: 'Messages',
    icon: 'fa-envelope',
    children: [
      {
        id: 'inbox',
        label: 'Inbox',
        icon: 'fa-inbox',
        route: {
          name: 'userPrivateMessages.user.index',
          models:[user.username]
        }
      },
      {
        id: 'new-message',
        label: 'New',
        icon: 'fa-edit',
        route: {
          name: 'userPrivateMessages.user.new',
          models:[user.username]
        }
      },
      {
        id: 'unread',
        label: 'Unread',
        icon: 'fa-envelope-open',
        route: {
          name: 'userPrivateMessages.user.unread',
          models:[user.username]
        }
      },
      {
        id: 'sent',
        label: 'Sent',
        icon: 'fa-paper-plane',
        route: {
          name: 'userPrivateMessages.user.sent',
          models:[user.username]
        }
      },
      {
        id: 'archive',
        label: 'Archive',
        icon: 'fa-archive',
        route: {
          name: 'userPrivateMessages.user.archive',
          models:[user.username]
        }
      }
    ]
  }));
}

function transformForAdmin(menu, user) {
  menu.splice(4, 0, new MenuItem({
    id: 'admin',
    label: 'Admin',
    icon: 'fa-cog',
    route: {
      name: 'admin.dashboard.general'
    }
  }));
}
