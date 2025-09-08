import { tracked } from '@glimmer/tracking';
import { apiInitializer } from 'discourse/lib/api';
import { i18n } from "discourse-i18n";
import { GENERIC_TOPIC_MAPPING, relationCatIdAndTechId, SPECIAL_TAGS, TAG_OPTIONS } from '../../consts';

export default apiInitializer(api => {

  const router = api.container.lookup('service:router');
  const urld = api.container.lookup('service:url-differentiator');
  const composer = api.container.lookup('service:composer');

  api.modifyClass('model:composer', (Composer) => {
    return class extends Composer {
      @tracked customization;
      @tracked customFields = {};
      @tracked customFieldValues = {};
    };
  });

  const LOCKED_TAGS = ["questions", "discussions", "use-cases", "articles", "bulletins", "events", "jobs", "feedback"];

  api.onAppEvent('composer:open', ({ model }) => {
    const route = router.currentRoute;

    let customization = null;
    switch (route.name) {
      case 'discovery.category': {
        if (urld.routeName === 'discovery.category.feedback') {
          customization = { type: 'by-category' };
        }
        else if (urld.routeName === 'discovery.category.software') {
          customization = { type: 'by-software' };
        }
        else if (urld.routeName === 'discovery.category.domain') {
          customization = { type: 'by-domain' };
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

    // model.set('tags', []);

    model.set('customization', customization);
  });

  api.customizeComposerText({
    'actionTitle': (model) => {
      if(model.contentType) {
        const i18nId = `composer.action-title.by-tag.${model.contentType}`;
        return i18n(themePrefix(i18nId));
      }
    }
  });

  api.registerValueTransformer('composer-save-button-label', () => {
    const model = composer.model;
    if (model?.contentType) {
      const i18nId = `composer.create_topic.by-tag.${model.contentType}`;
      const fallbackId = 'composer.create_topic.by-tag.default';
      return themePrefix(i18nId) || themePrefix(fallbackId);
    }
    return model?.customization?.saveButtonLabel;
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
        const fallbackId = 'composer.create_topic.by-category.default';
        customization.saveButtonLabel = i18nId || fallbackId;
      }

      technicalTags(customization.model).then(tagGroups => {
        if (tagGroups) {
          if (tagGroups.technicalTags) {
            customization.technicalTags = tagGroups.technicalTags;
          }
          if (tagGroups.genericTags) {
            customization.genericTags = tagGroups.genericTags;
          }
          if (tagGroups.strategyTags) {
            customization.strategyTags = tagGroups.strategyTags;
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
        const fallbackId = 'composer.create_topic.by-tag.default';
        customization.saveButtonLabel = themePrefix(i18nId) || themePrefix(fallbackId);
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
          if (tagGroups.strategyTags) {
            customization.strategyTags = tagGroups.strategyTags;
          }
          model.set('customization', { ...customization });
        }
      });
    } break;
    case 'by-software': {
      {
        const i18nId = `composer.action-title.by-software.default`;
        customization.actionTitle = i18n(themePrefix(i18nId));
      }
      {
        const i18nId = `composer.create_topic.by-software.default`;
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
          if (tagGroups.strategyTags) {
            customization.strategyTags = tagGroups.strategyTags;
          }
          model.set('customization', { ...customization });
        }
      });
    } break;
    case 'by-domain': {
      {
        const i18nId = `composer.action-title.by-domain.default`;
        customization.actionTitle = i18n(themePrefix(i18nId));
      }
      {
        const i18nId = `composer.create_topic.by-domain.default`;
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
          if (tagGroups.strategyTags) {
            customization.strategyTags = tagGroups.strategyTags;
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

      if (results.length >= 3) {
        return {
          technicalTags: results[0],
          genericTags: results[1],
          strategyTags: results[2]
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
    },
    system:{
      label: i18n(themePrefix('composer.custom-tags.system.label')),
      options: TAG_OPTIONS.system
    }
  };
}




