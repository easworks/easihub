import { apiInitializer } from 'discourse/lib/api';

export default apiInitializer(api => {
  const router = api.container.lookup('service:router');

  api.onPageChange(() => {
    const route = router.currentRoute;

    const el = getSearchElement();
    if (!el) {
      return;
    }

    if (route.name === 'discovery.categories') {
      const user = api.getCurrentUser();
      if (user) {
        el.classList.add('hidden');
        return;
      }
    }

    el.classList.remove('hidden');
  });
});

function getSearchElement() {
  return document.querySelector('.search-dropdown.header-dropdown-toggle');
}