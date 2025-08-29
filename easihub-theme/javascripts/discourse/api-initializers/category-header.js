import { apiInitializer } from "discourse/lib/api";

export default apiInitializer(api => {
  const router = api.container.lookup('service:router');

  api.onPageChange(() => {
    const route = router.currentRoute;
    if (route.name === 'discovery.category') {
      setTimeout(() => {
        const el = getHeaderDescription();
        const category = route.attributes?.category;

        if (el && category) {
          if (!category.uploaded_logo?.url) {
            el.classList.add('no-logo');
          } else {
            el.classList.remove('no-logo');
          }
        }
      }, 100);
    }
  });
});

function getHeaderDescription() {
  return document.querySelector('.category-title-contents .category-title-description');
}