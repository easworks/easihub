import { cached } from '@glimmer/tracking';
import { withPluginApi } from 'discourse/lib/plugin-api';

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

    api.modifyClass('model:category', klass => class extends klass {
      @cached
      get linkModels() {
        return [this.path.substring(3)];
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
  })
};