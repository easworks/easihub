import { cached } from '@glimmer/tracking';
import Component from '@glimmer/component';
import { DomainGenericCard } from '../../../components/category-cards/domain-generic'

export class DiscoveryAboveDomainHub extends Component  {
  <template>
    <div class="mt-8">
      <div class="flex justify-between items-center text-sm">
        <h3 class="flex items-center gap-4">
          <div class="icon-bg bg-green-100">
            <i class="fas fa-star text-yellow-500"></i>
          </div>
          <span class="font-bold">Generic {{@category.name}} Topics</span>
        </h3>
        <span class="font-semibold text-slate-500">{{@category.genericSubcategories.length}} communities</span>
      </div>
      
      <div class="@container">
        <div class="grid gap-4 mt-4 grid-cols-1 @xl:grid-cols-2">
          {{#each @category.genericSubcategories as |category|}}
          <DomainGenericCard @category={{category}}/>
          {{/each}}
        </div>
      </div>
    </div>
  </template>
}