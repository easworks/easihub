import Component from '@glimmer/component';
import SearchMenu from "discourse/components/search-menu";
import DButton from "discourse/components/d-button";
import { service } from '@ember/service';
import PluginOutlet from 'discourse/components/plugin-outlet';
import lazyHash from 'discourse/helpers/lazy-hash';
import { tracked } from '@glimmer/tracking';

export default class LoggedinHomepage extends Component {
  @service currentUser;
  @service store;

  @tracked latestTopics = [];

  constructor() {
    super(...arguments);
    this.getRecentTopics();
  }

  get currentUsername() {
    let username = this.currentUser.username;
    return `${username.toUpperCase()} !`;
  }

  async getRecentTopics() {
    try {
      const topicList = await this.store.findFiltered('topicList', {
        filter: 'latest',
        params: { per_page: 6 }
      });
      this.latestTopics = topicList.topics.slice(0, 6);
    } catch (error) {
      console.error(error);
    }
  }

  <template>
    <section class="welcome-section">
      <div class="container">
        <div class="welcome-content">
          <h1 class="welcome-greeting">Welcome back, {{if this.currentUsername this.currentUsername null}}</h1>
          <p class="welcome-subtitle">
            Continue exploring EA discussions and connect with professionals
          </p>
          <div class="welcome-actions">
            <a href="#domains" class="btn-home btn-white">
              <i class="fas fa-map-signs"></i> Find Your Domain First
            </a>
            <a href="/latest" class="btn-home btn-outline">
              <i class="fas fa-clock"></i> Latest Activity
            </a>
          </div>
          <div class="posting-hint">
            <i class="fas fa-lightbulb"></i>
            <span>
              New to posting? Browse domains below to find the right place for your
              question
            </span>
          </div>
        </div>
      </div>
    </section>

    <!-- Search Bar -->
    <div class="container">
      <div class="search-section">
        <div class="search-container">
          <SearchMenu 
            class="w-full"
          />
          <DButton
              @icon="magnifying-glass"
              @title="search.open_advanced"
              @href="/search?expanded=true"
              class="search-icon"
            />
        </div>
      </div>
    </div>

    <!-- Navigation Tabs -->
    <div class="container">
      <div class="navigation-tabs">
        <div class="tab-links">
          <a href="#domains" class="tab-link active">
            <i class="fas fa-th-large"></i> Browse Domains
          </a>
          <a href="#software" class="tab-link">
            <i class="fas fa-cogs"></i> Find Software
          </a>
          <a href="#latest" class="tab-link">
            <i class="fas fa-clock"></i> Latest Activity
          </a>
          <a href="#guidelines" class="tab-link">
            <i class="fas fa-info-circle"></i> Guidelines
          </a>
        </div>
        <div class="quick-stats">
          <span class="stat">156 members online</span>
          <span class="stat">45 discussions today</span>
        </div>
      </div>
    </div>

    <!-- Recent Activity -->
    <div class="container">
      <div class="recent-activity">
        <div class="activity-header">
          <h2 class="activity-title">
            <div class="live-indicator"></div>
            Recent Activity
          </h2>
          <a href="/latest" class="view-all-link">View All →</a>
        </div>

        <div class="activity-grid">
          <div class="activity-item">
            <div class="activity-meta">
              <div class="activity-wrap">
                <div class="activity-info">
                  <span class="activity-tag sap">SAP S/4HANA</span>
                  <span class="domain-label">ERP Systems</span>
                </div>
                <div>
                  <span>Posted by Sarah M. • 15 min ago</span>
                </div>
              </div>
              <span class="activity-status answered">
                <i class="fas fa-check-circle"></i> 3 answers
              </span>
            </div>
            <div class="activity-title-text">
              S/4HANA migration - custom ABAP compatibility issues
            </div>
            <div class="activity-excerpt">
              Running into deprecated function modules during our conversion from
              ECC to S/4HANA...
            </div>
          </div>

          <div class="activity-item">
            <div class="activity-meta">
              <div class="activity-wrap">
                <div class="activity-info">
                  <span class="activity-tag salesforce">Salesforce Lightning</span>
                  <span class="domain-label">CRM Systems</span>
                </div>
                <div>
                  <span>Posted by Mike R. • 28 min ago</span>
                </div>
              </div>
              <span class="activity-status answered">
                <i class="fas fa-check-circle"></i> 2 answers
              </span>
            </div>
            <div class="activity-title-text">
              Lightning component performance optimization techniques
            </div>
            <div class="activity-excerpt">
              Looking for best practices to improve load times for custom Lightning
              components...
            </div>
          </div>

          <div class="activity-item">
            <div class="activity-meta">
              <div class="activity-wrap">
                <div class="activity-info">
                  <span class="activity-tag plm">Teamcenter PLM</span>
                  <span class="domain-label">PLM Systems</span>
                </div>
                <div>
                  <span>Posted by David T. • 2 hours ago</span>
                </div>
              </div>
              <span class="activity-status answered">
                <i class="fas fa-check-circle"></i> Solved
              </span>
            </div>
            <div class="activity-title-text">
              Teamcenter workflow approval process customization
            </div>
            <div class="activity-excerpt">
              Successfully implemented multi-level approval workflows for
              engineering changes...
            </div>
          </div>

          <div class="activity-item">
            <div class="activity-meta">
              <div class="activity-wrap">
                <div class="activity-info">
                  <span class="activity-tag oracle">Oracle ERP Cloud</span>
                  <span class="domain-label">ERP Systems</span>
                </div>
                <div>
                  <span>Posted by Lisa K. • 3 hours ago</span>
                </div>
              </div>
              <span class="activity-status answered">
                <i class="fas fa-check-circle"></i> 1 answer
              </span>
            </div>
            <div class="activity-title-text">
              Oracle ERP Cloud integration with legacy systems
            </div>
            <div class="activity-excerpt">
              Need guidance on middleware options for connecting Oracle Cloud ERP...
            </div>
          </div>
        </div>
      </div>
    </div>
    <div id="domains">
      <PluginOutlet
        @name="discovery-list-area"
        @outletArgs={{lazyHash
          category=@model.category
          tag=@model.tag
          model=@model
        }}
        @defaultGlimmer={{true}}
      >
        <PluginOutlet
          @name="discovery-list-container-top"
          @connectorTagName="span"
          @outletArgs={{lazyHash category=@model.category tag=@model.tag}}
        />
      </PluginOutlet>
    </div>

  </template>
}