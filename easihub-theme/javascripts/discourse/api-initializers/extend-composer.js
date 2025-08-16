import { apiInitializer } from "discourse/lib/api";
import { SPECIAL_TAGS } from '../../special-tags';
import { i18n } from "discourse-i18n";

export default apiInitializer(api => {

  const router = api.container.lookup('service:router');
  const urld = api.container.lookup('service:url-differentiator');

  api.onAppEvent('composer:open', ({ model }) => {
    console.debug('[extend-composer]', 'composer opened');

    let help = null;
    if (router.currentRoute.name === 'tags.showCategory') {
      const tag = urld.model.tag;
      if (SPECIAL_TAGS.has(tag.id)) {
        const i18nBase = `composer.help-message.by-tag.${tag.id}`;
        help = {
          header: i18n(themePrefix(`${i18nBase}.header`)),
          content: i18n(themePrefix(`${i18nBase}.content`))
        };
      }
    }

    model.set('help', help);
  });

});
