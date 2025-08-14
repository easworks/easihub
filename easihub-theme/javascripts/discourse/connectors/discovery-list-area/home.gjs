import Component from "@glimmer/component";
import { tracked } from '@glimmer/tracking';
import { service } from '@ember/service';
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
      logo: c.uploaded_logo.url
    }));
  }

  <template>
    <div class="@container">
      <div class="grid gap-8 transition-all
        grid-cols-1 @xl:grid-cols-2 @4xl:grid-cols-3">
        {{#each this.cards as |card|}}
          <div class="p-4 border border-outline-variant
            rounded-lg shadow-sm shadow-black/30
            hover:shadow-lg hover:shadow-primary-500/60
            hover:border hover:border-primary-500/75
            transition-all">
            <div class="flex gap-4 items-center">
              <img src={{card.logo}} class="h-10"/>
              <h3 class="text-xl font-bold
                  text-primary-500">
                  {{card.name}}
              </h3>
            </div>
            <div class="divider my-4"></div>
            <p class="text-slate-600 text-sm line-clamp-4">
              {{{card.content}}}
            </p>
            <div class="divider my-4"></div>
            <button class="raised-button w-full text-base py-2">Explore & Post</button>
          </div>
        {{/each}}
      </div>
    </div>
  </template>;
}
