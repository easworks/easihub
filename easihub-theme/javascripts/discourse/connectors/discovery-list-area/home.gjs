import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { LinkTo } from '@ember/routing';
import { service } from '@ember/service';
import { i18n } from "discourse-i18n";
import { featuredHubs } from '../../../utils/featured-hubs';

export default class HomePage extends Component {
  @service site;

  @tracked cards = [];

  constructor() {
    super(...arguments);
    this.hydrateCards();
  }

  hydrateCards() {
    const categories = featuredHubs
      .map(id => this.site.categoriesById.get(id))
      .filter(Boolean);

    this.cards = categories.map(c => ({
      name: c.name,
      content: c.description,
      logo: c.uploaded_logo.url,
      link: [
        `${c.slug}/${c.id}`
      ],
      category: c
    }));
  }

  <template>
    <div class="@container">
      <div class="grid gap-8 transition-all
        grid-cols-1 @xl:grid-cols-2 @4xl:grid-cols-3">
        {{#each this.cards as |card|}}
          {{log card.category}}
          <div class="p-4 border border-outline-variant
            rounded-lg shadow-sm shadow-black/30
            hover:shadow-lg hover:shadow-d-primary/60
            hover:border hover:border-d-primary/75
            transition-all"
            style="--category-color: #{{card.category.color}};">
            <div class="flex gap-4 items-center">
              <img src={{card.logo}} class="h-10"/>
              <h3 class="text-xl font-bold text-d-primary">
                <LinkTo @route="discovery.category" @models={{card.link}} class="d-link-color-d-primary">
                  {{card.name}}
                </LinkTo>
              </h3>
            </div>
            <div class="divider my-4"></div>
            <p class="text-slate-600 text-sm line-clamp-4">
              {{{card.content}}}
            </p>
            <div class="divider my-4"></div>
            <LinkTo @route="discovery.category" @models={{card.link}}
              class="btn btn-raised w-full text-lg py-2 source-color-d-primary">
              {{i18n (themePrefix 'discovery-list-area.explore-and-post')}}
            </LinkTo>
          </div>
        {{/each}}
      </div>
    </div>
  </template>;
}
