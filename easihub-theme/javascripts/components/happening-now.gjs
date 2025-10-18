import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { service } from '@ember/service';

export default class HappeningNow extends Component {
  @service store;
  @tracked mergedTopics = []

  constructor() {
    super(...arguments);
    this.getHappeningNowTopics();
  }

  categories = [1588, 1589, 2163, 686]

  async getHappeningNowTopics() {
    try {
      const results = await Promise.all(
        this.categories.map(cat =>
          this.store.findFiltered("topicList", {
            filter: "latest",
            params: { category: cat, per_page: 1 }
          })
        )
      );
      this.mergedTopics = results.flatMap(r => r.topics);
    } catch (error) {
      console.error(error);
    }
  }

  getTimeAgo(dateString) {
    const now = new Date();
    const postDate = new Date(dateString);
    const diffInMs = now - postDate;
    const diffInMinutes = Math.floor(diffInMs / (1000 * 60));
    const diffInHours = Math.floor(diffInMs / (1000 * 60 * 60));
    const diffInDays = Math.floor(diffInMs / (1000 * 60 * 60 * 24));

    if (diffInMinutes < 60) {
      return `${diffInMinutes} min ago`;
    } else if (diffInHours < 24) {
      return `${diffInHours} hr ago`;
    } else {
      return `${diffInDays} day${diffInDays > 1 ? 's' : ''} ago`;
    }
  }

  formatedCategoryTag(topic) {
    const categoryName = topic?.category?.name;
    return categoryName;
  }

  formatPostedBy = (topic) => {
    const username = topic.posters?.firstObject?.user?.name ? topic.posters?.firstObject?.user?.name : topic.posters?.firstObject?.user?.username;
    const finalUsername = username.charAt(0).toUpperCase() + username.slice(1);
    const timeAgo = this.getTimeAgo(topic.bumped_at);    
    return `Posted by ${finalUsername} • ${timeAgo}`;
  }

  formatTitle(topic) {
    return topic.title || 'Untitled Topic';
  }

  formatExcerpt(topic) {
    return topic.excerpt || 'No description available...';
  }

  <template>
    {{#if this.mergedTopics}}
      {{#each this.mergedTopics as |topic|}}
      {{#let 
        (this.formatedCategoryTag topic)
        (this.formatPostedBy topic)
        (this.formatTitle topic)
        (this.formatExcerpt topic)
        as |categoryName postedBy title excerpt|
      }}
        <div class="discussion-item">
          <div class="discussion-meta">
            <span class="discussion-tag">{{categoryName}}</span>
            <span>{{postedBy}}</span>
          </div>
          <div class="discussion-title">
            {{title}}
          </div>
          <div class="discussion-excerpt">
            {{excerpt}}
          </div>
        </div>
      {{/let}}
      {{/each}}
    {{else}}
      <div class="w-full p-4 flex items-center justify-center">
        <span class="text-lg text-slate-900/70 font-semibold">No Latest Topics Available...</span>
      </div>
    {{/if}}
  </template>
}