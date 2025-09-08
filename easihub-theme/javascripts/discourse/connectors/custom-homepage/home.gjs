import Component from '@glimmer/component';
import { service } from '@ember/service';
import { AnonymousHomepage } from './variants/anonymous';
import { LoggedinHomepage } from './variants/loggedin';
import { eq, and, not } from 'truth-helpers';

export default class HomePage extends Component {
  @service currentUser;

  <template>
    {{#if this.currentUser}}
      <LoggedinHomepage />
    {{else}}
      <AnonymousHomepage />
    {{/if}}
  </template>
} 