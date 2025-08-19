import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { service } from '@ember/service';
import { CategoryCardComponent } from '../../../components/category-card.gjs';
import { featuredHubs } from '../../../utils/featured-hubs';

export default class HomePage extends Component {
  @service site;

  @tracked categories = [];

  constructor() {
    super(...arguments);
    this.hydrateCards();
  }

  hydrateCards() {
    this.categories = featuredHubs
      .map(id => this.site.categoriesById.get(id))
      .filter(Boolean);
  }

  <template>
    <div class="@container">
      <div class="grid gap-8 transition-all
        grid-cols-1 @xl:grid-cols-2 @4xl:grid-cols-3">
        {{#each this.categories as |category|}}
          <CategoryCardComponent @category={{category}}/>
        {{/each}}
      </div>
    </div>
  </template>;
}
