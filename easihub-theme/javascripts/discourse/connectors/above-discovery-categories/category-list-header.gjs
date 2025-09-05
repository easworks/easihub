import Component from '@glimmer/component';

export default class CategoryListHeader extends Component {
  <template>
    {{#if @categories.headerComponent}}
      <@categories.headerComponent @categories={{@categories}} />
    {{/if}}
  </template>
}