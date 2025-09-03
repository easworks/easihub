import Component from '@glimmer/component';
import { ChipsSection } from './chips-section';
import { computed } from "@ember/object";

export class DomainGenericCard extends Component {

  <template>
    <div class="category-card domain-generic">
      {{!-- header --}}
      <div class="px-4 pt-1">
        <div class="flex gap-2 flex-wrap mt-3 text-xs font-semibold uppercase">
          {{#if @category.parentCategory}}
            <div class="rounded-lg p-1 px-2 bg-indigo-50 border border-indigo-200 text-indigo-800">{{@category.parentCategory.name}}</div>
          {{/if}}
          {{#each @category.eas.badges as |badge|}}
            <div class="rounded-lg p-1 px-2 bg-green-50 border border-green-500 text-green-800">{{badge}}</div>
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
      </div>
      
      {{!-- content --}}
      <div class="px-4">
        <p class="text-sm">{{@category.description}}</p>
        {{#if @category.eas.whenToPost}}
          <p class="rounded-lg border border-blue-200 bg-blue-50/65 p-1 px-2
            text-xs text-blue-800">
            <span class="font-semibold">When to post here:</span> {{{@category.eas.whenToPost}}}
          </p>
        {{/if}}
      </div>

      <div class="divider mt-auto"></div>

      {{#if @category.eas.areas.list.length}}
        <ChipsSection 
          @title={{@category.eas.areas.label}}
          @items={{@category.eas.areas.list}}
          @chipClass="chip-indigo"/>
      {{/if}}

       {{#if @category.eas.topicTags.list.length}}
        <ChipsSection 
          @title={{@category.eas.topicTags.label}}
          @items={{@category.eas.topicTags.list}} 
          @chipClass="chip-green"/>
      {{/if}}

      <div class="divider"></div>

      <div class="cta-container @container">
        <div class="grid-cols-6">
          <button class="btn btn-raised col-span-3 source-color-primary-500 py-2">Ask Questions</button>
          <button class="btn btn-stroked col-span-3 source-color-primary-500 py-2">Browse Topic</button>

          <button class="btn btn-stroked col-span-2 source-color-slate-700">Discussion</button>
          <button class="btn btn-stroked col-span-2 source-color-slate-700">Use Cases</button>
          <button class="btn btn-stroked col-span-2 source-color-slate-700">Jobs</button>

          <div class="divider col-span-6"></div>    
          
          <div class="flex justify-between col-span-6">
            <button class="btn btn-text source-color-slate-700 max-w-max">Articles</button>
            <button class="btn btn-text source-color-slate-700 max-w-max">Events</button>
          </div>
        </div>
      </div>

      
    </div>

  </template>
}