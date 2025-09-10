import Component from '@glimmer/component';
import SearchMenu from "discourse/components/search-menu";
import DButton from "discourse/components/d-button";
import { service } from '@ember/service';
import PluginOutlet from 'discourse/components/plugin-outlet';
import lazyHash from 'discourse/helpers/lazy-hash';
import CategoriesBoxes from 'discourse/components/categories-boxes';
import CategoryList from 'discourse/models/category-list';
import Category from 'discourse/models/category';
import RecentTopicsLoggedIn from '../../../../components/recent-topics-loggedin';

export class LoggedinHomepage extends Component {
  @service currentUser;

  get currentUsername() {
    let username = this.currentUser.username;
    return `${username.toUpperCase()} !`;
  }

  get categories() {
    const list = Category.list()
      .filter(c => c.isOfType('hub', 'domain'));
    return list;
  }

  <template>
    {{log this.latestTopics}}
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
          <RecentTopicsLoggedIn />
        </div>
      </div>
    </div>
    <div id="domains">
      <span class="domain-title">Enterprise Application Hubs</span>
      <CategoriesBoxes @categories={{this.categories}} class="mb-8"/>
    </div>

  </template>
}