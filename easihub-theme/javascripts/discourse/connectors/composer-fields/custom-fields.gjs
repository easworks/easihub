import Component from '@glimmer/component';
import { fn } from '@ember/helper';
import { on } from '@ember/modifier';
import { action } from '@ember/object';

export class CustomFields extends Component {

  get fields() {
    return this.args.model.customization?.fields;
  }

  get customFields() {
    return this.fields?.customFields || [];
  }

  @action
  updateCustomField(key, event) {
    if (!this.args.model.customFields) {
      this.args.model.customFields = {};
    }
    this.args.model.customFields[key] = event.target.value;
  }

  <template>
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