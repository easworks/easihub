import { cached, tracked } from '@glimmer/tracking';
import { withPluginApi } from 'discourse/lib/plugin-api';
import { SoftwareCategoryCard } from '../../components/category-cards/software';

export default {
  initialize: () => withPluginApi(api => {
    api.modifyClassStatic('model:category-list', {
      fromArray(categories) {
        const list = new this();
        list.categories = categories;
        list.init();
        list.set("fetchedLastPage", true);
        return list;
      }
    });

    api.modifyClass('model:category-list', klass => class extends klass {
      @tracked component;

      withComponent(component) {
        if (!component) {
          throw new Error(`argument 'component' not provided`);
        }
        this.component = component;
        return this;
      }
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

    api.modifyClass('route:discovery.category', klass => class extends klass {
      async model() {
        const base = await super.model(...arguments);
        if (base.category) {
          if (base.category.isOfType('hub', 'domain')) {
            if (base.subcategoryList) {
              base.subcategoryList.categories
                .withComponent(SoftwareCategoryCard);
            }
          }
        }
        return base;
      }
    });

  })
};