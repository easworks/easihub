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
        'Technical Architecture',
        'API & Integration',
        'Data Migration',
        'Platform Comparison',
        'Solution Design',
        'Cloud Integration',
        'Security Framework',
        'Performance Tuning',
        'Requirements Analysis',
        'Cross-Platform Development',
        'Vendor Integration',
        'Performance Optimization',
        'Security Implementation',
        'Database Design'
      ]
    },
    topicTags: {
      label: 'Topic Tags',
      list: [
        'Development Tools',
        'System Integration',
        'Best Practices',
        'API Development',
        'DevOps',
        'Database Optimization',
        'Cloud Migration',
        'Microservices',
        'DevOps Practices',
        'Code Review',
        'Documentation'
      ]
    }
  },
  2474: {
    avatarText: 'ERP',
    badges: ['Strategy'],
    whenToPost: 'Executive strategy, governance frameworks, organizational transformation, and business-level planning.',
    areas: {
      label: 'Strategic Areas',
      list: [
        'Digital Transformation',
        'Governance Framework',
        'Change Management',
        'Risk Management',
        'Executive Leadership',
        'ROI & Business Case',
        'Strategic Planning',
        'Compliance Management',
        'Stakeholder Management',
        'Budget Planning',
        'Resource Management',
        'Performance Metrics'
      ]
    },
    topicTags: {
      label: 'Topic Tags',
      list: [
        'CIO Leadership',
        'ERP Director',
        'Change Manager',
        'Executive Strategy',
        'Governance Board',
        'Digital Strategy',
        'Strategic Planning',
        'Policy Development',
        'Executive Reporting',
        'Organizational Change',
        'Compliance Framework'
      ]
    }
  }
};