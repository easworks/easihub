import RouteTemplate from 'ember-route-template';

import { eq, and, not } from 'truth-helpers';
import NonLoggedinHomepage from '../../../../components/homepage/non-loggedin-homepage';

export default RouteTemplate(
  <template>
    {{log @controller.currentUser}}
    {{#if (and (not @controller.currentUser) (eq @controller.router.currentRouteName "discovery.categories"))}}
      <NonLoggedinHomepage />
    {{/if}}
  </template>
)