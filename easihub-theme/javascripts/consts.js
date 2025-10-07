
export const SPECIAL_TAGS = new Set([
  'article',
  'bulletin',
  'discussion',
  'event',
  'job',
  'question',
  'use-case'
]);

export const TOPIC_CONTENT_TYPES = SPECIAL_TAGS;

export const SPECIAL_CATEGORIES = {
  feedback: 179
};

export const GENERIC_TOPIC_MAPPING = {
  69: [1999, 2474],
  14: [2000, 2475],
  5: [1581, 2476],
  1031: [1585, 2477],
  1032: [2005, 2478],
  1033: [1582, 2479],
  1034: [2154, 2480],
  2153: [2155, 2481],
  2156: [2157, 2482]
};

export const TAG_OPTIONS = {
  area: {
    'technical-area': 'Technical Area',
    'generic-topic': 'Generic Topic',
    'strategy': 'Strategy Tags'
  },
  module: {
    'module-erp': 'ERP Module',
    'module-plm': 'PLM Module',
    'module-crm': 'CRM Module',
    'module-scm': 'SCM Module',
    'module-hrm': 'HRM Module',
    'module-finance': 'Finance Module',
    'module-analytics': 'Analytics Module'
  },
  system: {
    'dev': 'Development (DEV)',
    'test': 'Test (TST)',
    'qa': 'Quality Assurance (QA)',
    'staging': 'Staging (STG)',
    'prod': 'Production (PRD)',
    'sandbox': 'Sandbox',
    'training': 'Training'
  }
};

export const TAG_CATEGORIES = {
  area: ['technical-area', 'generic-topic', 'strategy'],
  module: Object.keys(TAG_OPTIONS.module)
};

export const getAreaCategories = (model) => {
  const hasParentCategory = model && model.parent_category_id;
  return hasParentCategory ? ['technical-area', 'generic-topic'] : ['generic-topic', 'strategy'];
};

export const relationCatIdAndTechId = {
  //domian_cat_id:  technical, generic, strategy, module
  69: [736, 718, 719, 709],
  14: [737, 720, 721, 710],
  5: [738, 722, 723, 711],
  1031: [739, 728, 729, 714],
  1032: [740, 730, 731, 715],
  1033: [741, 726, 727, 713],
  1034: [742, 724, 725, 712],
  2153: [743, 734, 735, 717],
  2156: [744, 732, 733, 716]
};


export const GENERIC_TOPIC_CHIPS = {
  'generic-areas': {
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
    ],
    class: 'chip-indigo'
  },
  'generic-topic-tags': {
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
    ],
    class: 'chip-green'
  },
  'strategic-areas': {
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
    ],
    class: 'chip-indigo'
  },
  'strategic-topic-tags': {
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
    ],
    class: 'chip-green'
  }
};