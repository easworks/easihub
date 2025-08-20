import Component from '@glimmer/component';
import { fn } from '@ember/helper';
import { on } from '@ember/modifier';
import { action } from '@ember/object';
import { TAG_CATEGORIES } from '../../config/tag-options';

export class CustomFields extends Component {

  get fields() {
    return this.args.model.customization?.fields;
  }

  get customFields() {
    return this.fields?.customFields || [];
  }

  get customTags() {
    return this.args.model.customization?.tags;
  }

  @action
  updateCustomField(key, event) {
    const value = event.target.value;

    if (!this.fieldValues) {
      this.fieldValues = {};
    }
    this.fieldValues[key] = value;

    const combinedValues = Object.values(this.fieldValues)
      .filter(val => val && val.trim())
      .join('\n');

    this.args.model.set('reply', combinedValues);
  }

  @action
  updateCustomTag(key, event) {
    let currentTags = this.args.model.tags || [];

    if (!Array.isArray(currentTags)) {
      currentTags = [currentTags];
    }

    const categoryTags = TAG_CATEGORIES[key] || [];
    currentTags = currentTags.filter(t => !categoryTags.includes(t));

    if (event.target.value) {
      currentTags.push(event.target.value);
    }

    this.args.model.set("tags", [...currentTags]);
  }


  <template>
    {{#if this.customTags}}
    <div class="custom-composer-tags flex gap-4 item-center justify-baseline">
      {{#if this.customTags.area}}
      <div class="field-group mb-4">
        <label class="block text-sm font-medium text-gray-700 mb-2">
          {{this.customTags.area.label}}
        </label>
        <select
          class="form-control p-2"
          {{on "change" (fn this.updateCustomTag "area")}}
        >
          <option value="">Select topic type...</option>
          {{#each-in this.customTags.area.options as |optionKey optionLabel|}}
          <option value={{optionKey}}>{{optionLabel}}</option>
          {{/each-in}}
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
      <div class="field-group mb-4">
        <label class="block text-sm font-medium text-gray-700 mb-2">
          {{field.label}}
        </label>
        <textarea
          class="form-control w-full"
          placeholder={{field.placeholder}}
          rows="4"
          {{on "input" (fn this.updateCustomField field.key)}}
        ></textarea>
      </div>
      {{/each}}
    </div>
    {{/if}}
  </template>
}

export default CustomFields;