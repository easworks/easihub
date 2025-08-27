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