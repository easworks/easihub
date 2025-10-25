import Component from '@glimmer/component';
import { array } from '@ember/helper';
import { LinkTo } from '@ember/routing';

export default class CategoryPill extends Component {
  get categoryOrder() {
    const name = this.args.category.name.toLowerCase();
    if (name.includes('generic')) return 1;
    if (name.includes('strategy')) return 2;
    return 999;
  }

  get categoryStyle() {
    const name = this.args.category.name.toLowerCase();
    const order = this.categoryOrder;
    const marginBottom = name.includes('strategy') ? '12px' : '0';
    return `order: ${order}; margin-bottom: ${marginBottom};`;
  }

  get categoryClasses() {
    const name = this.args.category.name.toLowerCase();
    const isSpecial = name.includes('generic') || name.includes('strategy');
    
    return isSpecial 
      ? "px-4 p-1 rounded bg-primary-200 text-sm flex-grow text-center text-primary-500 hover:bg-primary-300 font-semibold hover:scale-102 hover:shadow shadow-slate-500/50 transition-all"
      : "px-4 p-1 rounded bg-primary-50 text-sm flex-grow text-center text-primary-500 hover:bg-primary-100 font-semibold hover:scale-102 hover:shadow shadow-slate-500/50 transition-all";
  }

  <template>
    <LinkTo @route="discovery.category" @models={{array @category.slugPathWithId}}
      class={{this.categoryClasses}}
      style={{this.categoryStyle}}>
      {{@category.name}}
    </LinkTo>
  </template>

}