import fieldConfig from './field-config';

export const CONTENT_TYPES = [
  { value: 'questions', label: 'Questions', icon: '❓' },
  { value: 'discussion', label: 'Discussion', icon: '💬' },
  { value: 'use-cases', label: 'Use Cases', icon: '📋' },
  { value: 'articles', label: 'Articles', icon: '📝' },
  { value: 'events', label: 'Events', icon: '💼' },
  { value: 'jobs', label: 'Jobs', icon: '📅' }
];

export function getFieldConfig(selectedType) {
  if (!selectedType) return [];
  const configKey = selectedType === 'use-cases' ? 'use_cases' : selectedType;
  return fieldConfig[configKey] || [];
}