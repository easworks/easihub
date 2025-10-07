import Component from '@glimmer/component';
import { tracked, cached } from '@glimmer/tracking';
import { concat } from '@ember/helper';
import { on } from '@ember/modifier';
import { action } from '@ember/object';
import { LinkTo } from '@ember/routing';
import { service } from '@ember/service';
import Category from 'discourse/models/category';
import { constructMenu, createMenuItemFromCategory } from './menu-item';
import { defaultHomepage } from 'discourse/lib/utilities';


export default class CustomSidebarComponent extends Component {
  @service site;
  @service currentUser;
  @service('url-differentiator') urld;

  @tracked expandedPath = [];
  @tracked activeItem = null;

  hydrateHubChildren(hubItem) {
    const categories = Category.list()
      .filter(c => !c.parentCatgory && c.eas?.featured);

    return categories.map(category => {
      const item  = createMenuItemFromCategory(category, hubItem);

      if (category.subcategories.length) {
        item.children = category.subcategories
          .map(c => createMenuItemFromCategory(c, item));
      }

      return item;
    } );
  }

  @action
  itemClicked(item) {
    item.toggleExpansion();
  }

  get menuItems() {
    const menuItems = constructMenu(this.currentUser);

    // Find the "Hubs" item and add dynamic categories to it
    const hubs = menuItems.find(item => item.id === 'hubs');
    if (hubs) {
      hubs.children = this.hydrateHubChildren(hubs);
    }

    return menuItems;
  }

  get isAdminPanel() {
    return this.urld.routeName.startsWith('admin.');
  }

  get showCustomMenu() {
    return !this.isAdminPanel;
  }

  <template>
    {{#if this.showCustomMenu}}
      <div id="custom-sidebar">
        <TreeComponent @items={{this.menuItems}} />
      </div>
    {{/if}}
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

class LeafTemplate extends Component {
  @service router;

  @cached
  get isIndex() {
    return this.args.item.route.name === 'discovery.index';
  }

  @cached
  static get homepage() {
    return `discovery.${defaultHomepage() || 'custom'}`;
  }

  get currentWhen() {
    return this.isIndex ?
      LeafTemplate.homepage :
      undefined;
  }

  <template>
    <li class="menu-item"
        style="{{concat '--level:' @item.level ';'}}">
      {{#if @item.route}}
      <LinkTo @route={{@item.route.name}} @models={{@item.route.models}} @current-when={{this.currentWhen}}
        class="menu-link">
        <i class="menu-icon fa-icon fa-solid {{@item.icon}}"></i>
        <span class="menu-label">{{@item.label}}</span>
        {{#if @item.badge}}
          <span class="badge {{@item.badge.classes}}">{{@item.badge.count}}</span>
        {{/if}}
        {{#if @item.showDots}}
          <i class="menu-dots fa-solid fa-ellipsis"></i>
        {{/if}}
      </LinkTo>
      {{else}}
      <a class="menu-link" href={{@item.href}}>
        <i class="menu-icon fa-icon fa-solid {{@item.icon}}"></i>
        <span class="menu-label">{{@item.label}}</span>
        {{#if @item.badge}}
          <span class="badge {{@item.badge.classes}}">{{@item.badge.count}}</span>
        {{/if}}
        {{#if @item.showDots}}
          <i class="menu-dots fa-solid fa-ellipsis"></i>
        {{/if}}
      </a>
      {{/if}}
    </li>
  </template>
}

const BranchTemplate =
  <template>
    <li class="menu-item has-children {{if @item.expanded 'expanded'}}"
        style="{{concat '--level:' @item.level ';'}}">
      <button class="menu-link" {{on 'click' @item.toggleExpansion}}>
        <i class="menu-icon fa-icon fa-solid {{@item.icon}}"></i>
        <span class="menu-label">{{@item.label}}</span>
        {{#if @item.badge}}
          <span class="badge {{@item.badge.classes}}">{{@item.badge.count}}</span>
        {{/if}}
        <i class="fa-icon fa-solid fa-chevron-down expand-icon"></i>
      </button>
      <TreeComponent @items={{@item.children}} @child=true @expanded={{@item.expanded}}/>
    </li>
  </template>;
