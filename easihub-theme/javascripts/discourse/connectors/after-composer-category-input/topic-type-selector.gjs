import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { on } from '@ember/modifier';
import { action } from '@ember/object';
import { getAreaCategories } from '../../config/tag-options';

export class TopicTypeSelector extends Component {
  @tracked selectedAreaTag = null;

  get areaOptions() {
    const hasParentCategory = this.args.model?.category?.hasOwnProperty('parent_category_id');

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
    let currentTags = this.args.model.tags || [];

    if (!Array.isArray(currentTags)) {
      currentTags = [currentTags];
    }

    const categoryTags = getAreaCategories(this.args.model);
    currentTags = currentTags.filter(t => !categoryTags.includes(t));

    if (event.target.value) {
      currentTags.push(event.target.value);
    }

    this.selectedAreaTag = event.target.value;
    this.args.model.set("tags", [...currentTags]);
  }

  <template>
    <div class="topic-type-selector field-group">
      <select
        class="form-control p-2"
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