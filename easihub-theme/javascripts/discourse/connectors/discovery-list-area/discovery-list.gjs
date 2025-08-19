import Component from '@glimmer/component';
import { service } from '@ember/service';
import { CategoryCardComponent } from '../../../components/category-card.gjs';
import { featuredHubs } from '../../../utils/featured-hubs';

export default class DiscoveryList extends Component {
  @service site;
  @service router;

  get featuredCategories()  {
    return featuredHubs.map(id => this.site.categoriesById.get(id))
      .filter(Boolean);
  }

  get showFeatured() {
    return this.router.currentRoute.name === 'discovery.categories';
  }

  <template>
    {{#if this.showFeatured}}
    <div class="@container">
      <div class="grid gap-8 transition-all
        grid-cols-1 @3xl:grid-cols-2 @5xl:grid-cols-3">
        {{#each this.featuredCategories as |category|}}
          <CategoryCardComponent @category={{category}}/>
        {{/each}}
      </div>
    </div>
    {{else}}
    {{log @model}}
    <div class="@container">
      <div class="grid gap-8 transition-all
        grid-cols-1 @xl:grid-cols-2 @4xl:grid-cols-3">
        {{#each @model.category.subcategories as |category|}}
          <CategoryCardComponent @category={{category}}/>
        {{/each}}
      </div>
    </div>
    {{yield}}
    {{/if}}
  </template>;
}
