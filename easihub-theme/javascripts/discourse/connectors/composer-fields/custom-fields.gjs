import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { fn, get } from '@ember/helper';
import { on } from '@ember/modifier';
import { action } from '@ember/object';
import { service } from '@ember/service';
import { observes } from "@ember-decorators/object";
import PluginOutlet from 'discourse/components/plugin-outlet';
import lazyHash from "discourse/helpers/lazy-hash";
import discourseComputed from "discourse/lib/decorators";
import Composer from "discourse/models/composer";
import { getFieldConfig } from '../../../utils/shared-helpers';
import { getAreaCategories,TAG_CATEGORIES } from '../../../consts';
import ComposerEditor from 'discourse/components/composer-editor';

export class CustomFields extends Component {
  @service composer;

  constructor() {
    super(...arguments);
  }

  get fields() {
    return this.args.model.customization?.fields;
  }

  get customFields() {
    const selectedType = this.args.model.contentType;
    
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

  get strategyTags() {
    const customization = this.args.model.customization;
    return customization?.strategyTags?.tag_group?.tag_names || [];
  }

  get selectedTopicType() {
    return this.args.model.customization?.selectedTopicType;
  }

  get showRelatedTags() {
    return this.selectedTopicType === 'technical-area' || this.selectedTopicType === 'generic-topic' || this.selectedTopicType === 'strategy';
  }

  get relatedTagsToShow() {
    if (this.selectedTopicType === 'technical-area') {
      return this.technicalTags;
    } else if (this.selectedTopicType === 'generic-topic') {
      return this.genericTags;
    } else if (this.selectedTopicType === 'strategy') {
      return this.strategyTags;
    }
    return [];
  }

  get relatedTagsLabel() {
    if (this.selectedTopicType === 'technical-area') {
      return 'Select Technical Tag';
    } else if (this.selectedTopicType === 'generic-topic') {
      return 'Select Generic Tag';
    } else if (this.selectedTopicType === 'strategy') {
      return 'Select Strategy Tag';
    }
    return this.customTags?.related_tags?.label || 'Related Tags';
  }

  get currentSelectedRelatedTag() {
    const currentTags = this.args.model.tags || [];
    const relatedTags = [...this.technicalTags, ...this.genericTags, ...this.strategyTags];
    return currentTags.find(tag => relatedTags.includes(tag)) || '';
  }

  get currentSelectedModuleTag() {
    const currentTags = this.args.model.tags || [];
    const moduleOptions = this.customTags?.module?.options || {};
    const moduleKeys = Object.keys(moduleOptions);
    return currentTags.find(tag => moduleKeys.includes(tag)) || '';
  }

  @action
  updateCustomField(key, eventOrValue) {
    let value;
    
    // Handle both event objects and direct values
    if (typeof eventOrValue === 'string') {
      value = eventOrValue;
    } else if (eventOrValue && eventOrValue.target) {
      value = eventOrValue.target.value;
    } else {
      value = eventOrValue;
    }

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

    // Preserve topic type tags when filtering
    const topicTypeTags = ['technical-area', 'generic-topic', 'strategy'];
    const preservedTopicTypeTags = currentTags.filter(t => topicTypeTags.includes(t));

    let tagsToRemove = [];
    if (key === 'related_tags') {
      tagsToRemove = [...this.technicalTags, ...this.genericTags, ...this.strategyTags];
    } else if (key === 'area') {
      tagsToRemove = getAreaCategories(this.args.model);
    } else {
      tagsToRemove = TAG_CATEGORIES[key] || [];
    }

    currentTags = currentTags.filter(t => !tagsToRemove.includes(t));

    // Re-add preserved topic type tags
    preservedTopicTypeTags.forEach(tag => {
      if (!currentTags.includes(tag)) {
        currentTags.push(tag);
      }
    });

    if (event.target.value && !currentTags.includes(event.target.value)) {
      currentTags.push(event.target.value);
    }

    this.args.model.set("tags", [...currentTags]);
    this.args.model.notifyPropertyChange('tags');
  }


  <template>
    {{#if this.customTags}}
    <div class="custom-composer-tags flex gap-4 item-center justify-baseline">
      {{#if this.showRelatedTags}}
        <div class="field-group">
          <label class="block text-sm font-medium text-gray-700 mb-2">
            {{this.relatedTagsLabel}}
          </label>
          <select
            class="form-control p-2"
            value={{this.currentSelectedRelatedTag}}
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
        <div class="field-group">
          <label class="block text-sm font-medium text-gray-700 mb-2">
            {{this.customTags.module.label}}
          </label>
          <select
            class="form-control p-2"
            value={{this.currentSelectedModuleTag}}
            {{on "change" (fn this.updateCustomTag "module")}}
          >
            <option value="">Select module tags...</option>
            {{#each-in this.customTags.module.options as |optionKey optionLabel|}}
            <option value={{optionKey}}>{{optionLabel}}</option>
            {{/each-in}}
          </select>
        </div>
      {{/if}}
      {{#if this.customTags.system}}
          <div class="field-group">
          <label class="block text-sm font-medium text-gray-700 mb-2">
            {{this.customTags.system.label}}
          </label>
          <select
            class="form-control p-2"
            value={{this.currentSelectedSystemTag}}
            {{on "change" (fn this.updateCustomTag "system")}}
          >
            <option value="">Select system tags...</option>
            {{#each-in this.customTags.system.options as |optionKey optionLabel|}}
            <option value={{optionKey}}>{{optionLabel}}</option>
            {{/each-in}}
          </select>
        </div>
      {{/if}}
    </div>
    {{/if}}

    {{#if this.customFields}}
    <div class="custom-composer-fields mt-2">
      {{#each this.customFields as |field|}}
        {{#if field.isSection}}
        <div class="section-divider mt-6 mb-4">
          <h3 class="text-lg font-semibold text-gray-800">{{field.label}}</h3>
          <hr class="border-gray-300 mb-2">
        </div>
        {{else}}
        <div class="field-group">
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
          <ComposerEditor 
            @value={{get this.args.model.customFieldValues field.key}}
            @placeholder={{field.placeholder}}
            @onChange={{fn this.updateCustomField field.key}}
            @fieldKey={{field.key}}
          >
          </ComposerEditor>
          {{/if}}
        </div>
        {{/if}}
      {{/each}}
    </div>
    {{/if}}
  </template>
}

export default CustomFields;