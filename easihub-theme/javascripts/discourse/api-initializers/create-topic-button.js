import { apiInitializer } from "discourse/lib/api";
import { service } from '@ember/service';

export default apiInitializer(api => {

  api.modifyClass('component:discovery/navigation',
    DiscoveryNavigation => class extends DiscoveryNavigation {
      @service router;
      @service('url-differentiator') urld;

      get canCreateTopic() {
        const base = super.canCreateTopic;

        let allowedByRoute = false;

        if (this.router.currentRoute.name === 'tags.showCategory') {
          const tag = this.urld.model.tag;
          allowedByRoute = tagLabels.has(tag.id);
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

        if (this.router.currentRoute.name === 'tags.showCategory') {
          const tag = this.urld.model.tag;
          const label = themePrefix(`topic.create-by-tag.${tag.id}`);
          return label;
        }

        return base;
      }
    });

});



const tagLabels = new Set(
  'questions',
  'discussion',
  'use-cases',
  'articles',
  'bulletins',
  'events',
  'jobs'
);