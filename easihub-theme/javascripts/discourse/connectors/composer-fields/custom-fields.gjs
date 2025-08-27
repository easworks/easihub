import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { fn, get } from '@ember/helper';
import { on } from '@ember/modifier';
import { action } from '@ember/object';
import { getFieldConfig } from '../../../utils/shared-helpers';
import { getAreaCategories,TAG_CATEGORIES } from '../../config/tag-options';

export class CustomFields extends Component {
  @tracked selectedAreaTag = null;

  get fields() {
    return this.args.model.customization?.fields;
  }

  get customFields() {
    const selectedType = this.args.model.selectedContentType;

    if (!selectedType) {
      return [];
    }

    const fields = getFieldConfig(selectedType);

    return fields.map(field => ({
      key: field.key,
      label: field.label,
      placeholder: field.placeholder,
      type: field.type,
      options: field.options,
      isInput: field.type === 'input',
      isTextarea: field.type === 'textarea',
      isDate: field.type === 'date',
      isSelect: field.type === 'select',
      isFile: field.type === 'file',
      isSection: field.key && field.key.endsWith('_label') && !field.type
    }));
  }

  get customTags() {
    return this.args.model.customization?.tags;
  }

  get technicalTags() {
    const customization = this.args.model.customization;
    return customization?.technicalTags?.tag_group?.tag_names || [];
  }

  get genericTags() {
    const customization = this.args.model.customization;
    return customization?.genericTags?.tag_group?.tag_names || [];
  }

  get showRelatedTags() {
    return this.selectedAreaTag === 'technical-area' || this.selectedAreaTag === 'generic-topic';
  }

  get relatedTagsToShow() {
    if (this.selectedAreaTag === 'technical-area') {
      return this.technicalTags;
    } else if (this.selectedAreaTag === 'generic-topic') {
      return this.genericTags;
    }
    return [];
  }

  get relatedTagsLabel() {
    if (this.selectedAreaTag === 'technical-area') {
      return 'Step 3: Select Technical Tag';
    } else if (this.selectedAreaTag === 'generic-topic') {
      return 'Step 3: Select Generic Tag';
    }
    return this.customTags?.related_tags?.label || 'Related Tags';
  }

  @action
  updateCustomField(key, event) {
    const value = event.target.value;

    if (!this.args.model.customFieldValues) {
      this.args.model.set('customFieldValues', {});
    }

    this.args.model.customFieldValues[key] = value;

    if (key === 'title') {
      this.args.model.set('title', value);
    } else {
      const combinedValues = Object.values(this.args.model.customFieldValues)
        .filter((val, idx) => {
          const keys = Object.keys(this.args.model.customFieldValues);
          return keys[idx] !== 'title' && val && val.trim();
        })
        .join('\n');

      this.args.model.set('reply', combinedValues);
    }
  }



  @action
  updateCustomTag(key, event) {
    let currentTags = this.args.model.tags || [];

    if (!Array.isArray(currentTags)) {
      currentTags = [currentTags];
    }

    const categoryTags = key === 'area' ? getAreaCategories(this.args.model) : (TAG_CATEGORIES[key] || []);
    currentTags = currentTags.filter(t => !categoryTags.includes(t));

    if (event.target.value) {
      currentTags.push(event.target.value);
    }

    if (key === 'area') {
      this.selectedAreaTag = event.target.value;
    }

    this.args.model.set("tags", [...currentTags]);
  }


  <template>
    {{#if this.customTags}}
    <div class="custom-composer-tags flex gap-4 item-center justify-baseline">


      {{#if this.showRelatedTags}}
        <div class="field-group mb-4">
          <label class="block text-sm font-medium text-gray-700 mb-2">
            {{this.relatedTagsLabel}}
          </label>
          <select
            class="form-control p-2"
            {{on "change" (fn this.updateCustomTag "related_tags")}}
          >
            <option value="">Select related tags...</option>
            {{#each this.relatedTagsToShow as |tagName|}}
            <option value={{tagName}}>{{tagName}}</option>
            {{/each}}
          </select>
        </div>
      {{/if}}

      {{#if this.customTags.module}}
      <div class="field-group mb-4">
        <label class="block text-sm font-medium text-gray-700 mb-2">
          {{this.customTags.module.label}}
        </label>
        <select
          class="form-control p-2"
          {{on "change" (fn this.updateCustomTag "module")}}
        >
          <option value="">Select module tags...</option>
          {{#each-in this.customTags.module.options as |optionKey optionLabel|}}
          <option value={{optionKey}}>{{optionLabel}}</option>
          {{/each-in}}
        </select>
      </div>
      {{/if}}
    </div>
    {{/if}}

    {{#if this.customFields}}
    <div class="custom-composer-fields">
      {{#each this.customFields as |field|}}
        {{#if field.isSection}}
        <div class="section-divider mt-6 mb-4">
          <h3 class="text-lg font-semibold text-gray-800">{{field.label}}</h3>
          <hr class="border-gray-300 mb-2">
        </div>
        {{else}}
        <div class="field-group mb-4">
          <label class="block text-sm font-medium text-gray-700 mb-2">
            {{field.label}}
          </label>
          {{#if field.isInput}}
          <input
            type="text"
            class="form-control w-full"
            placeholder={{field.placeholder}}
            value={{get this.args.model.customFieldValues field.key}}
            {{on "input" (fn this.updateCustomField field.key)}}
          />
          {{else if field.isDate}}
          <input
            type="date"
            class="form-control w-full"
            value={{get this.args.model.customFieldValues field.key}}
            {{on "input" (fn this.updateCustomField field.key)}}
          />
          {{else if field.isSelect}}
          <select
            class="form-control w-full"
            {{on "change" (fn this.updateCustomField field.key)}}
          >
            <option value="">Select...</option>
            {{#each-in field.options as |optionKey optionLabel|}}
            <option value={{optionKey}}>{{optionLabel}}</option>
            {{/each-in}}
          </select>
          {{else if field.isFile}}
          <input
            type="file"
            class="form-control w-full"
            {{on "change" (fn this.updateCustomField field.key)}}
          />
          {{else}}
          <textarea
            class="form-control w-full"
            placeholder={{field.placeholder}}
            rows="4"
            value={{get this.args.model.customFieldValues field.key}}
            {{on "input" (fn this.updateCustomField field.key)}}
          ></textarea>
          {{/if}}
        </div>
        {{/if}}
      {{/each}}
    </div>
    {{/if}}
  </template>
}

export default CustomFields;