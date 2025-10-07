import { apiInitializer } from 'discourse/lib/api';

export default apiInitializer(api => {
  const urld = api.container.lookup('service:url-differentiator');

  api.onPageChange(() => {
    const route = urld.routeName;

    const el = getCategoryBoxesElement();
    if(!el) {
      return;
    }

    if (route === 'discovery.category.software' && el) {
      el.classList.add('hidden');
    }


  });
});

function getCategoryBoxesElement() {
  return document.querySelector('.container.list-container .row .category-boxes');
}