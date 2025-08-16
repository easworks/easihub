import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { concat } from '@ember/helper';
import { on } from '@ember/modifier';
import { action } from '@ember/object';
import { service } from '@ember/service';
import { i18n } from 'discourse-i18n';

export class MessageTemplate extends Component {
  @service composer;

  @tracked expanded;

  i18nsBase = 'composer.help-message';

  @action
  toggleExpansion() {
    this.expanded = !this.expanded;
  }

  get help() {
    return this.composer.model.help;
  }


  get i18ns() {
    if (this.help) {
      return `${this.i18nsBase}.${this.help}`;
    }
    return this.i18nsBase;
  }

  <template>
    {{#if this.help}}
    <div class="p-2 mb-4 bg-primary-50 rounded-lg border-l-4 border-l-primary-500">
      <h4 class="flex gap-4 items-center justify-between">
        <span class="font-bold">
          {{i18n (themePrefix (concat this.i18ns '.header'))}}
        </span>
        <span class="text-primary-400 mr-2 cursor-pointer"
          {{on 'click' this.toggleExpansion}}>
          {{#if this.expanded}}
          {{i18n (themePrefix (concat this.i18nsBase '.show-more'))}}
          {{else}}
          {{i18n (themePrefix (concat this.i18nsBase '.show-less'))}}
          {{/if}}
        </span>
      </h4>

      <div class="overflow-hidden transition-all duration-300 ease-in-out {{if this.expanded 'max-h-96 opacity-100' 'max-h-0 opacity-0'}}">
        <div class="pt-4">
          {{i18n (themePrefix (concat this.i18ns '.content'))}}
        </div>
      </div>
    </div>
    {{/if}}
  </template>
}

export default MessageTemplate;