import { apiInitializer } from 'discourse/lib/api';
import { SPECIAL_TAGS } from '../../consts';
import { i18n } from "discourse-i18n";
import { cook } from "discourse/lib/text";
import { htmlSafe } from "@ember/template";
import { tracked } from '@glimmer/tracking';
import { createPromiseProxy } from '../../utils/promise-proxy';

export default apiInitializer(api => {

  const router = api.container.lookup('service:router');
  const urld = api.container.lookup('service:url-differentiator');
  const composer = api.container.lookup('service:composer');

  api.modifyClass('model:composer', Composer => {
    return class extends Composer {
      @tracked customization;
    }
  })

  api.onAppEvent('composer:open', ({ model }) => {
    const route = router.currentRoute;

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
    }
  });

  api.registerValueTransformer('composer-save-button-label', () => {
    return composer.model?.customization?.saveButtonLabel;
  })

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
    } break;
  }
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
