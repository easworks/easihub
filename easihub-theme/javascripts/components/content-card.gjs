import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { action } from '@ember/object';
import { service } from '@ember/service';
import { htmlSafe } from '@ember/template';
import { on } from '@ember/modifier';



export default class ContentCardComponent extends Component {
  @service router;
  @tracked content = [];
  @tracked isLoading = false;
  @tracked isLoadingMore = false;
  @tracked error = null;
  @tracked totalRecords = 0;
  @tracked pageNum = 1;
  @tracked pageSize = 9;

  constructor() {
    super(...arguments);
    this._lastRoute = null;
    this.router.on('routeDidChange', this.handleRouteChange.bind(this));
    if (this.currentTagId) {
      this.fetchContent();
    }
  }

  willDestroy() {
    super.willDestroy();
    this.router.off('routeDidChange', this.handleRouteChange.bind(this));
  }

  @action
  handleRouteChange() {
    const currentRoute = this.router.currentURL;
    if (currentRoute !== this._lastRoute && this.currentTagId) {
      this._lastRoute = currentRoute;
      this.fetchContent();
    }
  }

  get currentTagId() {
    return this.router.currentRoute?.attributes?.tag?.id;
  }

  get topicType() {
    return this.currentTagId;
  }

  get showMore() {
    return this.content.length >= this.pageSize * this.pageNum;
  }

  get showMoreButton() {
    return this.showMore || this.isLoadingMore;
  }

  getCategoryDetails() {
    if (!this.args.category) {
      return {
        domain_name: null,
        software_name: null
      };
    }

    if (this.args.category.parentCategory) {
      return {
        domain_name: this.args.category.parentCategory.name,
        software_name: this.args.category.name
      };
    }

    return {
      domain_name: this.args.category.name,
      software_name: this.args.category.name
    };
  }

  getMomentDate(date) {
    if (!date) return '';
    return new Date(date).toLocaleDateString();
  }

  getEventLabelColor(eventType) {
    const colors = {
      'Event': '#007cba',
      'Webinar': '#28a745',
      'Conference': '#dc3545'
    };
    return colors[eventType] || '#007cba';
  }

  renderTemplate(item) {
    const { domain_name, software_name } = this.getCategoryDetails();
    const itemWithCategory = { ...item, domain_name, software_name };
    
    if (this.topicType === 'article') {
      return this.templateArticle(itemWithCategory);
    } else if (this.topicType === 'event') {
      return this.templateEvent(itemWithCategory);
    } else if (this.topicType === 'bulletin') {
      return this.templateBulletin(itemWithCategory);
    }
    return '';
  }

  templateArticle(item) {
    const { _id, title = "Article Title", software_name, domain_name, source_name, description = "Lorem ipsum dolor sit amet consectetur adipisicing elit.", topic_date, url, thumbnail_url } = item;
    let author_name = item.author_name == null || item.author_name == "null" ? '' : item.author_name;
    const dateStr = topic_date ? new Date(topic_date).toLocaleDateString() : '';
    
    return `
      <div class="bg-white border border-gray-200 rounded-lg p-4 shadow-md hover:shadow-primary-500 transition-shadow flex flex-col h-full">
        <a target="_blank" class="block" href="${url}">
          <div class="w-full h-48 mb-4">
            <img src="${thumbnail_url}" class="w-full h-full object-cover rounded" alt="" />
          </div>
          <div class="flex justify-between text-gray-600 text-sm mb-2">
            <span>${domain_name} | ${software_name}</span>
            <i class="fas fa-share-alt hover:opacity-80 share-icon cursor-pointer" data-article-id="${_id || ''}"></i>
          </div>
          <div class="text-lg font-semibold mb-2 text-gray-900">
            ${title}
          </div>
          <div class="text-sm mb-2">
            <span class="text-cyan-500">${dateStr}</span>
          </div>
        </a>
        <div class="text-gray-700 text-sm mb-4 flex-grow line-clamp-3">
          ${description}
        </div>
        <div class="flex justify-between items-center text-sm mt-auto">
          <div class="font-bold text-gray-800">${source_name}</div>
          <div class="text-gray-500">|</div>
          <div class="text-gray-600">${author_name}</div>
        </div>
      </div>
    `;
  }

  templateEvent(item) {
    const {_id, title, software_name, domain_name, source_name, description, start_date, end_date, event_type, url, thumbnail_url } = item;
    let author_name = item.author_name == null ? '' : item.author_name;
    const startDate = start_date ? this.getMomentDate(start_date) : 'TBD';
    const endDate = end_date ? this.getMomentDate(end_date) : 'TBD';
    
    return `
      <div class="bg-white border border-gray-200 rounded-lg p-4 shadow-md hover:shadow-primary-500 transition-shadow flex flex-col h-full">
        <a target="_blank" class="block" href="${url}">
          <div class="w-full h-48 mb-4 relative">
            <div class="absolute top-2 left-2 px-2 py-1 text-xs text-white rounded" style="background:${this.getEventLabelColor(event_type || "Event")}">${event_type || "Event"}</div>
            <img src="${thumbnail_url}" class="w-full h-full object-cover rounded" alt="" />
          </div>
          <div class="flex justify-between text-gray-600 text-sm mb-2">
            <span>${domain_name} | ${software_name}</span>
            <i class="fas fa-share-alt hover:opacity-80 share-icon cursor-pointer" data-article-id="${_id || ''}"></i>
          </div>
          <div class="text-lg font-semibold mb-2 text-gray-900">
            ${title}
          </div>
        </a>
        <div class="flex flex-col gap-1 mb-4">
          <span class="text-blue-600 text-sm">Start: ${startDate}</span>
          <span class="text-blue-600 text-sm">End: ${endDate}</span>
        </div>
        <div class="text-gray-700 text-sm mb-4 flex-grow line-clamp-3">
          ${description}
        </div>
        <div class="flex justify-between items-center text-sm mt-auto">
          <div class="font-bold text-gray-800">${source_name}</div>
          <div class="text-gray-500">|</div>
          <div class="text-gray-600">${author_name}</div>
        </div>
      </div>
    `;
  }

  templateBulletin(item){ 
    const {_id, title = "Article Title", software_name, domain_name, source_name, description = "Lorem ipsum dolor sit amet consectetur adipisicing elit.", release_date, topic_date, url, thumbnail_url }= item;
    let author_name = item.author_name == null ? '' : item.author_name;
    let version_name = item.version_name == null ? '' : item.version_name;
    const releaseDate = release_date ? this.getMomentDate(release_date) : 'TBD';
    const topicDate = topic_date ? this.getMomentDate(topic_date) : '';
    
    return `
      <div class="bg-white border border-gray-200 rounded-lg p-4 shadow-md hover:shadow-primary-500 transition-shadow flex flex-col h-full">
        <a target="_blank" class="block" href="${url}">
          <div class="w-full h-48 mb-4">
            <img src="${thumbnail_url}" class="w-full h-full object-cover rounded" alt="" />
          </div>
          <div class="flex justify-between text-gray-600 text-sm mb-2">
            <span>${domain_name} | ${software_name}</span>
            <i class="fas fa-share-alt hover:opacity-80 share-icon cursor-pointer" data-article-id="${_id || ''}"></i>
          </div>
          <div class="text-lg font-semibold mb-2 text-gray-900">
            ${title}
          </div>
          ${topicDate ? `<div class="text-sm mb-2"><span class="text-cyan-500">${topicDate}</span></div>` : ''}
        </a>
        <div class="flex flex-col gap-1 mb-4">
          ${version_name ? `<span class="text-blue-600 text-sm">${version_name}</span>` : ''}
          <span class="text-blue-600 text-sm">Release Date: ${releaseDate}</span>
        </div>
        <div class="text-gray-700 text-sm mb-4 flex-grow line-clamp-3">
          ${description}
        </div>
        <div class="flex justify-between items-center text-sm mt-auto">
          <div class="font-bold text-gray-800">${source_name}</div>
          <div class="text-gray-500">|</div>
          ${author_name ? `<div class="text-gray-600 truncate max-w-24">${author_name}</div>` : '<div></div>'}
        </div>
      </div>
    `;
  }

  get renderedContent() {
    if (!this.content?.length) {
      return htmlSafe('<div class="text-center text-gray-500 py-8">No content available</div>');
    }
    const html = this.content.map(item => this.renderTemplate(item)).join('');
    return htmlSafe(`<div class="grid md:grid-cols-1 lg:grid-cols-2 xl:grid-cols-3 gap-4 mt-2">${html}</div>`);
  }

  static tagMapper(topicType) {
    switch (topicType) {
      case 'article':
        return 'articles';
      case 'event':
        return 'events';
      case 'bulletin':
        return 'bulletins';
      default:
        return topicType;
    }
  }

  @action
  async shareArticle(event, article) {
    event.preventDefault();
    event.stopPropagation();
    
    const shareData = {
      title: article.title,
      text: `Check out this article: ${article.title}`,
      url: article.url || window.location.href
    };

    try {
      if (navigator.share) {
        await navigator.share(shareData);
      } else {
        await navigator.clipboard.writeText(`${shareData.title}\n${shareData.text}\n${shareData.url}`);
        alert('Article link copied to clipboard!');
      }
    } catch (error) {
      console.error('Error sharing:', error);
    }
  }

  @action
  handleShareClick(event) {
    const shareIcon = event.target.closest('.share-icon');
    if (shareIcon) {
      const articleId = shareIcon.dataset.articleId;
      const article = this.content.find(item => item._id === articleId);
      if (article) {
        this.shareArticle(event, article);
      }
    }
  }

  @action
  async fetchTotalCount() {
    const { domain_name, software_name } = this.getCategoryDetails();
    const data = {
      domain_name,
      software_name,
      topic_type: ContentCardComponent.tagMapper(this.topicType)
    };

    try {
      const response = await fetch('https://community.easihub.com/erp_db/api/erp-collections/count', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify(data)
      });

      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
      }
      const result = await response.json();
      this.totalRecords = result.totalRecords || 0;
    } catch (error) {
      console.error('Error fetching count:', error);
    }
  }

  @action
  async fetchContent(reset = true) {
    if (!this.topicType || !this.args) return;
    
    if (reset) {
      this.pageNum = 1;
      this.content = [];
      this.isLoading = true;
      await this.fetchTotalCount();
    } else {
      this.isLoadingMore = true;
    }
    
    this.error = null;
    
    try {
      const { domain_name, software_name } = this.getCategoryDetails();
    
      const data = {
        domain_name,
        software_name, 
        topic_type: ContentCardComponent.tagMapper(this.topicType),
        page_num: this.pageNum,
        page_size: this.pageSize
      };
      
      const response = await fetch('https://community.easihub.com/erp_db/api/erp-collections', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify(data)
      });

      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
      }
      const result = await response.json();
      const newContent = Array.isArray(result) ? result : (result?.data || []);
      
      if (reset) {
        this.content = newContent;
      } else {
        this.content = [...this.content, ...newContent];
      }
    } catch (error) {
      console.error('Error fetching content:', error);
      this.error = error?.message || 'Unknown error';
    } finally {
      this.isLoading = false;
      this.isLoadingMore = false;
    }
  }

  @action
  async loadMore() {
    this.pageNum += 1;
    await this.fetchContent(false);
  }

  <template>
    <div class="content-card" {{on "click" this.handleShareClick}}>
      {{#if this.isLoading}}
        <div class="loading w-full p-4 flex items-center justify-center text-xl font-bold text-primary-500 animate-pulse">Loading {{this.topicType}}...</div>
      {{else if this.error}}
        <div class="error">Error: {{this.error}}</div>
      {{else if this.content.length}}
        {{{this.renderedContent}}}
        {{#if this.showMoreButton}}
          <div class="text-center mt-6">
            <button 
              class="bg-primary-500 hover:bg-primary-700 text-white px-6 py-2 rounded-lg transition-colors {{if this.isLoadingMore 'animate-pulse'}}" 
              onclick={{this.loadMore}}
              disabled={{this.isLoadingMore}}
            >
              {{#if this.isLoadingMore}}Loading...{{else}}Show More{{/if}}
            </button>
          </div>
        {{/if}}
      {{else}}
        <div class="w-full p-4 flex items-center justify-center">No {{this.topicType}} found</div>
      {{/if}}
    </div>
  </template>
}