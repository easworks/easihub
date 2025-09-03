import Component from '@glimmer/component';
import { concat } from '@ember/helper';

export class ChipsSection extends Component {
  <template>
    <div class="px-4">
      <div class="flex gap-4 justify-between items-center">
        <span class="font-semibold text-gray-600 text-sm">{{@title}}</span>
        {{!-- <button class="btn-text btn-icon source-color-primary-500">
          <i class="fa-solid fa-circle-plus"></i>
        </button> --}}
      </div>
      <div class="mt-2">
        <div class="flex flex-wrap gap-2">
          {{#each @items as |item|}}
            <div class="card-chip cursor-default {{@chipClass}}">
              {{item}}
            </div>
          {{/each}}
        </div>
      </div>
    </div>
  </template>
}