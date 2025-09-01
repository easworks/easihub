import { apiInitializer } from "discourse/lib/api";
import Category from 'discourse/models/category';
import { fastStableStringify } from '../../utils/fast-stable-stringify';

export default apiInitializer(async api => {

  const site = api.container.lookup('service:site');
  const store = api.container.lookup('service:store');

  const ids = Object.keys(CUSTOM_DATA);

  const categories = await Category.asyncFindByIds([...ids]);

  await Promise.all(categories.map(async category => {
    const customData = CUSTOM_DATA[category.id];

    const isSynced =
      await fastStableStringify(category.custom_fields.eas)
      === await fastStableStringify(customData);

    if (isSynced) {
      return;
    }

    category = await Category.reloadCategoryWithPermissions(
      { slug: Category.slugFor(category) },
      store,
      site
    );

    category.custom_fields.eas = customData;

    await category.save();
  }));

});

/** @type { Record<number, any> } */
const CUSTOM_DATA = {
  69: {
    avatarText: 'ERP',
    types: ['hub', 'domain'],
    genericSubcategories: [1999, 2474],
  },
  1999: {
    avatarText: 'ERP',
    badges: ['General Topics'],
    whenToPost: 'Technical topics spanning multiple vendors (architecture, integrations, comparisons, development).',
    areas: {
      label: 'Generic Areas',
      list: [
        { text: 'Technical Architecture', color: 'blue' },
        { text: 'API & Integration', color: 'blue' },
        { text: 'Data Migration', color: 'blue' },
        { text: 'Platform Comparison', color: 'blue' },
        { text: 'Solution Design', color: 'blue' },
        { text: 'Cloud Integration', color: 'blue' },
        { text: 'Security Framework', color: 'blue' },
        { text: 'Performance Tuning', color: 'blue' },
        { text: 'Requirements Analysis', color: 'blue' },
        { text: 'Cross-Platform Development', color: 'blue' },
        { text: 'Vendor Integration', color: 'blue' },
        { text: 'Performance Optimization', color: 'blue' },
        { text: 'Security Implementation', color: 'blue' },
        { text: 'Database Design', color: 'blue' }
      ]
    },
    topicTags: {
      label: 'Topic Tags',
      list: [
        { text: 'Development Tools', color: 'green' },
        { text: 'System Integration', color: 'green' },
        { text: 'Best Practices', color: 'green' },
        { text: 'API Development', color: 'green' },
        { text: 'DevOps', color: 'green' },
        { text: 'Database Optimization', color: 'blue' },
        { text: 'Cloud Migration', color: 'blue' },
        { text: 'Microservices', color: 'blue' },
        { text: 'DevOps Practices', color: 'blue' },
        { text: 'Code Review', color: 'blue' },
        { text: 'Documentation', color: 'blue' }
      ]
    }
  },
  2474: {
    avatarText: 'ERP',
    badges: ['Strategy']
  }
};