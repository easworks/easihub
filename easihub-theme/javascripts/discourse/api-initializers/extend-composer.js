import { apiInitializer } from "discourse/lib/api";
import { SPECIAL_TAGS } from '../../special-tags';
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
    if (router.currentRoute.name === 'tags.showCategory') {
      const tag = urld.model.tag;
      if (SPECIAL_TAGS.has(tag.id)) {
        const i18nBase = `composer.help-message.by-tag.${tag.id}`;
        const rawHeader = i18n(themePrefix(`${i18nBase}.header`));
        const rawContent = i18n(themePrefix(`${i18nBase}.content`));

        // Process markdown and update
        const processedContent = htmlSafe(await cook(rawContent));

        help = {
          header: rawHeader,
          content: processedContent
        }
      }
    }

    model.help = help;
  });

});
