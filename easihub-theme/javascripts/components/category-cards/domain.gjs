import Component from '@glimmer/component';
import { LinkTo } from '@ember/routing';
import { array } from '@ember/helper';
import { i18n } from "discourse-i18n";
import CategoryPill from './pill';

export default class DomainCategoryCard extends Component  {

  get categoryType() {
    if (!this.args.category.parent) {
      return ;
    }
  }

  <template>
    <div class="flex flex-col p-4 border border-transparent
          rounded-lg shadow-sm shadow-slate-500/40
          hover:shadow-lg hover:shadow-d-primary/50
          hover:border hover:border-d-primary/50
          transition-all gap-4"
          style="--category-color: #{{@category.color}};">
        <div class="flex gap-4 items-center">
          <img src={{@category.uploaded_logo.url}} class="h-10"/>
          <h3 class="text-xl font-bold text-d-primary">
            <LinkTo @route="discovery.category" @models={{array @category.slugPathWithId}} class="d-link-color-d-primary">
              {{@category.name}}
            </LinkTo>
          </h3>
        </div>
        <div class="divider"></div>
        <p class="text-slate-600 text-sm line-clamp-6">
          {{{@category.description}}}
        </p>
        {{#if @category.subcategories.length}}
        <div class="divider"></div>
        <div class="flex gap-2 flex-wrap">
          {{#each @category.subcategories as |category|}}
          <CategoryPill @category={{category}}/>
          {{/each}}
        </div>
        {{/if}}
        <div class="divider mt-auto"></div>
        <LinkTo @route="discovery.category" @models={{array @category.slugPathWithId}}
          class="btn btn-raised w-full text-base py-2 source-color-d-primary">
          {{i18n (themePrefix 'discovery-list-area.explore')}}
        </LinkTo>
    </div>
  </template>
}

