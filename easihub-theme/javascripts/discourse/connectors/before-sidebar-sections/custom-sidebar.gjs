import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { concat } from '@ember/helper';
import { on } from '@ember/modifier';
import { action } from '@ember/object';
import { service } from '@ember/service';
import { initialMenuItems, MenuItem } from './menu-item';

export default class CustomSidebarComponent extends Component {
  @service site;

  @tracked expandedPath = [];
  @tracked activeItem = null;

  get categories() {
    return this.site.categories || [];
  }

  get formattedCategories() {
    return this.categories.map(category => ({
      id: `category-${category.id}`,
      label: category.name,
      href: `/c/${category.slug}/${category.id}`,
      icon: 'fa-folder',
      badge: category.topic_count > 0 ? {
        count: category.topic_count,
        class: 'category-badge'
      } : null
    }));
  }

  @action
  itemClicked(item) {
    item.toggleExpansion();
  }

  get menuItems() {
    const dynamicMenuItems = [...initialMenuItems];

    // Find the "Hubs" item and add dynamic categories to it
    const hubsItemIndex = dynamicMenuItems.findIndex(item => item.id === 'hubs');
    if (hubsItemIndex !== -1) {
      dynamicMenuItems[hubsItemIndex] = {
        ...dynamicMenuItems[hubsItemIndex],
        children: this.formattedCategories
      };
    }

    return MenuItem.fromArray(dynamicMenuItems);
  }

  <template>
    <div id="custom-sidebar">
      <TreeComponent @items={{this.menuItems}} />
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
