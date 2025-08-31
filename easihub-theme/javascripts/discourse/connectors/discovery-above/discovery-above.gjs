import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { LinkTo } from '@ember/routing';
import { computed, get } from "@ember/object";
import { service } from '@ember/service';
import { i18n } from 'discourse-i18n';
import { DiscoveryAboveDomainHub } from './domain';
import { fn } from '@ember/helper';

export default class DiscoveryAboveComponent extends Component {
  // @service site;

  <template>
    {{#if @category}}
      <div class="mt-4 bg-yellow-100 text-yellow-700 p-2 px-4 rounded-lg
          text-sm">
        <span class="font-bold text-yellow-700">Ask a Question:</span>
        Please select the most relevant software and its associated technical area
        below to submit your question. 

        {{#if @category.genericSubcategories.length}}
        If your inquiry does not pertain to any
        specific software within this domain, you may use the
        <a href="#generic-topics" class="text-primary-500 hover:underline">Generic Topics section</a>
        for appropriate consideration.
        {{/if}}
      </div>

      {{#if (fn @category.isOfType 'hub' 'domain')}}
        <DiscoveryAboveDomainHub @category={{@category}}/>
      {{/if}}

    {{/if}}

  </template>
}