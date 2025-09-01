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
        { text: 'Technical Architecture', color: 'indigo' },
        { text: 'API & Integration', color: 'indigo' },
        { text: 'Data Migration', color: 'indigo' },
        { text: 'Platform Comparison', color: 'indigo' },
        { text: 'Solution Design', color: 'indigo' },
        { text: 'Cloud Integration', color: 'indigo' },
        { text: 'Security Framework', color: 'indigo' },
        { text: 'Performance Tuning', color: 'indigo' },
        { text: 'Requirements Analysis', color: 'indigo' },
        { text: 'Cross-Platform Development', color: 'indigo' },
        { text: 'Vendor Integration', color: 'indigo' },
        { text: 'Performance Optimization', color: 'indigo' },
        { text: 'Security Implementation', color: 'indigo' },
        { text: 'Database Design', color: 'indigo' }
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
        { text: 'Database Optimization', color: 'indigo' },
        { text: 'Cloud Migration', color: 'indigo' },
        { text: 'Microservices', color: 'indigo' },
        { text: 'DevOps Practices', color: 'indigo' },
        { text: 'Code Review', color: 'indigo' },
        { text: 'Documentation', color: 'indigo' }
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
        { text: 'Digital Transformation', color: 'indigo' },
        { text: 'Governance Framework', color: 'indigo' },
        { text: 'Change Management', color: 'indigo' },
        { text: 'Risk Management', color: 'indigo' },
        { text: 'Executive Leadership', color: 'indigo' },
        { text: 'ROI & Business Case', color: 'indigo' },
        { text: 'Strategic Planning', color: 'indigo' },
        { text: 'Compliance Management', color: 'indigo' },
        { text: 'Stakeholder Management', color: 'indigo' },
        { text: 'Budget Planning', color: 'indigo' },
        { text: 'Resource Management', color: 'indigo' },
        { text: 'Performance Metrics', color: 'indigo' }
      ]
    },
    topicTags: {
      label: 'Topic Tags',
      list: [
        { text: 'CIO Leadership', color: 'green' },
        { text: 'ERP Director', color: 'green' },
        { text: 'Change Manager', color: 'green' },
        { text: 'Executive Strategy', color: 'green' },
        { text: 'Governance Board', color: 'green' },
        { text: 'Digital Strategy', color: 'green' },
        { text: 'Strategic Planning', color: 'green' },
        { text: 'Policy Development', color: 'green' },
        { text: 'Executive Reporting', color: 'green' },
        { text: 'Organizational Change', color: 'green' },
        { text: 'Compliance Framework', color: 'green' }
      ]
    }
  }
};