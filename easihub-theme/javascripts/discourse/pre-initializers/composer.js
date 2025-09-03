import { cached } from '@glimmer/tracking';
import { computed } from '@ember/object';
import { withPluginApi } from 'discourse/lib/plugin-api';
import { TOPIC_CONTENT_TYPES } from '../../consts';

export default {
  initialize: () => withPluginApi(api => {
    api.modifyClass('model:composer', (Composer) => class extends Composer {
      @computed('tags.[]')
      get tagsByPurpose() {
        console.debug('tagsByPurpose computed', [...this.tags]);
        let contentType;
        let optional = [];

        for (const tag of this.tags) {
          if (TOPIC_CONTENT_TYPES.has(tag)) {
            contentType = tag;
            continue;
          }

          optional.push(tag);
        }

        return {
          contentType,
          optional
        };
      }


      get contentType() {
        return this.tagsByPurpose.contentType;
      }

      set contentType(value) {
        this.setProperties({
          tags: [value, ...this.optionalTags]
        });
      }


      get optionalTags() {
        return this.tagsByPurpose.optional;
      }

      set optionalTags(value) {
        this.tags = [this.contentType, value];
      }
    });
  })
};