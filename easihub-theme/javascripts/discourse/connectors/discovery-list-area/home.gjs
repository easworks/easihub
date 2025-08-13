import Component from "@glimmer/component";
import { service } from '@ember/service';


export default class HomePage extends Component {
  @service urld;
  @service router;
  @service site;

  <template>
    DISCOVERY LIST AREA HOME
  </template>;
}
