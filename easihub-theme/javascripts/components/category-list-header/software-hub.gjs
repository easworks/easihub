import Component from '@glimmer/component';

export class SoftwareHubListHeader extends Component {
  get category() {
    return this.args.categories.parentCategory;
  }

  <template>
    <div class="flex justify-between items-center text-sm">
      <h3 class="flex items-center gap-4">
        <div class="icon-bg bg-blue-500">
          <i class="fa-solid fa-gear text-white"></i>
        </div>
        <span class="font-bold">{{this.category.name}} Software Hubs</span>
      </h3>
      {{log @model}}
      <span class="font-semibold text-slate-500">Active Platforms - {{@categories.length}}</span>
    </div>
  </template>
} 