
export const SPECIAL_TAGS = new Set([
  'articles',
  'bulletins',
  'discussions',
  'events',
  'jobs',
  'questions',
  'use-cases'
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
  69: [661, 670, 671, 697],
  14: [662, 672, 673, 698],
  5: [663, 674, 675, 699],
  1031: [664, 680, 681, 702],
  1032: [665, 682, 683, 703],
  1033: [666, 678, 679, 701],
  1034: [667, 676, 677, 700],
  2153: [668, 686, 687, 706],
  2156: [669, 684, 685, 705]
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