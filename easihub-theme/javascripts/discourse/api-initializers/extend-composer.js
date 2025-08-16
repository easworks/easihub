import { apiInitializer } from "discourse/lib/api";
import { SPECIAL_TAGS } from '../../consts';
import { i18n } from "discourse-i18n";
import { cook } from "discourse/lib/text";
import { htmlSafe } from "@ember/template";
import { tracked } from '@glimmer/tracking';

export default apiInitializer(api => {

  const router = api.container.lookup('service:router');
  const urld = api.container.lookup('service:url-differentiator');

  api.modifyClass('model:composer', Composer => {
    return class extends Composer {
      @tracked help;
    }
  })

  api.onAppEvent('composer:open', async ({ model }) => {
    let help = null;

    const route = router.currentRoute;

    switch (route.name) {
      case 'discovery.category': {
        if (urld.routeName === 'discovery.category.feedback') {
          const category = urld.model.category;
          const i18nBase = `composer.help-message.by-category.${category.id}`;
          help = await getComposerHelpTranslation(i18nBase);
        }
      } break;
      case 'tags.showCategory': {
        const tag = urld.model.tag;
        if (SPECIAL_TAGS.has(tag.id)) {
          const i18nBase = `composer.help-message.by-tag.${tag.id}`;
          help = await getComposerHelpTranslation(i18nBase);
        }
      } break;
    }

    model.help = help;
  });

});

async function getComposerHelpTranslation(i18nBase) {
  const rawHeader = i18n(themePrefix(`${i18nBase}.header`));
  const rawContent = i18n(themePrefix(`${i18nBase}.content`));

  // Process markdown and update
  const processedContent = htmlSafe(await cook(rawContent));

  return {
    header: rawHeader,
    content: processedContent
  }

}
