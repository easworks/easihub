import Component from '@glimmer/component';
import { LinkTo } from '@ember/routing';

export const DomainSoftwareNavTabsComponent  =
  <template>
    <div class="eas-tabs">
      <LinkTo @route="discovery.categories"
        class="tab">
        Domains
      </LinkTo>
      <LinkTo @route="admin.dashboard.general"
        class="tab">
        All Software
      </LinkTo>
      <LinkTo @route="discovery.latest"
        class="tab">
        Latest
      </LinkTo>
    </div>
  </template>;