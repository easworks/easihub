import { apiInitializer } from 'discourse/lib/api';
import { SPECIAL_TAGS } from '../../consts';
import { i18n } from "discourse-i18n";
import { cook } from "discourse/lib/text";
import { htmlSafe } from "@ember/template";
import { tracked } from '@glimmer/tracking';
import { createPromiseProxy } from '../../utils/promise-proxy';
import { TAG_OPTIONS, TAG_CATEGORIES } from '../config/tag-options';

export default apiInitializer(api => {

  const router = api.container.lookup('service:router');
  const urld = api.container.lookup('service:url-differentiator');
  const composer = api.container.lookup('service:composer');

  api.modifyClass('model:composer', Composer => {
    return class extends Composer {
      @tracked customization;
      @tracked customFields = {};
    }
  })

  const LOCKED_TAGS = ["questions", "discussion", "use-cases", "articles", "bulletins", "events", "jobs", "feedback"];

  api.onAppEvent('composer:open', ({ model }) => {
    const route = router.currentRoute;

    console.debug(model, route);

    let customization = null;
    switch (route.name) {
      case 'discovery.category': {
        if (urld.routeName === 'discovery.category.feedback') {
          customization = { type: 'by-category' }
        }
      } break;
      case 'tags.showCategory': {
        const tag = urld.model.tag;
        if (SPECIAL_TAGS.has(tag.id)) {
          customization = { type: 'by-tag', }
        }
      }
    }

    if (!customization) {
      model.set('customization', null);
      return;
    }

    customization.model = urld.model;

    hydrateComposerCustomization(customization);

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
  })

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

function hydrateComposerCustomization(customization) {
  switch (customization.type) {
    case 'by-category': {
      const category = customization.model.category;

      {
        const i18nBase = `composer.help-message.by-category.${category.id}`;
        customization.help = getComposerHelpTranslation(i18nBase);
      }

      {
        const i18nId = `composer.action-title.by-category.${category.id}`;
        customization.actionTitle = i18n(themePrefix(i18nId));
      }

      {
        const i18nId = `composer.create_topic.by-category.${category.id}`;
        customization.saveButtonLabel = i18nId
      }

    } break;
    case 'by-tag': {
      const tag = customization.model.tag;

      {
        const i18nBase = `composer.help-message.by-tag.${tag.id}`;
        customization.help = getComposerHelpTranslation(i18nBase);
      }

      {
        const i18nId = `composer.action-title.by-tag.${tag.id}`;
        customization.actionTitle = i18n(themePrefix(i18nId));
      }

      {
        const i18nId = `composer.create_topic.by-tag.${tag.id}`;
        customization.saveButtonLabel = themePrefix(i18nId);
      }

      customization.fields = getFieldsForTag(tag.id);
      customization.tags = getCustomTags();
    } break;
  }
}

function getFieldsForTag(tagId) {
  switch (tagId) {
    case 'questions':
      return {
        titleLabel: i18n(themePrefix('composer.fields.questions.title_label')),
        titlePlaceholder: i18n(themePrefix('composer.fields.questions.title_placeholder')),
        customFields: [
          {
            key: 'problem_details',
            label: i18n(themePrefix('composer.fields.questions.problem_details_label')),
            placeholder: i18n(themePrefix('composer.fields.questions.problem_details_placeholder'))
          },
          {
            key: 'attempted_solutions',
            label: i18n(themePrefix('composer.fields.questions.attempted_solutions_label')),
            placeholder: i18n(themePrefix('composer.fields.questions.attempted_solutions_placeholder'))
          }
        ]
      };
    case 'discussion':
      return {
        titleLabel: i18n(themePrefix('composer.fields.discussion.title_label')),
        titlePlaceholder: i18n(themePrefix('composer.fields.discussion.title_placeholder')),
        customFields: [
          {
            key: 'discussion_context',
            label: i18n(themePrefix('composer.fields.discussion.context_label')),
            placeholder: i18n(themePrefix('composer.fields.discussion.context_placeholder'))
          }
        ]
      };
    case 'use-cases':
      return {
        titleLabel: i18n(themePrefix('composer.fields.use_cases.title_label')),
        titlePlaceholder: i18n(themePrefix('composer.fields.use_cases.title_placeholder')),
        customFields: [
          {
            key: 'problem',
            label: i18n(themePrefix('composer.fields.use_cases.problem_label')),
            placeholder: i18n(themePrefix('composer.fields.use_cases.problem_placeholder'))
          },
          {
            key: 'solution',
            label: i18n(themePrefix('composer.fields.use_cases.solution_label')),
            placeholder: i18n(themePrefix('composer.fields.use_cases.solution_placeholder'))
          },
          {
            key: 'outcome',
            label: i18n(themePrefix('composer.fields.use_cases.outcome_label')),
            placeholder: i18n(themePrefix('composer.fields.use_cases.outcome_placeholder'))
          }
        ]
      };
    default:
      return null;
  }
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

function getComposerHelpTranslation(i18nBase) {
  const rawHeader = i18n(themePrefix(`${i18nBase}.header`));
  const rawContent = i18n(themePrefix(`${i18nBase}.content`));

  // Process markdown and update
  const processedContent = createPromiseProxy(
    cook(rawContent)
      .then(htmlSafe)
  );

  return {
    header: rawHeader,
    content: processedContent
  }
}

