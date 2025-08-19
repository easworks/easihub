import Component from '@glimmer/component';
import { service } from '@ember/service';
import { featuredHubs } from '../../../utils/featured-hubs';
import CategoryListComponent from '../categories-boxes-wrapper/category-list';

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
      <div class="category-boxes">
        <CategoryListComponent @categories={{this.featuredCategories}}/>
      </div>
    </div>
    {{else}}
      {{yield}}
    {{/if}}
  </template>;
}
