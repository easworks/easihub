import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import DomainCategoryCard from '../../../components/category-cards/domain';
import DefaultCategoryCard from '../../../components/category-cards/default';

export default class CategoryBoxesWrapper extends Component {
  @tracked uniform = true;

  get uniformComponent() {
    const category = this.args.categories.content[0];
    return this.getComponent(category);
  }

  getComponent(category) {
    if (category.isOfType('hub', 'domain')) {
      return DomainCategoryCard;
    }

    return DefaultCategoryCard;

  }

  <template>
    <div class="category-boxes-wrapper">
      {{#if this.uniform}}
        {{#each @categories as |category|}}
          <this.uniformComponent @category={{category}}/>
        {{/each}}
      {{else}}
      {{/if}}
    </div>
    
    
  </template>
} 