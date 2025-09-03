import { cached } from '@glimmer/tracking';
import Component from '@glimmer/component';
import { DomainGenericCard } from '../../../components/category-cards/domain-generic';
import { get } from '@ember/helper';

export class DiscoveryAboveDomainHub extends Component  {
  
  get primarySubcategory() {
    return this.args.category.genericSubcategories?.[0];
  }

  <template>
    <div class="@container">
      <div class="mt-4 p-2 px-4 rounded-lg
          grid gap-4 gap-y-2 grid-cols-[auto_1fr_auto]
          bg-blue-50 text-blue-700
          text-sm">
        <i class="fas fa-circle-question text-lg flex-none 
          row-span-2 @lg:row-span-1 transition-all"></i>
        <span class="col-span-2 @lg:col-span-1 transition-all">
          Need help choosing?
          {{#if this.primarySubcategory}}
            Select
            <span class="italic font-semibold">{{this.primarySubcategory.name}}</span>
            for vendor-neutral architecture
            and integration questions, or pick your specific software for platform
            configurations and customizations.
          {{/if}}
        </span>
        <button class="btn btn-flat source-color-primary-500 text-white
          self-center
          col-span-2 @lg:col-span-1 transition-all">
          Posting Guide
        </button>
      </div>
    </div>

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
        <div class="grid gap-4 mt-4 grid-cols-1 @2xl:grid-cols-2">
          {{#each @category.genericSubcategories as |category|}}
          <DomainGenericCard @category={{category}}/>
          {{/each}}
        </div>
      </div>
    </div>
  </template>
}