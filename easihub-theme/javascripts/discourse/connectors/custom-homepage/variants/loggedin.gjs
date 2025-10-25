import Component from '@glimmer/component';
import SearchMenu from "discourse/components/search-menu";
import DButton from "discourse/components/d-button";
import { service } from '@ember/service';
import PluginOutlet from 'discourse/components/plugin-outlet';
import lazyHash from 'discourse/helpers/lazy-hash';
import CategoriesBoxes from 'discourse/components/categories-boxes';
import CategoryList from 'discourse/models/category-list';
import Category from 'discourse/models/category';
import { LinkTo } from '@ember/routing';
import RecentCard from '../../../../components/recent-cards/recent-card.gjs';
import ArticleCard from '../../../../components/recent-cards/article-card.gjs';
import JobCard from '../../../../components/recent-cards/job.gjs';
import EventCard from '../../../../components/recent-cards/event-card.gjs';
import { action } from '@ember/object';
import { ajax } from "discourse/lib/ajax";
import { tracked } from '@glimmer/tracking';



export class LoggedinHomepage extends Component {
  @service currentUser;
  @service router;
  @service site;

  @tracked allUsersCount = 0;

  constructor() {
    super(...arguments);
    this.getAllUsers();
  }

  get currentUsername() {
    let username = this.currentUser.username;
    return `${username.toUpperCase()} !`;
  }

  get categories() {
    const list = Category.list()
      .filter(c => c.isOfType('hub', 'domain'));
    return list;
  }

  @action

  async getAllUsers() {
    let data = {
      period: "all",
      order: "topic-count"
    } 
    const res = await ajax("/directory_items.json",{
      type: "GET",
      data
    })
    this.allUsersCount = res.meta.total_rows_directory_items;
  }

  <template>
    <section class="welcome-section">
      <div class="sub-container">
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
    <div class="sub-container">
      <div class="search-section">
        <div class="search-sub-container">
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

    <div class="sub-container">
      <div class="start-explore">
        <span class="text-slate-900/70 text-sm">
          Not sure where to begin?
        </span>
        <a href="https://easihub.com/community/getting-started">
          <span class="text-primary-500 mx-1 text-sm font-semibold hover:text-primary-800 hover:underline">Start Exploring</span>
        </a>
        <span class="text-slate-900/70 text-sm">
          our community →
        </span>
      </div>
    </div>

    <!-- Navigation Tabs -->
    <div class="sub-container">
      <div class="navigation-tabs">
        <div class="tab-links">
          <a href="#domains" class="tab-link active">
            <i class="fas fa-th-large"></i> Browse Domains
          </a>
          <a href="#software" class="tab-link">
            <i class="fas fa-cogs"></i> Find Software
          </a>
          <a href="/latest" class="tab-link">
            <i class="fas fa-clock"></i> Latest Activity
          </a>
          <a href="https://easihub.com/community/guidelines " class="tab-link">
            <i class="fas fa-info-circle"></i> Guidelines
          </a>
        </div>
        <div class="quick-stats">
          <span class="stat">{{this.allUsersCount}} members online</span>
          <span class="stat">45 discussions today</span>
        </div>
      </div>
    </div>

    <!-- Recent Activity -->
    <div class="main-wrapper">
      <div id="domains">
        <span class="domain-title">Enterprise Application Hubs</span>
        <CategoriesBoxes @categories={{this.categories}} class="mb-8"/>
      </div>
      <div class="sidebar">
        <RecentCard/>
        <ArticleCard/>
        <JobCard/>
        <EventCard/>
      </div>
    </div>

  </template>
}