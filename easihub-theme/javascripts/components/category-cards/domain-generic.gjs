import Component from '@glimmer/component';
import { ChipsSection } from './chips-section';
import { computed } from "@ember/object";
import { LinkTo } from '@ember/routing';
import { array } from '@ember/helper';
import Category from 'discourse/models/category';

export class DomainGenericCard extends Component {

  get categorySlug() {
    return Category.slugFor(this.args.category);
  }

  <template>
    <div class="category-card domain-generic" style="--color-category: #{{@category.color}};">
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
          <div class="rounded-lg bg-category text-white
            text-sm font-semibold
            grid place-content-center aspect-square
            w-10">
            {{@category.eas.avatarText}}
          </div>
          <LinkTo @route="discovery.category" @models={{array this.categorySlug}}
            class="font-bold text-lg text-blue-950">
            {{@category.name}}
          </LinkTo>
          {{!-- <span class="font-bold text-lg">{{@category.name}}</span> --}}
        </div>
      </div>
      
      {{!-- content --}}
      <div class="px-4 grid gap-4">
        {{#if @category.description}}
          <p class="text-sm">{{@category.description}}</p>
        {{/if}}
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
          <LinkTo @route="tags.showCategory" @models={{array this.categorySlug 'questions'}}
            class="btn btn-raised col-span-3 source-color-primary-500 py-2">
            Ask Questions
          </LinkTo>
          <LinkTo @route="discovery.category" @models={{array this.categorySlug}}
            class="btn btn-stroked col-span-3 source-color-primary-500 py-2">
            Browse Topic
          </LinkTo>

          <LinkTo @route="tags.showCategory" @models={{array this.categorySlug 'discussions'}}
            class="btn btn-stroked col-span-2 source-color-slate-700">
            Discussions
          </LinkTo>
          <LinkTo @route="tags.showCategory" @models={{array this.categorySlug 'use-cases'}}
            class="btn btn-stroked col-span-2 source-color-slate-700">
            Use Cases
          </LinkTo>
          <LinkTo @route="tags.showCategory" @models={{array this.categorySlug 'jobs'}}
            class="btn btn-stroked col-span-2 source-color-slate-700">
            Jobs
          </LinkTo>

          <div class="divider col-span-6"></div>    
          
          <div class="flex justify-between col-span-6">
          <LinkTo @route="tags.showCategory" @models={{array this.categorySlug 'articles'}}
            class="btn btn-text source-color-slate-700 max-w-max">
            Articles
          </LinkTo>
          <LinkTo @route="tags.showCategory" @models={{array this.categorySlug 'articles'}}
            class="btn btn-text source-color-slate-700 max-w-max">
            Events
          </LinkTo>
          </div>
        </div>
      </div>

      
    </div>

  </template>
}