import RouteTemplate from 'ember-route-template';

import { eq, and, not } from 'truth-helpers';
import NonLoggedinHomepage from '../../../../components/homepage/non-loggedin-homepage';
import LoggedinHomepage from '../../../../components/homepage/loggedin-homepage';

export default RouteTemplate(
  <template>
    {{#if (and (not @controller.currentUser) (eq @controller.router.currentRouteName "discovery.categories"))}}
      <NonLoggedinHomepage @controller={{@controller}}/>
    {{else if (and @controller.currentUser (eq @controller.router.currentRouteName "discovery.categories"))}}
      <LoggedinHomepage @model={{@model}} @controller={{@controller}} />
    {{/if}}

  </template>
)