import Component from '@glimmer/component';
import { service } from '@ember/service';
import ContentCard from '../../../components/articles-card';
import JobCard from '../../../components/job-card';

// Add error handling for dynamic imports
export class CustomTagDataRender extends Component {
  @service router;

  get isContentTag() {
    const tagId = this.router.currentRoute?.attributes?.tag?.id;
    return ['articles', 'events', 'bulletins'].includes(tagId);
  }

  get isJobTag() {
    const tagId = this.router.currentRoute?.attributes?.tag?.id;
    return tagId === 'jobs';
  }

  get currentCategory() {
    return this.router.currentRoute?.attributes?.category;
  }

  get currentTag() {
    return this.router.currentRoute?.attributes?.tag;
  }

  get shouldRender() {
    return this.router.currentRouteName === 'tags.showCategory';
  }

  <template>
    {{#if this.shouldRender}}
      {{#if this.isContentTag}}
        <ContentCard @category={{this.currentCategory}} @tag={{this.currentTag}} />
      {{else if this.isJobTag}}
        <JobCard @category={{this.currentCategory}} />
      {{/if}}
    {{/if}}
  </template>
}

export default CustomTagDataRender;
