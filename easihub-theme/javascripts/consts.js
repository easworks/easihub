
export const SPECIAL_TAGS = new Set([
  'articles',
  'bulletins',
  'discussion',
  'events',
  'jobs',
  'questions',
  'use-cases'
]);

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
  }
};

export const getAreaOptions = (model) => {
  const hasParentCategory = model && model.category.parent_category_id;

  if (hasParentCategory) {
    return {
      'technical-area': 'Technical Area',
      'generic-topic': 'Generic Topic'
    };
  }

  return {
    'generic-topic': 'Generic Topic',
    'strategy': 'Strategy Tags'
  };
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