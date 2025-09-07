import { apiInitializer } from "discourse/lib/api";

export default apiInitializer(api => {
  const router = api.container.lookup('service:router');

  api.onPageChange(() => {
    setTimeout(() => {
      const route = router.currentRouteName;

      const el = getSearchBannerElement();
      const mainOutletWrapper = getMainOutletWrapperElement();
      const mainOutlet = getMainOutletElement();

      if (route === 'discovery.categories') {
        if (el) {
          el.classList.add('hidden');
        }
        if (mainOutletWrapper) {
          mainOutletWrapper.classList.add('max-w-full', 'p-0');
        }
        if (mainOutlet) {
          mainOutlet.classList.add('p-0');
        }
      } else {
        if (el) {
          el.classList.remove('hidden');
        }
        if (mainOutletWrapper) {
          mainOutletWrapper.classList.remove('max-w-full', 'p-0');
        }
        if (mainOutlet) {
          mainOutlet.classList.remove('p-0');
        }
      }
    }, 0);
  });
});

function getSearchBannerElement() {
  return document.querySelector('.above-main-container-outlet.search-banner.welcome-banner');
}

function getMainOutletWrapperElement() {
  return document.querySelector('#main-outlet-wrapper');
}

function getMainOutletElement() {
  return document.querySelector('#main-outlet');
}
