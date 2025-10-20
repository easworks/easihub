import { cached, tracked } from '@glimmer/tracking';
import { withPluginApi } from 'discourse/lib/plugin-api';
import CategoryList from 'discourse/models/category-list';
import { SoftwareCategoryCard } from '../../components/category-cards/software';
import { SoftwareHubListHeader } from '../../components/category-list-header/software-hub';

export default {
  initialize: () => withPluginApi(api => {
    api.modifyClassStatic('model:category-list', {
      pluginId: 'easihub_theme',
      fromArray(categories) {
        const list = new this();
        list.categories = categories;
        list.init();
        list.set("fetchedLastPage", true);
        return list;
      }
    });

    api.modifyClass('model:category-list', klass => class extends klass {
      @tracked parentCategory;
      @tracked component;
      @tracked headerComponent;
    });

    api.modifyClass('model:category', klass => class extends klass {
      @cached
      get slugFor() {
        return klass.slugFor(this);
      }

      @cached
      get slugPathWithId() {
        return this.path.substring(3);
      }
    });

    api.modifyClass('component:discovery/categories-display', (CategoriesDisplay) => class extends CategoriesDisplay {
      get style() {
        const base = super.style;
        if (base === 'categories_only') {
          return 'categories_boxes';
        }
        return base;
      }
    });

    api.modifyClass('route:discovery.categories',
      klass => class extends klass {

        async findCategories(parentCategory) {
          const base = await super.findCategories(parentCategory);

          base.categories = base.categories.filter(c => c.isOfType('hub'));
          base.init();

          return base;
        }
      }
    );

    api.modifyClass('route:discovery.category', klass => class extends klass {
      async model() {
        const base = await super.model(...arguments);
        if (base.category) {
          if (base.category.isOfType('hub', 'domain')) {
            const softwareHubs = base.category.subcategories
              .filter(c => c.isOfType('hub', 'software'));

            base.subcategoryList.categories = CategoryList
              .fromArray(softwareHubs);

            base.subcategoryList.categories.parentCategory = base.category;
            base.subcategoryList.categories.component = SoftwareCategoryCard;
            base.subcategoryList.categories.headerComponent = SoftwareHubListHeader;

            base.subcategoryList.init();
          }
        }
        return base;
      }
    });

  })
};