import { cached } from '@glimmer/tracking';
import { action, computed } from "@ember/object";
import { withPluginApi } from 'discourse/lib/plugin-api';
import Site from "discourse/models/site";

export default {
  name: 'eas-custom-field',
  initialize: () => {

    withPluginApi(api => {
      // eslint-disable-next-line no-shadow
      api.modifyClass('model:site', Site => class extends Site {
        // TODO: Remove when
        // `discourse/discourse`
        // fixes categoriesById in
        // `app/assets/javascripts/discourse/app/models/site.js`
        @cached
        get categoriesById() {
          return super.categoriesById;
        }
      });

      api.modifyClass('model:category', Category => class extends Category {
        @computed('custom_fields.eas')
        get eas() {
          return this.custom_fields.eas;
        }

        @cached
        get featured() {
          return this.eas?.featured || false;
        }

        @cached
        get genericSubcategories() {
          const ids = this.eas?.genericSubcategories;
          if (!ids) {
            return [];
          }
          const byId = Site.current().categoriesById;
          return ids.map(id => byId.get(id));
        }

        @action
        isOfType(...type) {
          const types = this.eas?.types || [];
          return type.every(t => types.includes(t));
        }
      });
    });

  }
};