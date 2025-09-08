import Component from '@glimmer/component';
import { array } from '@ember/helper';
import { LinkTo } from '@ember/routing';

export default class CategoryPill extends Component {
  <template>
    <LinkTo @route="discovery.category" @models={{array @category.slugPathWithId}}
      class="px-4 p-1 rounded bg-primary-50
        text-sm flex-grow text-center text-primary-500
        hover:bg-primary-100 font-semibold hover:scale-105
        hover:shadow shadow-slate-500/50
        transition-all">
      {{@category.name}}
    </LinkTo>
  </template>

}