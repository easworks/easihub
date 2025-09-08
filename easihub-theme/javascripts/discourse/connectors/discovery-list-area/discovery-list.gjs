import { service } from '@ember/service';
import Component from '@glimmer/component';
import { eq } from 'truth-helpers';
import CategoriesBoxes from 'discourse/components/categories-boxes';
import Category from 'discourse/models/category';
import CategoryList from 'discourse/models/category-list';
import { DomainCategoryCard } from '../../../components/category-cards/domain'

export default class DiscoveryList extends Component {
  @service site;
  @service router;

  get featuredCategories()  {
    const categories = Category.list()
      .filter(c => !c.parentCatgory && c.eas?.featured);
    const list = CategoryList
      .fromArray(categories);
      list.component = DomainCategoryCard;
    return list;
  }

  get mode() {
    const route = this.router.currentRoute;

    if (route.name === 'discovery.categories') {
      return 'domains';
    }

    if (
      route.name === 'discovery.category' && 
      this.args.category?.isOfType('hub', 'domain')
    ) {
      return 'software';
    }

    return 'default';
  }

  get showFeatured() {
    return this.router.currentRoute.name === 'discovery.categories';
  }

  <template>
    {{#if (eq this.mode 'domains')}}
      <CategoriesBoxes @categories={{this.featuredCategories}}/>
    {{else if (eq this.mode 'software')}}

    {{else}}
      {{yield}}
    {{/if}}
  </template>;
}
