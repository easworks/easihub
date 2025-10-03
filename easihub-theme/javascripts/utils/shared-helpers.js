import fieldConfig from './field-config';

export const CONTENT_TYPES = [
  { value: 'question', label: 'Question', icon: '❓' },
  { value: 'discussion', label: 'Discussion', icon: '💬' },
  { value: 'use-case', label: 'Use Case', icon: '📋' },
  { value: 'article', label: 'Article', icon: '📝' },
  { value: 'event', label: 'Event', icon: '💼' },
  { value: 'job', label: 'Job', icon: '📅' }
];

export function getFieldConfig(selectedType) {
  if (!selectedType) {
    return [];
  }
  const configKey = selectedType === 'use-cases' ? 'use_cases' : selectedType;
  return fieldConfig[configKey] || [];
}