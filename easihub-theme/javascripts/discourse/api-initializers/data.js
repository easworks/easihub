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
  14: {
    avatarText: 'CRM',
    types: ['hub', 'domain'],
    featured: true,
    genericSubcategories: [2000,2475],
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
  2000: {
    avatarText: 'CRM',
    types: ['generic'],
    badges: ['General Topics'],
    whenToPost: 'Technical topics spanning multiple vendors (architecture, integrations, comparisons, development).',
  },
  2475: {
    avatarText: 'CRM',
    types: ['generic', 'strategy'],
    badges: ['Strategy'],
    whenToPost: 'Executive strategy, governance frameworks, organizational transformation, and business-level planning.'
  },
  1589: {
    avatarText: 'SF',
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
  1598: {
    avatarText: 'AC',
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
  1599: {
    avatarText: 'OC',
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
  1600: {
    avatarText: 'HS',
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
  1601: {
    avatarText: '365',
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
  1602: {
    avatarText: 'CX',
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
  1603: {
    avatarText: 'ZS',
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
  1604: {
    avatarText: 'ZH',
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
  69: {
    avatarText: 'ERP',
    types: ['hub', 'domain'],
    featured: true,
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
  5: {
    avatarText: 'PLM',
    types: ['hub', 'domain'],
    featured: true,
    genericSubcategories: [1581, 2476],
    technicalAreas: [
      'Product Development',
      'CAD Integration',
      'Document Management',
      'Change Management',
      'BOM Management',
      'Configuration Management',
      'Workflow Automation',
      'Data Migration',
      'System Integration',
      'Compliance Management',
    ]
  },
  1581: {
    avatarText: 'PLM',
    types: ['generic'],
    badges: ['General Topics'],
    whenToPost: 'Technical topics spanning multiple vendors (architecture, integrations, comparisons, development).',
  },
  2476: {
    avatarText: 'PLM',
    types: ['generic', 'strategy'],
    badges: ['Strategy'],
    whenToPost: 'Executive strategy, governance frameworks, organizational transformation, and business-level planning.',
  },
  686: {
    avatarText: 'TC',
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
  1031: {
    avatarText: 'BA/BI',
    types: ['hub', 'domain'],
    featured: true,
    genericSubcategories: [1585, 2477],
    technicalAreas: [
      'Data Warehousing',
      'ETL Processes',
      'Reporting Tools',
      'Dashboard Development',
      'Data Analytics',
      'Business Intelligence',
      'Data Visualization',
      'Performance Management',
      'Predictive Analytics',
      'Data Mining',
    ]
  },
  1585: {
    avatarText: 'BA/BI',
    types: ['generic'],
    badges: ['General Topics'],
    whenToPost: 'Technical topics spanning multiple vendors (architecture, integrations, comparisons, development).',
  },
  2477: {
    avatarText: 'BA/BI',
    types: ['generic', 'strategy'],
    badges: ['Strategy'],
    whenToPost: 'Executive strategy, governance frameworks, organizational transformation, and business-level planning.',
  },
  1037: {
    avatarText: 'TU',
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
  1032: {
    avatarText: 'Cloud',
    types: ['hub', 'domain'],
    featured: true,
    genericSubcategories: [2005, 2478],
    technicalAreas: [
      'AWS Integration',
      'Azure Services',
      'Google Cloud Platform',
      'Container Management',
      'Serverless Computing',
      'Cloud Security',
      'DevOps Automation',
      'Microservices',
      'API Management',
      'Cloud Migration',
    ]
  },
  2005: {
    avatarText: 'Cloud',
    types: ['generic'],
    badges: ['General Topics'],
    whenToPost: 'Technical topics spanning multiple vendors (architecture, integrations, comparisons, development).',
  },
  2478: {
    avatarText: 'Cloud',
    types: ['generic', 'strategy'],
    badges: ['Strategy'],
    whenToPost: 'Executive strategy, governance frameworks, organizational transformation, and business-level planning.',
  },
  1045: {
    avatarText: 'AWS',
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
  1033: {
    avatarText: 'MES',
    types: ['hub', 'domain'],
    featured: true,
    genericSubcategories: [1582, 2479],
    technicalAreas: [
      'Production Scheduling',
      'Quality Management',
      'Equipment Management',
      'Labor Management',
      'Material Tracking',
      'Performance Analysis',
      'Maintenance Management',
      'Shop Floor Control',
      'Data Collection',
      'Compliance Reporting',
    ]
  },
  1582: {
    avatarText: 'MES',
    types: ['generic'],
    badges: ['General Topics'],
    whenToPost: 'Technical topics spanning multiple vendors (architecture, integrations, comparisons, development).',
  },
  2479: {
    avatarText: 'MES',
    types: ['generic', 'strategy'],
    badges: ['Strategy'],
    whenToPost: 'Executive strategy, governance frameworks, organizational transformation, and business-level planning.',
  },
  1051: {
    avatarText: 'SOE',
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
  1034: {
    avatarText: 'SCM',
    types: ['hub', 'domain'],
    genericSubcategories: [2154, 2480],
    technicalAreas: [
      'Demand Planning',
      'Inventory Management',
      'Procurement',
      'Supplier Management',
      'Logistics',
      'Warehouse Management',
      'Transportation',
      'Order Management',
      'Supply Chain Analytics',
      'Risk Management',
    ]
  },
  2154: {
    avatarText: 'SCM',
    types: ['generic'],
    badges: ['General Topics'],
    whenToPost: 'Technical topics spanning multiple vendors (architecture, integrations, comparisons, development).',
  },
  2480: {
    avatarText: 'SCM',
    types: ['generic', 'strategy'],
    badges: ['Strategy'],
    whenToPost: 'Executive strategy, governance frameworks, organizational transformation, and business-level planning.',
  },
  2007: {
    avatarText: 'IBP',
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
  2153: {
    avatarText: 'HCM',
    types: ['hub', 'domain'],
    genericSubcategories: [2155, 2481],
    technicalAreas: [
      'Payroll Systems',
      'Benefits Management',
      'Talent Management',
      'Performance Management',
      'Recruitment',
      'Employee Self-Service',
      'Time & Attendance',
      'Learning Management',
      'Succession Planning',
      'HR Analytics',
    ]
  },
  2155: {
    avatarText: 'HCM',
    types: ['generic'],
    badges: ['General Topics'],
    whenToPost: 'Technical topics spanning multiple vendors (architecture, integrations, comparisons, development).',
  },
  2481: {
    avatarText: 'HCM',
    types: ['generic', 'strategy'],
    badges: ['Strategy'],
    whenToPost: 'Executive strategy, governance frameworks, organizational transformation, and business-level planning.',
  },
  2163: {
    avatarText: 'WK',
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
  2156: {
    avatarText: 'QMS',
    types: ['hub', 'domain'],
    genericSubcategories: [2157, 2482],
    technicalAreas: [
      'Document Control',
      'Audit Management',
      'Corrective Actions',
      'Risk Assessment',
      'Compliance Management',
      'Training Management',
      'Non-Conformance Management',
      'Quality Planning',
      'Statistical Process Control',
      'Supplier Quality',
    ]
  },
  2157: {
    avatarText: 'QMS',
    types: ['generic'],
    badges: ['General Topics'],
    whenToPost: 'Technical topics spanning multiple vendors (architecture, integrations, comparisons, development).',
  },
  2482: {
    avatarText: 'QMS',
    types: ['generic', 'strategy'],
    badges: ['Strategy'],
    whenToPost: 'Executive strategy, governance frameworks, organizational transformation, and business-level planning.',
  },
  2290: {
    avatarText: 'MQE',
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
};