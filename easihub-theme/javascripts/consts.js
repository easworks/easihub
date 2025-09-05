
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
  69: [1999, 2474]  // erp
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
  69: [661, 670, 671],
  14: [662, 672, 673],
  5: [663],
  1031: [664],
  1032: [665],
  1033: [666],
  1034: [667],
  2153: [668],
  2156: [669]
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