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
  1588: {
    avatarText: 'SAP',
    types: ['hub', 'software'],
    areas: {
      label: 'Technical Areas',
      list: [
        'Integration Frameworks',
        'Server Customization',
        'Database Management',
        'Reporting & Analytics',
        'Security Framework',
        'Performance Optimization',
        'Cloud Platform Integration',
        'Fiori Development',
        'ABAP Programming',
        'Data Migration',
        'System Administration',
        'BTP Development',
      ]
    },
    topicTags: {
      label: 'Topic Tags',
      list: [
        'ABAP',
        'Fiori',
        'HANA',
        'SAPUI5',
        'CDS Views',
        'OData',
        'BTP',
        'Analytics Cloud',
        'SuccessFactors',
        'Ariba',
        'Concur',
        'MDG',
      ]
    }
  },
  1999: {
    avatarText: 'ERP',
    types: ['generic'],
    badges: ['General Topics'],
    whenToPost: 'Technical topics spanning multiple vendors (architecture, integrations, comparisons, development).',
  },
  2474: {
    avatarText: 'ERP',
    types: ['generic', 'strategy'],
    badges: ['Strategy'],
    whenToPost: 'Executive strategy, governance frameworks, organizational transformation, and business-level planning.',
  }
};