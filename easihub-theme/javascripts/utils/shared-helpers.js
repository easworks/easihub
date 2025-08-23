import fieldConfig from './field-config';

export const CONTENT_TYPES = [
  { value: 'questions', label: 'Questions' },
  { value: 'discussion', label: 'Discussion' },
  { value: 'use-cases', label: 'Use Cases' },
  { value: 'articles', label: 'Articles' },
  { value: 'bulletins', label: 'Bulletins' },
  { value: 'events', label: 'Events' },
  { value: 'jobs', label: 'Jobs' }
];

export function getFieldConfig(selectedType) {
  if (!selectedType) return [];
  const configKey = selectedType === 'use-cases' ? 'use_cases' : selectedType;
  return fieldConfig[configKey] || [];
}