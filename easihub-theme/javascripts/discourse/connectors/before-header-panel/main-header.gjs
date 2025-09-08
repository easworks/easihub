import Component from '@glimmer/component';
import { action } from '@ember/object';
import { on } from '@ember/modifier';
import { service } from '@ember/service';

export class MainHeader extends Component {
  @service router;
  @service currentUser;

  constructor() {
    super(...arguments);
    this.setupEventListeners();
  }

  setupEventListeners() {
    // Close dropdowns when clicking outside
    document.addEventListener('click', (event) => {
      if (!event.target.closest('.nav-item.has-dropdown')) {
        this.closeAllDropdowns();
      }
    });

    // Close mobile menu when clicking outside
    document.addEventListener('click', (event) => {
      const nav = document.getElementById('mainNav');
      const toggle = document.querySelector('.mobile-menu-toggle');
      
      if (nav && toggle && !nav.contains(event.target) && !toggle.contains(event.target)) {
        nav.classList.remove('open');
      }
    });

    // Handle keyboard navigation
    document.addEventListener('keydown', (event) => {
      if (event.key === 'Escape') {
        this.closeAllDropdowns();
        const nav = document.getElementById('mainNav');
        if (nav) nav.classList.remove('open');
      }
    });
  }

  get loggedIn() {
    return !this.currentUser;
  }

  get isCurrentURLHomePage() {
    return this.router.currentRouteName === 'discovery.categories';
  }

  get isCurrentURLHubsPage() {
    return this.router.currentRouteName === 'discovery.category' || this.router.currentRouteName === 'tags.showCategory'
  }

  closeAllDropdowns() {
    document.querySelectorAll('.nav-item.has-dropdown').forEach(item => {
      item.classList.remove('open');
    });
  }

  @action
  toggleDropdown(event) {
    event.preventDefault();
    event.stopPropagation();
    
    const navItem = event.target.closest('.nav-item');
    const isOpen = navItem.classList.contains('open');
    
    // Close all dropdowns first
    this.closeAllDropdowns();
    
    // If it wasn't open, open it
    if (!isOpen) {
      navItem.classList.add('open');
    }
  }

  @action
  toggleMobileMenu() {
    const nav = document.getElementById('mainNav');
    if (nav) nav.classList.toggle('open');
  }

  <template>
    <nav class="main-nav ml-12" id="mainNav">
        <div class="nav-item">
            <a href="/" class="nav-link {{if this.isCurrentURLHomePage 'active'}}">Home</a>
        </div>
        
        <div class="nav-item has-dropdown">
            <a href="#" class="nav-link" {{on "click" this.toggleDropdown}}>Software</a>
            <div class="dropdown">
                <div class="dropdown-item">
                    <a href="#" class="dropdown-link">Browse All Software</a>
                </div>
                <div class="dropdown-item">
                    <a href="#" class="dropdown-link">Search Software</a>
                </div>
                <div class="dropdown-item">
                    <a href="#" class="dropdown-link">By Domain</a>
                </div>
            </div>
        </div>
        
        <div class="nav-item has-dropdown">
            <a href="#" class="nav-link {{if this.isCurrentURLHubsPage 'active'}}" {{on "click" this.toggleDropdown}}>Hubs</a>
            <div class="dropdown mega-dropdown">
                <div class="mega-grid">
                    <div class="mega-column">
                        <h4>Core Business Systems</h4>
                        <a href="/c/erp-enterprise-resource-planning/69" class="dropdown-link">ERP - Enterprise Resource Planning</a>
                        <a href="/c/crm-customer-relationship-management/14" class="dropdown-link">CRM - Customer Relationship Management</a>
                        <a href="/c/scm-supply-chain-management/1034" class="dropdown-link">SCM - Supply Chain Management</a>
                        <a href="/c/hcm-human-capital-management/2153" class="dropdown-link">HCM - Human Capital Management</a>
                        <a href="/c/plm-product-lifecycle-management/5" class="dropdown-link">PLM - Product Lifecycle</a>
                    </div>
                    <div class="mega-column">
                        <h4>Technology & Analytics</h4>
                        <a href="/c/cloud-platforms/1032" class="dropdown-link">Cloud Platforms</a>
                        <a href="/c/ba-bi-business-analysis-business-intelligence/1031" class="dropdown-link">BA/BI - Business Analytics</a>
                        <a href="/c/mes-manufacturing-execution-system/1033" class="dropdown-link">MES - Manufacturing Execution</a>
                        <a href="/c/qms-quality-management-system/2156" class="dropdown-link">QMS - Quality Management</a>
                        <a href="#" class="dropdown-link">All Hubs</a>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="nav-item has-dropdown">
            <a href="#" class="nav-link" {{on "click" this.toggleDropdown}}>Community</a>
            <div class="dropdown">
                <div class="dropdown-item">
                    <a href="/community-guidelines" class="dropdown-link">Community Guidelines</a>
                </div>
                <div class="dropdown-item">
                    <a href="/code-of-conduct" class="dropdown-link">Code of Conduct</a>
                </div>
                <div class="dropdown-item">
                    <a href="/moderator" class="dropdown-link">Become a Moderator</a>
                </div>
                <div class="dropdown-item">
                    <a href="/roles" class="dropdown-link">Roles & Badges</a>
                </div>
                <div class="dropdown-item">
                    <a href="/roles" class="dropdown-link">Report Content</a>
                </div>
            </div>
        </div>
        
        <div class="nav-item">
            <a href="/tag/jobs" class="nav-link">Jobs</a>
        </div>
        
        <div class="nav-item has-dropdown">
            <a href="#" class="nav-link" {{on "click" this.toggleDropdown}}>Help</a>
            <div class="dropdown">
                <div class="dropdown-item">
                    <a href="/help" class="dropdown-link">Help Center</a>
                </div>
                <div class="dropdown-item">
                    <a href="/faq" class="dropdown-link">FAQ</a>
                </div>
                <div class="dropdown-item">
                    <a href="/support" class="dropdown-link">Contact Support</a>
                </div>
                <div class="dropdown-item">
                    <a href="/c/feedback/179" class="dropdown-link">Submit Feedback</a>
                </div>
            </div>
        </div>
        {{#if this.loggedIn}}
          {{!-- <div class="btn-container">
            <a href="/signup" class="cta-button">Join Community</a>
            <a href="/login" class="cta-button-login">Login</a>
          </div> --}}
        {{/if}}
        <button class="mobile-menu-toggle" {{on "click" this.toggleMobileMenu}}>
            <span></span>
            <span></span>
            <span></span>
        </button>
    </nav>
  </template>
}

export default MainHeader;