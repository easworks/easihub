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
  @service router;

  get currentRoute() {
    return this.router.currentRouteName === 'discovery.category' || this.router.currentRouteName === 'discovery.custom';
  }

  <template>
    {{#if this.currentRoute}}
      {{#if @category}}
        {{#if (@category.isOfType 'hub' 'domain')}}
          <DiscoveryAboveDomainHub @category={{@category}}/>
        {{/if}}

      {{/if}}
    {{/if}}
  </template>
}