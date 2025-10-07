import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { on } from '@ember/modifier';
import { action } from '@ember/object';
import { observes } from '@ember-decorators/object';
import { getAreaCategories, GENERIC_TOPIC_MAPPING } from '../../../consts';
import { service } from '@ember/service';

export class TopicTypeSelector extends Component {
  @service router;
  @service composer;


  get isGenericOrStrategyCategory() {
    const categorySlug = this.args.composer?.category?.slug || '';
    return categorySlug.includes('generic') || categorySlug.includes('strategy');
  }

  get isSubcategory() {
    return !!this.args.composer?.category?.parentCategory && !this.isGenericOrStrategyCategory;
  }

  get isTechnicalAreaChecked() {
    return this.args.composer.selectedTopicType === "technical-area";
  }

  get areaOptions() {
    return {
      'generic-topic': 'Generic Topics',
      'strategy': 'Strategy'
    };
  }

  @action
  updateTopicType(event) {
    let currentTags = this.args.composer.tags || [];
    if (!Array.isArray(currentTags)) currentTags = [currentTags];

    const topicTypeValues = ['technical-area', 'generic-topic', 'strategy'];
    currentTags = currentTags.filter(t => !topicTypeValues.includes(t));

    const value = this.isSubcategory ? (event.target.checked ? 'technical-area' : 'generic-topic') : event.target.value;
    this.args.composer.selectedTopicType = value;
    
    // Change categoryId based on GENERIC_TOPIC_MAPPING
    const parentCategoryId = this.args.composer?.category?.parentCategory?.id;
    if (parentCategoryId && GENERIC_TOPIC_MAPPING[parentCategoryId]) {
      const mapping = GENERIC_TOPIC_MAPPING[parentCategoryId];
      if (value === 'generic-topic') {
        this.args.composer.set('categoryId', mapping[0]);
      } else if (value === 'strategy') {
        this.args.composer.set('categoryId', mapping[1]);
      }
    }
    
    if (value) {
      const contentTypeValues = ['question', 'discussion', 'article', 'event', 'use-case', 'bulletin', 'job'];
      const contentTypeIndex = currentTags.findIndex(tag => contentTypeValues.includes(tag));
      
      if (contentTypeIndex !== -1) {
        currentTags.splice(contentTypeIndex + 1, 0, value);
      } else {
        currentTags.push(value);
      }
    }

    this.args.composer.set("tags", [...currentTags]);
    this.args.composer.set('selectedTopicType', value);
    this.args.composer.notifyPropertyChange('tags');
    this.args.composer.notifyPropertyChange('selectedTopicType');
    this.args.composer.notifyPropertyChange('categoryId');
  }

  constructor() {
    super(...arguments);
    if (this.isSubcategory) {
      this.args.composer.selectedTopicType = 'technical-area';
    } else if (this.isGenericOrStrategyCategory) {
      const categorySlug = this.args.composer?.category?.slug || '';
      if (categorySlug.includes('generic')) {
        this.args.composer.selectedTopicType = 'generic-topic';
      } else if (categorySlug.includes('strategy')) {
        this.args.composer.selectedTopicType = 'strategy';
      }
    }
  }

  <template>
    {{#if this.isSubcategory}}
    <div class="topic-type-selector field-group">
      <label class="checkbox-label">
        <input
          type="checkbox"
          checked={{this.isTechnicalAreaChecked}}
          {{on "change" this.updateTopicType}}
        />
        Technical Area
      </label>
    </div>
    {{else if this.isGenericOrStrategyCategory}}
    <div class="topic-type-selector field-group">
      <select
        class="form-control p-2"
        value={{this.args.composer.selectedTopicType}}
        {{on "change" this.updateTopicType}}
      >
        <option value="">Select Topic type...</option>
        {{#each-in this.areaOptions as |optionKey optionLabel|}}
        <option value={{optionKey}}>{{optionLabel}}</option>
        {{/each-in}}
      </select>
    </div>
    {{/if}}
  </template>
}

export default TopicTypeSelector;