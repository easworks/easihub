import Component from '@glimmer/component';
import { ChipsSection } from './chips-section';
import { computed } from "@ember/object";

export class DomainGenericCard extends Component {

  <template>
    <div class="relative rounded-lg border border-outline-variant overflow-hidden">
      <div class="absolute top-0 left-0 w-full h-1 bg-primary-500"></div>
      {{!-- header --}}
      <div class="p-2 px-4">
        <div class="flex gap-2 flex-wrap mt-3 text-xs font-semibold">
          {{#if @category.parentCategory}}
            <div class="rounded-lg p-1 px-2 bg-blue-50 border border-blue-200 text-blue-800">{{@category.parentCategory.name}}</div>
          {{/if}}
          {{#each @category.eas.badges as |badge|}}
            <div class="rounded-lg p-1 px-2 bg-green-50 border border-green-300 text-green-800">{{badge}}</div>
          {{/each}}
        </div>
        <div class="mt-4 flex gap-4 items-center">
          <div class="rounded-lg bg-primary-500 text-white
            text-sm font-semibold
            grid place-content-center aspect-square
            w-10">
            {{@category.eas.avatarText}}
          </div>
          <span class="font-bold text-lg">{{@category.name}}</span>
        </div>
        <p class="mt-4 text-sm">{{@category.description}}</p>
        {{#if @category.eas.whenToPost}}
        <p class="rounded-lg border border-indigo-700 bg-indigo-50 p-1 px-2 mt-4
          text-xs text-indigo-600">
          <span class="font-semibold text-indigo-600">When to post here:</span> {{{@category.eas.whenToPost}}}
        </p>
        {{/if}}
      </div>
      <div class="divider"></div>
      {{!-- content --}}

      {{#if @category.eas.areas.list.length}}
        <ChipsSection 
          @title={{@category.eas.areas.label}}
          @items={{@category.eas.areas.list}}/>
      {{/if}}

       {{#if @category.eas.topicTags.list.length}}
        <ChipsSection 
          @title={{@category.eas.topicTags.label}}
          @items={{@category.eas.topicTags.list}} />
      {{/if}}
      
    </div>

  </template>
}