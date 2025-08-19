import { apiInitializer } from "discourse/lib/api";
import { service } from '@ember/service';
import { SPECIAL_TAGS } from '../../consts';

export default apiInitializer(api => {
  const router = api.container.lookup('service:router');

  api.onPageChange(() => {
    const route = router.currentRoute;

    const el = getHeaderDescription();
    console.debug(route);

    if (!el)
      return;

    if (route.name === 'discovery.category') {
      console.debug(route);
      // const category = route.
    }
  });
});


function getHeaderDescription() {
  return document.querySelector('.category-title-contents.category-title-description');
}