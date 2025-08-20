export const TAG_OPTIONS = {
  area: {
    'technical-area': 'Technical Area',
    'generic-topic': 'Generic Topic'
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

export const TAG_CATEGORIES = {
  area: ['technical-area', 'generic-topic'],
  module: Object.keys(TAG_OPTIONS.module)
};