import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { fn } from '@ember/helper';
import {eq} from 'truth-helpers';
import { on } from '@ember/modifier';
import { action } from '@ember/object';
import { htmlSafe } from "@ember/template";
import { cook } from "discourse/lib/text";
import AsyncContent from "discourse/components/async-content";
import { i18n } from 'discourse-i18n';
import { CONTENT_TYPES, getFieldConfig } from '../../../utils/shared-helpers';
import { service } from '@ember/service';

export class MessageTemplate extends Component {
  @service router;
  @service composer;
  @tracked expanded;

  contentTypes = CONTENT_TYPES;

  // constructor() {
  //   super(...arguments);
  //   const currentTagOpened = this.tagID;
  //   if(currentTagOpened) {
  //     this.selectedContentType = currentTagOpened;
  //   }
  // }

  @action
  toggleExpansion() {
    this.expanded = !this.expanded;
  }

  @action
  onContentTypeChange(contentType) {
    this.args.model.contentType = contentType;
  }

  // get tagID() {
  //   return this.router.currentRoute.params.tag_id;
  // }

  get createTopic() {
    return this.composer.model?.action === 'createTopic';
  }

  get help() {
    if (this.args.model.contentType) {
      return this.getHelpForContentType(this.args.model.contentType);
    }
    return null;
  }

  getHelpForContentType(contentType) {
    const i18nBase = `composer.help-message.by-tag.${contentType}`;
    const rawHeader = i18n(themePrefix(`${i18nBase}.header`));
    const rawContent = i18n(themePrefix(`${i18nBase}.content`));

    const contentPromise = cook(rawContent).then(htmlSafe);

    return {
      header: rawHeader,
      contentPromise: contentPromise
    };
  }

  get titleField() {
    const selectedType = this.args.model.contentType;
    if (!selectedType) {
      return null;
    }

    const fields = getFieldConfig(selectedType);

    return fields.find(field => field.key === 'title');
  }



  <template>
    {{#if this.createTopic}}
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
            <AsyncContent @asyncData={{this.help.contentPromise}}>
              <:content as |content|>
                {{{content}}}
              </:content>
              <:loading>
                <div class="spinner small"></div>
              </:loading>
            </AsyncContent>
          </div>
        </div>
      </div>
      {{/if}}

      <div class="content-type-selector">
        <label class="block text-sm font-medium text-gray-700 mb-2">
          Step 1: What type of content are you creating?
        </label>
        <div class="content-type-wrap">

          {{#each this.contentTypes as |type|}}
            <button type="button"
              class="content-type-tab {{if (eq type.value @model.contentType) 'active'}}"
              {{on "click" (fn this.onContentTypeChange type.value)}}
            >
              <span class="tab-icon">{{type.icon}}</span>
              {{type.label}}
            </button>
          {{/each}}
        </div>
      </div>
    {{/if}}
  </template>
}

export default MessageTemplate;