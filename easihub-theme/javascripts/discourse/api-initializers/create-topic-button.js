import { service } from '@ember/service';
import { apiInitializer } from "discourse/lib/api";
import { SPECIAL_TAGS } from '../../consts';

export default apiInitializer(api => {

  api.modifyClass('component:discovery/navigation',
    DiscoveryNavigation => class extends DiscoveryNavigation {
      @service('url-differentiator') urld;

      get canCreateTopic() {
        const base = super.canCreateTopic;

        let allowedByRoute = false;

        switch (this.urld.routeName) {
          case 'tags.showCategory.software': {
            const tag = this.urld.model.tag;
            allowedByRoute = SPECIAL_TAGS.has(tag.id);
          } break;
          case 'discovery.category.software': {
            allowedByRoute = true;
          } break;
        }

        return allowedByRoute && base;
      }
    });

  api.modifyClass('component:d-navigation',
    DNavigation => class extends DNavigation {
      @service('url-differentiator') urld;

      get createTopicLabel() {
        const base = super.createTopicLabel;


        switch (this.urld.routeName) {
          case 'tags.showCategory.software': {
            const tag = this.urld.model.tag;
            const label = themePrefix(`topic.create.by-tag.${tag.id}`);
            return label;
          }
          case 'discovery.category.software': {
            const category = this.urld.model.category;
            const labelKey = category.id === 179 ? category.id : 'default';
            const label = themePrefix(`topic.create.by-category.${labelKey}`);

            return label;
          }
        }

        return base;
      }
    });

  api.modifyClass('component:create-topic-button',
    klass => class extends klass {
      get label() {
        return this.args.label || 'topic.create';
      }
    }
  );
});
