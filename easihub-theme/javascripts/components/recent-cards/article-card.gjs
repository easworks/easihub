import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { LinkTo }from '@ember/routing';
import { array } from '@ember/helper';


export default class ArticleCard extends Component {

  @tracked articles = [];
  @tracked isLoading = false;

  articlesCategory = [
    {
      "domain": "CRM",
      "software": "Salesforce"
    },
    {
      "domain": "ERP",
      "software": "SAP S/4HANA"
    },
    {
      "domain": "PLM",
      "software": "Aras Innovator"
    },
  ]

  softwareUrls = {
    "Salesforce": "/tags/c/crm-customer-relationship-management/salesforce/1589/article",
    "SAP S/4HANA": "/tags/c/erp-enterprise-resource-planning/sap-s4hana/1588/article",
    "Aras Innovator": "/tags/c/plm-product-lifecycle-management/aras-innovator/722article"
  }

  constructor(){
    super(...arguments);
    this.getArticles();
  }

  async getArticles() {
    const allArticles = [];

    this.isLoading = true;

    for (const item of this.articlesCategory) {
      try {
        const data = {
          domain_name: item.domain,
          software_name: item.software, 
          topic_type: "articles",
          page_num: 1,
          page_size: 1
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
        allArticles.push(...newContent);
        
      } catch (error) {
        console.error(`Error fetching articles for ${item.software}:`, error);
      } finally {
        this.isLoading = false;
      }
    }
    
    this.articles = allArticles;
  }

  getAuthorName(article){
    return (typeof article.author_name === "string" && article.author_name.trim() !== "")
    ? article.author_name
    : "Unknown Author";
  }

  getCategoryUrl = (article) => {
    return this.softwareUrls[article.software_name] || "#";
  }

  getUrl = (article) => {
    if(!article.url){
      return this.softwareUrls[article.software_name] || '#';
    }
    return article.url;
  }

  <template>
      <div class="section section--articles">
          <div class="section-header">
            <div class="section-title">
              <span class="section-icon">📄</span>Articles
            </div>
          </div>
          {{#if this.isLoading}}
            <div class="loading w-full p-4 flex items-center justify-center text-sm font-bold text-primary-500 animate-pulse">Loading articles...</div>
          {{else if this.articles.length}}
          {{#each this.articles as |article|}}
          {{#let 
            (this.getAuthorName article)
            (this.getCategoryUrl article)
            (this.getUrl article)
            as |author categoryUrl articleUrl|
          }}
            <div class="article-card" style="border-left: 3px solid #0b1f3b">
              <a href={{articleUrl}} class="article-content">
                <div class="article-title">
                  {{article.title}}
                </div>
                <div class="article-author">{{author}}</div>
                <div class="article-source">{{article.source_name}}</div>
              </a>
              <div class="article-footer">
                <a href={{categoryUrl}} class="article-view-all"
                  >View All {{article.software_name}} Articles →</a
                >
              </div>
            </div>
          {{/let}}
          {{/each}}
          {{/if}}
      </div>
  </template>
}