import Component from '@glimmer/component';
import { service } from '@ember/service';
import { tracked } from '@glimmer/tracking';
import { LinkTo }from '@ember/routing';
import { array } from '@ember/helper';



export default class RecentTopicsLoggedin extends Component {
  @service store

  @tracked latestTopics = [];

  constructor() {
    super(...arguments);
    this.getRecentTopics();
  }

  async getRecentTopics() {
    try {
      const topicList = await this.store.findFiltered('topicList', {
        filter: 'latest',
        params: { per_page: 6 }
      });
      this.latestTopics = topicList.topics;
    } catch (error) {
      console.error(error);
    }
  }

  formatCategoryTag(topic) {
    return topic.category?.parentCategory?.name || 'General';
  }

  formatCategorySlug(topic) {
    return topic.category?.parentCategory?.slug || 'general';
  }

  formatDomainLabel(topic) {
    return topic.category?.parentCategory?.parentCategory?.name || 'Systems';
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

  formatPostedBy = (topic) => {
    const username = topic.posters?.firstObject?.user?.name ? topic.posters?.firstObject?.user?.name : topic.posters?.firstObject?.user?.username;
    const finalUsername = username.charAt(0).toUpperCase() + username.slice(1);
    const timeAgo = this.getTimeAgo(topic.bumped_at);    
    return `Posted by ${finalUsername} • ${timeAgo}`;
  }


  formatAnswerCount(topic) {
    const count = topic.reply_count || 0;
    return count === 0 ? 'No answer' : `${count} answers`;
  }

  formatTitle(topic) {
    return topic.title || 'Untitled Topic';
  }

  formatExcerpt(topic) {
    return topic.excerpt || 'No description available...';
  }

  getTopicSlug(topic) {
    return topic.slug;
  }

  getTopicId(topic) {
    return topic.id;
  }

  <template>
    {{log this.latestTopics}}
    {{#if this.latestTopics}}
    {{#each this.latestTopics as |topic|}}
    {{#let 
      (this.formatCategoryTag topic)
      (this.formatCategorySlug topic)
      (this.formatDomainLabel topic)
      (this.formatPostedBy topic)
      (this.formatAnswerCount topic)
      (this.formatTitle topic)
      (this.formatExcerpt topic)
      (this.getTopicSlug topic)
      (this.getTopicId topic)
      as |categoryTag categorySlug domainLabel postedBy answerCount title excerpt topicSlug topicId|
    }}

    <LinkTo @route="topic.fromParams" @models={{array topicSlug topicId}}>
      <div class="activity-item">
        <div class="activity-meta">
          <div class="activity-wrap">
            <div class="activity-info">
              <span class="activity-tag {{categorySlug}}">{{categoryTag}}</span>
              <span class="domain-label">{{domainLabel}}</span>
            </div>
            <span class="activity-status answered">
              <i class="fas fa-check-circle"></i> {{answerCount}}
            </span>
          </div>
          <span>{{postedBy}}</span>
        </div>
        <div class="activity-content">
          <div class="activity-title-text">{{title}}</div>
          <div class="activity-excerpt">{{excerpt}}</div>
        </div>
      </div>
    </LinkTo>
    {{/let}}
    {{/each}}
    {{/if}}
  </template>
}

