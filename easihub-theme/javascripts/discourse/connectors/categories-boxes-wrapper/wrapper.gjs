import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { DefaultCategoryCard } from '../../../components/category-cards/default';

export default class CategoryBoxesWrapper extends Component {
  get card() {
    return this.args.categories.component || DefaultCategoryCard;
  }

  <template>
    <div class="category-boxes-wrapper">
      {{#each @categories as |category|}}
        <this.card @category={{category}}/>
      {{/each}}
    </div>
    
    
  </template>
} 