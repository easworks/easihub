import { apiInitializer } from "discourse/lib/api";
import Category from 'discourse/models/category';
import { fastStableStringify } from '../../utils/fast-stable-stringify';

export default apiInitializer(async api => {

  const site = api.container.lookup('service:site');
  const store = api.container.lookup('service:store');

  // console.debug(Category);

  const ids = Object.keys(CUSTOM_DATA);

  // for (const id of ids) {
  //   const record = store.findRecord('category', id);
  //   console.debug(record);
  // }

  const categories = await Category.asyncFindByIds([...ids]);

  await Promise.all(categories.map(async category => {
    category = await Category.reloadCategoryWithPermissions(
      { slug: category.slug },
      store,
      site
    );

    const customData = CUSTOM_DATA[category.id];

    const shouldChange =
      await fastStableStringify(category.custom_fields[EAS_CUSTOM_KEY])
      !== await fastStableStringify(customData);

    if (!shouldChange) {
      return;
    }

    category.custom_fields ||= {};

    category.custom_fields[EAS_CUSTOM_KEY] = customData;

    await category.save();
  }));

});

const EAS_CUSTOM_KEY = 'eas';

const CUSTOM_DATA = {
  69: {
    a: 1,
    b: 2
  }
};