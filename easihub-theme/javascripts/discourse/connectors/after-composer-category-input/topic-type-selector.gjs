import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { on } from '@ember/modifier';
import { action } from '@ember/object';
import { observes } from '@ember-decorators/object';
import { getAreaCategories } from '../../../consts';

export class TopicTypeSelector extends Component {
  @tracked selectedAreaTag = null;

  get currentSelectedTopicType() {
    const currentTags = this.args.composer.tags || [];
    const topicTypeValues = ['technical-area', 'generic-topic', 'strategy'];
    return currentTags.find(tag => topicTypeValues.includes(tag)) || '';
  }

  get areaOptions() {
    const hasParentCategory = !!this.args.composer?.category?.parentCategory;

    if (hasParentCategory) {
      return {
        'technical-area': 'Technical Area',
        'generic-topic': 'Generic Topic'
      };
    }

    return {
      'generic-topic': 'Generic Topic',
      'strategy': 'Strategy Tags'
    };
  }

  @action
  updateTopicType(event) {
    let currentTags = this.args.composer.tags || [];

    if (!Array.isArray(currentTags)) {
      currentTags = [currentTags];
    }

    const topicTypeValues = ['technical-area', 'generic-topic', 'strategy'];
    currentTags = currentTags.filter(t => !topicTypeValues.includes(t));

    if (event.target.value) {
      const contentTypeValues = ['questions', 'discussions', 'articles', 'events', 'use-cases', 'bulletins', 'jobs'];
      const contentTypeIndex = currentTags.findIndex(tag => contentTypeValues.includes(tag));
      
      if (contentTypeIndex !== -1) {
        currentTags.splice(contentTypeIndex + 1, 0, event.target.value);
      } else {
        currentTags.push(event.target.value);
      }
    }

    this.selectedAreaTag = event.target.value;
    this.args.composer.set("tags", [...currentTags]);
    
    const currentCustomization = this.args.composer.customization || {};
    this.args.composer.set('customization', {
      ...currentCustomization,
      selectedTopicType: event.target.value
    });
    
    this.args.composer.notifyPropertyChange('tags');
  }

  <template>
    <div class="topic-type-selector field-group">
      <select
        class="form-control p-2"
        value={{this.currentSelectedTopicType}}
        {{on "change" this.updateTopicType}}
      >
        <option value="">Select Topic type...</option>
        {{#each-in this.areaOptions as |optionKey optionLabel|}}
        <option value={{optionKey}}>{{optionLabel}}</option>
        {{/each-in}}
      </select>
    </div>
  </template>
}

export default TopicTypeSelector;