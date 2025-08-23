import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { on } from '@ember/modifier';
import { action } from '@ember/object';
import { htmlSafe } from "@ember/template";
import { cook } from "discourse/lib/text";
import { i18n } from 'discourse-i18n';
import { createPromiseProxy } from '../../../utils/promise-proxy';
import { CONTENT_TYPES, getFieldConfig } from '../../../utils/shared-helpers';

export class MessageTemplate extends Component {

  @tracked expanded;
  @tracked selectedContentType = '';

  contentTypes = CONTENT_TYPES;

  @action
  toggleExpansion() {
    this.expanded = !this.expanded;
  }

  @action
  onContentTypeChange(event) {
    this.selectedContentType = event.target.value;
    this.args.model.set('selectedContentType', this.selectedContentType);

    const titleInput = document.getElementById('reply-title');
    if (this.titleField && titleInput) {
      titleInput.placeholder = this.titleField.placeholder;
    }
  }



  get help() {
    if (this.selectedContentType) {
      return this.getHelpForContentType(this.selectedContentType);
    }
    return null;
  }

  getHelpForContentType(contentType) {
    const i18nBase = `composer.help-message.by-tag.${contentType}`;
    const rawHeader = i18n(themePrefix(`${i18nBase}.header`));
    const rawContent = i18n(themePrefix(`${i18nBase}.content`));

    const processedContent = createPromiseProxy(
    cook(rawContent)
      .then(htmlSafe)
  );

    return {
      header: rawHeader,
      content: processedContent
    };
  }

  get titleField() {
    const selectedType = this.args.model.selectedContentType;
    if (!selectedType) {
      return null;
    }

    const fields = getFieldConfig(selectedType);

    return fields.find(field => field.key === 'title');
  }

  <template>

    {{#if this.help}}
    <div class="p-2 mb-4 bg-primary-50 rounded-lg border-l-4 border-l-primary-500">
      <h4 class="flex gap-4 items-center justify-between">
        <span class="font-bold">
          {{{this.help.header}}}
        </span>
        <span class="text-primary-400 mr-2 cursor-pointer text-sm"
          {{on 'click' this.toggleExpansion}}>
          {{#if this.expanded}}
            {{i18n (themePrefix 'composer.help-message.show-less')}}
          {{else}}
            {{i18n (themePrefix 'composer.help-message.show-more')}}
          {{/if}}
        </span>
      </h4>

      <div class="overflow-hidden transition-all duration-300 ease-in-out {{if this.expanded 'max-h-96 opacity-100' 'max-h-0 opacity-0'}}">
        <div class="pt-4 prose text-sm text-justify">
          {{{this.help.content.content}}}
        </div>
      </div>
    </div>
    {{/if}}

    <div class="content-type-selector mb-4">
      <label class="block text-sm font-medium text-gray-700 mb-2">
        Content Type
      </label>
      <select
        class="form-control p-2"
        {{on "change" this.onContentTypeChange}}
      >
        <option value="">Select content type...</option>
        {{#each this.contentTypes as |type|}}
        <option value={{type.value}}>{{type.label}}</option>
        {{/each}}
      </select>
    </div>

    {{#if this.titleField}}
    <div class="mb-4">
      <label class="block text-sm font-medium text-gray-700 mb-2">
        {{this.titleField.label}}
      </label>
    </div>
    {{/if}}
  </template>
}

export default MessageTemplate;