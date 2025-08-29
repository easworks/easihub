import { tracked } from '@glimmer/tracking';
import { apiInitializer } from 'discourse/lib/api';
import { i18n } from "discourse-i18n";
import { SPECIAL_TAGS } from '../../consts';
import { TAG_OPTIONS } from '../config/tag-options';
import relationCatIdAndTechId from '../config/technical-tags.js';

export default apiInitializer(api => {

  const router = api.container.lookup('service:router');
  const urld = api.container.lookup('service:url-differentiator');
  const composer = api.container.lookup('service:composer');

  api.modifyClass('model:composer', (Composer) => {
    return class extends Composer {
      @tracked customization;
      @tracked customFields = {};
      @tracked selectedContentType;
      @tracked customFieldValues = {};
    };
  });

  const LOCKED_TAGS = ["questions", "discussion", "use-cases", "articles", "bulletins", "events", "jobs", "feedback"];

  api.onAppEvent('composer:open', ({ model }) => {
    const route = router.currentRoute;

    let customization = null;
    switch (route.name) {
      case 'discovery.category': {
        if (urld.routeName === 'discovery.category.feedback') {
          customization = { type: 'by-category' };
        }
      } break;
      case 'tags.showCategory': {
        const tag = urld.model.tag;
        if (SPECIAL_TAGS.has(tag.id)) {
          customization = { type: 'by-tag', };
        }
      }
    }

    if (!customization) {
      model.set('customization', null);
      return;
    }

    customization.model = urld.model;

    hydrateComposerCustomization(customization, model);

    model.set('tags', []);

    model.set('customization', customization);


  });

  api.customizeComposerText({
    'actionTitle': (model) => {
      return model?.customization?.actionTitle;
    },
    'titlePlaceholder': (model) => {
      return model?.customization?.fields?.titlePlaceholder;
    },
  });

  api.registerValueTransformer('composer-save-button-label', () => {
    return composer.model?.customization?.saveButtonLabel;
  });

  api.modifyClass("component:tag-chooser", {
    pluginId: "lock-composer-tags",

    actions: {
      removeTag(tag) {
        const tagName = typeof tag === 'string' ? tag : tag?.id || tag?.name;
        if (LOCKED_TAGS.includes(tagName)) {
          return;
        }
        return this._super(...arguments);
      }
    }
  });



});

function hydrateComposerCustomization(customization, model) {
  switch (customization.type) {
    case 'by-category': {
      const category = customization.model.category;



      {
        const i18nId = `composer.action-title.by-category.${category.id}`;
        customization.actionTitle = i18n(themePrefix(i18nId));
      }

      {
        const i18nId = `composer.create_topic.by-category.${category.id}`;
        customization.saveButtonLabel = i18nId;
      }

      technicalTags(customization.model).then(tagGroups => {
        if (tagGroups) {
          if (tagGroups.technicalTags) {
            customization.technicalTags = tagGroups.technicalTags;
          }
          if (tagGroups.genericTags) {
            customization.genericTags = tagGroups.genericTags;
          }
          model.set('customization', { ...customization });
        }
      });

    } break;
    case 'by-tag': {
      const tag = customization.model.tag;



      {
        const i18nId = `composer.action-title.by-tag.${tag.id}`;
        customization.actionTitle = i18n(themePrefix(i18nId));
      }

      {
        const i18nId = `composer.create_topic.by-tag.${tag.id}`;
        customization.saveButtonLabel = themePrefix(i18nId);
      }

      customization.tags = getCustomTags();

      technicalTags(customization.model).then(tagGroups => {
        if (tagGroups) {
          if (tagGroups.technicalTags) {
            customization.technicalTags = tagGroups.technicalTags;
          }
          if (tagGroups.genericTags) {
            customization.genericTags = tagGroups.genericTags;
          }
          model.set('customization', { ...customization });
        }
      });
    } break;
  }
}

async function technicalTags(model) {
  const allIds = Object.entries(relationCatIdAndTechId).map(([catId, techIds]) => ({
    catId: parseInt(catId, 10),
    techIds
  }));

  const currentCatId = model.category?.id;
  const currentParentCatId = model.category?.parent_category_id;

  const matchingEntry = allIds.find(entry =>
    entry.catId === currentCatId || entry.catId === currentParentCatId
  );

  if (matchingEntry) {
    try {
      const techIds = Array.isArray(matchingEntry.techIds) ? matchingEntry.techIds : [matchingEntry.techIds];
      const promises = techIds.map(techId => fetch(`/tag_groups/${techId}.json`).then(res => res.json()));
      const results = await Promise.all(promises);

      if (results.length >= 2) {
        return {
          technicalTags: results[0],
          genericTags: results[1]
        };
      } else if (results.length === 1) {
        return {
          technicalTags: results[0]
        };
      }

      return null;
    } catch (err) {
      // eslint-disable-next-line no-console
      console.error('Error fetching technical tags:', err);
      return null;
    }
  }

  return null;
}

function getCustomTags() {
  return {
    area: {
      label: i18n(themePrefix('composer.custom-tags.area.label')),
      options: TAG_OPTIONS.area
    },
    module: {
      label: i18n(themePrefix('composer.custom-tags.module.label')),
      options: TAG_OPTIONS.module
    }
  };
}




