import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { LinkTo }from '@ember/routing';
import { array } from '@ember/helper';

export default class RecentCard extends Component {

  @tracked latestTopics = [];
  @tracked isLoading = true;

  recentTopicSoftwares = ['/c/erp-enterprise-resource-planning/sap-s4hana/1588', '/c/crm-customer-relationship-management/salesforce/1589', '/c/hcm-human-capital-management/workday-hcm/2163', '/c/plm-product-lifecycle-management/teamcenter/686'];

  constructor() {
    super(...arguments);
    this.getRecentTopics();
  }

  async getRecentTopics() {
    const topics = [];
    this.isLoading = true;
    
    for(let url of this.recentTopicSoftwares) {
      try {
        const response = await fetch(`${url}.json`);
        const data = await response.json();
        const firstTopic = data.topic_list?.topics?.[0];
        if (firstTopic) {
          topics.push(firstTopic);
        }
      } catch (error) {
        console.error(`Error fetching ${url}:`, error);
      } finally {
        this.isLoading = false;
      }
    }
    
    this.latestTopics = topics;
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
    const username = topic.last_poster_username;
    const timeAgo = this.getTimeAgo(topic.bumped_at);    
    return `Posted by ${username} • ${timeAgo}`;
  }


  formatAnswerCount(topic) {
    const count = topic.reply_count || 0;
    return count === 0 ? 'No answer' : `${count} answers`;
  }

  formatTitle(topic) {
    return topic.title || 'Untitled Topic';
  }

  getTopicSlug(topic) {
    return topic.slug;
  }

  getTopicId(topic) {
    return topic.id;
  }

  getCategoryName(topic) {
    const cat_id = topic.category_id;

    let categoryMapper = {
      1588: "SAP S/4HANA",
      1589: "Salesforce",
      2163: "Workday",
      686: "Teamcenter"
    }
    return categoryMapper[cat_id] || "Unknown Category";
  }

  getCategoryId(topic) {
    let cat_id = topic.category_id
    return cat_id;
  }

  getCategoryUrl = (topic) => {
    const cat_id = topic.category_id;
    let categoryUrlMapper = {
      1588: this.recentTopicSoftwares[0], // SAP S/4HANA
      1589: this.recentTopicSoftwares[1],
      2163: this.recentTopicSoftwares[2],
      686: this.recentTopicSoftwares[3] 
    }
    return categoryUrlMapper[cat_id] || this.recentTopicSoftwares[0];
  }


  <template>
    <div class="section section--recent">
      <div class="section-header">
        <div class="section-title">
          <span class="section-icon">💬</span>Recent Topics
        </div>
      </div>
      {{#if this.isLoading}}
        <div class="loading w-full p-4 flex items-center justify-center text-sm font-bold text-primary-500 animate-pulse">Loading topics...</div>
      {{else if this.latestTopics.length}}
      {{#each this.latestTopics as |topic|}}
      {{#let 
        (this.formatPostedBy topic)
        (this.formatAnswerCount topic)
        (this.formatTitle topic)
        (this.getTopicSlug topic)
        (this.getTopicId topic)
        (this.getCategoryName topic)
        (this.getCategoryUrl topic)
        as |postedBy answerCount title topicSlug topicId catName catUrl|
      }}
        <div class="topic-item">
          <LinkTo @route="topic.fromParams" @models={{array topicSlug topicId}}>
            <div class="topic-title">
              {{title}}
            </div>
            {{!-- <div class="topic-body">
              Tips for planning, testing, and rolling out Lightning with minimal
              disruption.
            </div> --}}
            <div class="topic-meta">{{postedBy}}</div>
          </LinkTo>
          <div class="topic-footer">
            <a href={{catUrl}} class="topic-view-all">View All {{catName}} Topics →</a>
          </div>
        </div>
      {{/let}}
      {{/each}}
      {{/if}}
    </div>
  </template>
}