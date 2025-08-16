import { apiInitializer } from "discourse/lib/api";
import { SPECIAL_TAGS } from '../../special-tags';

export default apiInitializer(api => {

  const router = api.container.lookup('service:router');
  const urld = api.container.lookup('service:url-differentiator');

  api.onAppEvent('composer:open', ({ model }) => {
    console.debug('[extend-composer]', 'composer opened');

    let help = null;
    if (router.currentRoute.name === 'tags.showCategory') {
      const tag = urld.model.tag;
      if (SPECIAL_TAGS.has(tag.id)) {
        help = `by-tag.${tag.id}`
      }
    }

    model.set('help', help);
  });

});
