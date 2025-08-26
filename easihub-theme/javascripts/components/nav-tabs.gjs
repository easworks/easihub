import Component from '@glimmer/component';
import { LinkTo } from '@ember/routing';
import { i18n } from "discourse-i18n";

export const DomainSoftwareNavTabsComponent  =
  <template>
    <div class="eas-tabs">
      <LinkTo @route="discovery.categories"
        class="tab">
        {{i18n (themePrefix 'common.domains')}}
      </LinkTo>
      <LinkTo @route="admin.dashboard.general"
        class="tab">
        {{i18n (themePrefix 'common.all-software')}}
      </LinkTo>
      <LinkTo @route="discovery.latest"
        class="tab">
        {{i18n (themePrefix 'common.latest')}}
      </LinkTo>
    </div>
  </template>;