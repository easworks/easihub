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
    technicalAreas: [
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
      'BTP Development,',
      'Form Customization',
      'Orchestrator',
      'Business Functions',
      'System Administration',
      'UDC Setup',
      'Data Structure',
      'Reporting Tools',
      'Integration Tools',
      'Security Configuration',
      'Performance Tuning',
      'Upgrades & Patches',
      'Database Management',
      'Power Platform',
      'Azure Integration',
      'Customization',
      'Reporting & BI',
      'Workflow Automation',
      'Data Management',
      'Security & Roles',
      'API Development',
      'Plugin Development',
      'Entity Configuration',
      'Solution Management',
      'Integration Services',
    ]
  },
  1588: {
    avatarText: 'SAP',
    types: ['hub', 'software'],
    topicTags: [
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
  },
  1590: {
    avatarText: 'INF',
    types: ['hub', 'software'],
    topicTags: [
      'Coleman AI',
      'Birst Analytics',
      'ION Platform',
      'Supply Chain',
      'Manufacturing',
      'Healthcare',
      'Distribution',
      'Financial Management',
      'Asset Management',
      'Human Capital Management',
      'Fashion',
      'Automotive',
    ]
  },
  1591: {
    avatarText: 'JDE',
    types: ['hub', 'software'],
    topicTags: [
      'Event Rules',
      'Table I/O',
      'EnterpriseOne',
      'Business Views',
      'OMW',
      'UBE Development',
      'Data Browser',
      'Application Designer',
      'Server Manager',
      'Database Integration',
      'Web Development',
      'Mobile Applications',
    ]
  },
  1592: {
    avatarText: '365',
    types: ['hub', 'software'],
    topicTags: [
      'Power Apps',
      'Power BI',
      'Finance & Operations',
      'Sales',
      'Customer Service',
      'Field Service',
      'Common Data Service',
      'Power Automate',
      'Supply Chain',
      'Commerce',
      'Human Resources',
      'Project Operations',
    ]
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