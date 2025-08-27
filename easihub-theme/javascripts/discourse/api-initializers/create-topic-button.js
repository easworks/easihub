import { apiInitializer } from "discourse/lib/api";
import { service } from '@ember/service';
import { SPECIAL_TAGS } from '../../consts';

export default apiInitializer(api => {

  api.modifyClass('component:discovery/navigation',
    DiscoveryNavigation => class extends DiscoveryNavigation {
      @service router;
      @service('url-differentiator') urld;

      get canCreateTopic() {
        const base = super.canCreateTopic;

        let allowedByRoute = false;

        const route = this.router.currentRoute;

        switch (route.name) {
          case 'tags.showCategory': {
            const tag = this.urld.model.tag;
            allowedByRoute = SPECIAL_TAGS.has(tag.id);
          } break;
          case 'discovery.category': {
            allowedByRoute = true;
          } break;
        }

        return allowedByRoute && base;
      }
    });

  api.modifyClass('component:d-navigation',
    DNavigation => class extends DNavigation {
      @service router;
      @service('url-differentiator') urld;

      get createTopicLabel() {
        const base = super.createTopicLabel;

        const route = this.router.currentRoute;

        switch (route.name) {
          case 'tags.showCategory': {
            const tag = this.urld.model.tag;
            const label = themePrefix(`topic.create.by-tag.${tag.id}`);
            return label;
          }
          case 'discovery.category': {
            const category = this.urld.model.category;
            const labelKey = category.id === 179 ? category.id : 'default';
            const label = themePrefix(`topic.create.by-category.${labelKey}`);
            return label;
          }
        }

        return base;
      }
    });
});
