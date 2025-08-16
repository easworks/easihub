import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { on } from '@ember/modifier';
import { action } from '@ember/object';
import { service } from '@ember/service';
import { i18n } from 'discourse-i18n';

export class MessageTemplate extends Component {
  @service composer;

  @tracked expanded;

  @action
  toggleExpansion() {
    this.expanded = !this.expanded;
  }

  get help() {
    return this.composer.model.help;
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
          {{{this.help.content}}}
        </div>
      </div>
    </div>
    {{/if}}
  </template>
}

export default MessageTemplate;