import Component from '@glimmer/component';
import { LinkTo } from '@ember/routing';
import { i18n } from "discourse-i18n";

export class CategoryCardComponent extends Component  {

  get linkModels() {
    return [
      this.args.category.path.substring(3)
    ];
  }

  <template>
    <div class="p-4 border border-outline-variant
          rounded-lg shadow-sm shadow-black/30
          hover:shadow-lg hover:shadow-d-primary/60
          hover:border hover:border-d-primary/75
          transition-all"
          style="--category-color: #{{@category.color}};">
        <div class="flex gap-4 items-center">
          <img src={{@category.uploaded_logo.url}} class="h-10"/>
          <h3 class="text-xl font-bold text-d-primary">
            <LinkTo @route="discovery.category" @models={{this.linkModels}} class="d-link-color-d-primary">
              {{@category.name}}
            </LinkTo>
          </h3>
        </div>
        <div class="divider my-4"></div>
        <p class="text-slate-600 text-sm line-clamp-4">
          {{{@category.description}}}
        </p>
        <div class="divider my-4"></div>
        <LinkTo @route="discovery.category" @models={{this.linkModels}}
          class="btn btn-raised w-full text-lg py-2 source-color-d-primary">
          {{i18n (themePrefix 'discovery-list-area.explore-and-post')}}
        </LinkTo>
    </div>
  </template>
}