import Component from '@glimmer/component';
import PluginOutlet from 'discourse/components/plugin-outlet';
import lazyHash from 'discourse/helpers/lazy-hash';
import { service } from '@ember/service';
import hideApplicationSidebar from "discourse/helpers/hide-application-sidebar";
import CategoriesBoxes from 'discourse/components/categories-boxes';
import Category from 'discourse/models/category';
import { LinkTo } from '@ember/routing';
import bodyClass from 'discourse/helpers/body-class';
import HappeningNow from '../../../../components/happening-now';



export class AnonymousHomepage extends Component {

  get categories() {
    const list = Category.list()
      .filter(c => c.isOfType('hub', 'domain') && c.featured);
    return list;
  }

  <template>
    {{bodyClass "home-anonymous-page"}}
    {{hideApplicationSidebar}}
    <div class="main-container">
      <section class="hero-wrap">
        <div class="container-wrap">
          <div class="hero-content-home">
            <div class="hero-text">
              <div class="hero-badge">
                Enterprise Application Software (EAS) Community
              </div>
              <h1>
                Ask Questions, Share Solutions, Connect with
                <span class="highlight-eas">EAS</span>
                <span class="highlight">Professionals</span>
              </h1>

              <!-- Animated Domain Text -->
              <div class="animated-domains">
                <div class="domain-prefix">Get expert help with</div>
                <div class="domain-container">
                  <div class="domain-slider">
                    <div class="domain-text">SAP S/4HANA implementations</div>
                    <div class="domain-text">Oracle Cloud ERP migrations</div>
                    <div class="domain-text">
                      Salesforce Lightning customizations
                    </div>
                    <div class="domain-text">Workday HCM configurations</div>
                    <div class="domain-text">Teamcenter PLM workflows</div>
                  </div>
                </div>
              </div>

              <ul class="sr-only domain-topics-fallback">
                <li>SAP S/4HANA implementations</li>
                <li>Oracle Cloud ERP migrations</li>
                <li>Salesforce Lightning customizations</li>
                <li>Workday HCM configurations</li>
                <li>Teamcenter PLM workflows</li>
                <li>Microsoft Dynamics integrations</li>
                <li>ServiceNow ITSM setups</li>
                <li>Tableau dashboard optimizations</li>
              </ul>

              <p class="hero-subtitle-anon">
                Practical, vendor-neutral answers for enterprise apps. Get help
                from practitioners working with SAP, Oracle, Salesforce, Workday,
                PLM, Cloud & BI—every day.
              </p>

              <div class="hero-stats">
                <div class="stat-item">
                  <span class="stat-number">150+</span>
                  <span class="stat-label">Active Members</span>
                </div>
                <div class="stat-item">
                  <span class="stat-number">500+</span>
                  <span class="stat-label">Marked Solved</span>
                </div>
                <div class="stat-item">
                  <span class="stat-number">&lt; 4hr</span>
                  <span class="stat-label">Median Response</span>
                </div>
              </div>

              <div class="hero-actions">
                <LinkTo @route="tag.show" @model={{'questions'}} class="btn-hero btn-primary">
                  <i class="fas fa-question-circle"></i> Ask a Question
                </LinkTo>
                <LinkTo @route="tag.show" @model={{'discussions'}} class="btn-hero btn-secondary">
                  <i class="fas fa-comments"></i> Browse Discussions
                </LinkTo>
                <LinkTo @route="tag.show" @model={{'jobs'}} class="btn-hero btn-tertiary">
                  <i class="fas fa-briefcase"></i> View EA Jobs
                </LinkTo>
              </div>

              <div class="quick-guidelines">
                <i class="fas fa-lightbulb"></i>
                <span
                  >Pro tip: Include version, module & code for faster expert
                  answers</span
                >
                <a href="/posting-guidelines">→ Posting Guidelines</a>
              </div>

              <!-- Trust Indicators -->
              <div class="trust-indicators">
                <p>Trusted by professionals from</p>
                <div class="trust-badges">
                  <span class="trust-badge">Fortune 500</span>
                  <span class="trust-badge">System Integrators</span>
                  <span class="trust-badge">Consulting Firms</span>
                  <span class="trust-badge">ISV Partners</span>
                </div>
              </div>
            </div>

            <div class="activity-preview">
              <div class="activity-header">
                <div class="live-indicator"></div>
                <h3 class="activity-title">Happening Now</h3>
              </div>
              <HappeningNow />
              <div style="text-align: center; margin-top: 16px">
                <a
                  href="/live"
                  style="
                    color: var(--primary-blue);
                    font-size: 13px;
                    text-decoration: none;
                    font-weight: 500;
                  "
                  >View All Live Discussions →</a
                >
              </div>
            </div>
          </div>
        </div>
      </section>

      <!-- Why Choose Section -->
      <section class="section why-choose">
        <div class="container-wrap">
          <div class="section-header">
            <h2 class="section-title">Why choose EASiHub Community</h2>
            <p class="section-subtitle">
              Fast, vendor-neutral help for enterprise applications – built by
              practitioners, moderated for signal.
            </p>
          </div>
          <div class="start-grid">
            <div class="start-card">
              <div class="start-icon">
                <i class="fas fa-bullseye"></i>
              </div>
              <h3 class="start-title">Targeted Enterprise Q&A</h3>
              <p class="start-description">
                Get domain-specific answers for SAP, Oracle, Salesforce, Workday,
                PLM, Cloud & BI – not generic advice.
              </p>
            </div>
            <div class="start-card">
              <div class="start-icon">
                <i class="fas fa-clipboard-check"></i>
              </div>
              <h3 class="start-title">Expert-Verified Playbooks</h3>
              <p class="start-description">
                Vendor-neutral patterns, reference architectures, and code
                snippets (ABAP, Apex, JS) you can reproduce.
              </p>
            </div>
            <div class="start-card">
              <div class="start-icon">
                <i class="fas fa-shield-alt"></i>
              </div>
              <h3 class="start-title">High-Signal & Moderated</h3>
              <p class="start-description">
                No spam or vendor pitches. Clear tagging & active moderation keep
                threads professional and useful.
              </p>
            </div>
          </div>
        </div>
      </section>

      <!-- How Community Works -->
      <section class="section how-it-works">
        <div class="container-wrap">
          <div class="section-header">
            <h2 class="section-title">How Community Discussions Work</h2>
            <p class="section-subtitle">
              Tailored for enterprise apps – vendor-neutral, reproducible answers
              in 3 steps.
            </p>
          </div>
          <div class="how-it-works-grid">
            <div class="step-card">
              <div class="step-number">1</div>
              <h3 class="step-title">Post your question</h3>
              <p class="step-description">
                Include version, module, logs/code, and tags (e.g., sap-s4hana,
                oracle-fusion-erp, salesforce-apex, teamcenter).
              </p>
              <div class="step-example">
                Use stack tags so experts find you faster
              </div>
            </div>
            <div class="step-card">
              <div class="step-number">2</div>
              <h3 class="step-title">Get expert responses</h3>
              <p class="step-description">
                Architects and consultants share fixes, patterns, and references
                that others can reproduce.
              </p>
              <div class="step-example">
                Expect vendor‑neutral, reproducible guidance
              </div>
            </div>
            <div class="step-card">
              <div class="step-number">3</div>
              <h3 class="step-title">Mark as solved & share context</h3>
              <p class="step-description">
                Confirm what worked and add your notes so the next team ships
                faster.
              </p>
              <div class="step-example">Your solution helps the next project</div>
            </div>
          </div>
        </div>
      </section>

      <!-- Active Discussion Topics -->
      <section class="section domains">
        <div class="container-wrap">
          <div class="section-header">
            <h2 class="section-title">Trending Domains & Tags</h2>
            <p class="section-subtitle">
              Real topics from the community – updated continuously.
            </p>
          </div>
          <div id="list-area">
            <CategoriesBoxes @categories={{this.categories}} class="mb-8"/>
          </div>
          <div style="text-align: center; margin-top: 32px">
            <a class="btn btn-primary" href="/signup"
              >View All Discussion Topics</a
            >
          </div>
        </div>
      </section>

      <!-- Community Guidelines -->
      <section class="section">
        <div class="container-wrap">
          <div class="guidelines-content">
            <div>
              <h2
                class="section-title"
                style="text-align: left; margin-bottom: 16px"
              >
                Quality Community Standards
              </h2>
              <p
                style="
                  font-size: 15px;
                  color: var(--gray-600);
                  margin-bottom: 24px;
                  line-height: 1.5;
                "
              >
                Professional, moderated, and vendor-neutral – so signals stay
                high.
              </p>
              <div class="guidelines-list">
                <div class="guideline-item">
                  <i class="fas fa-check-circle guideline-icon"></i>
                  <span class="guideline-text"
                    >Implementation-focused questions (versions, modules, repro
                    steps)</span
                  >
                </div>
                <div class="guideline-item">
                  <i class="fas fa-check-circle guideline-icon"></i>
                  <span class="guideline-text">No spam or vendor pitches</span>
                </div>
                <div class="guideline-item">
                  <i class="fas fa-check-circle guideline-icon"></i>
                  <span class="guideline-text"
                    >Cite docs/code; be respectful; no confidential data</span
                  >
                </div>
                <div class="guideline-item">
                  <i class="fas fa-check-circle guideline-icon"></i>
                  <span class="guideline-text"
                    >Moderator-enforced guidelines & tagging</span
                  >
                </div>
              </div>
              <div style="margin-top: 24px">
                <a class="btn btn-secondary" href="/guidelines"
                  >Read Full Community Guidelines</a
                >
              </div>
            </div>
            <div class="quality-metrics">
              <h3 class="metrics-title">Community Quality Metrics</h3>
              <div class="metrics-grid">
                <div class="metric-card">
                  <div class="metric-value">85%</div>
                  <div class="metric-label">Questions Solved</div>
                </div>
                <div class="metric-card">
                  <div class="metric-value">4.8/5</div>
                  <div class="metric-label">Answer Quality</div>
                </div>
                <div class="metric-card">
                  <div class="metric-value">&lt; 4hr</div>
                  <div class="metric-label">Response Time</div>
                </div>
                <div class="metric-card">
                  <div class="metric-value">98%</div>
                  <div class="metric-label">Professional Posts</div>
                </div>
              </div>
              <div class="zero-tolerance">
                <div class="tolerance-title">Zero Tolerance Policy</div>
                <div class="tolerance-description">
                  Spam, vendor pitches, and off-topic content removed immediately
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>

      <!-- Final CTA -->
      <section class="final-cta">
        <div class="container-wrap">
          <h2 class="cta-title">Ready to Join the Discussion?</h2>
          <p class="cta-subtitle">
            Ask now—most questions get answered in hours.
          </p>
          <div class="cta-actions">
            <a class="btn btn-white" href="/signup">Create Free Account</a>
            <a class="btn btn-outline" href="/discussions"
              >Explore Live Discussions</a
            >
          </div>
          <p class="cta-disclaimer">
            No spam. No vendor pitches. Just professional knowledge sharing.
          </p>
        </div>
      </section>
    </div>
  </template>
}