import Component from '@glimmer/component';
import { concat } from '@ember/helper';

export class ChipsSection extends Component {
  <template>
    <div class="p-4">
      <div>
        <span class="font-semibold text-gray-600 text-sm">{{@title}}</span>
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