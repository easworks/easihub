import Component from '@glimmer/component';


export default class AppFooter extends Component {

  // Dynamic year
  get currentYear() {
    return new Date().getFullYear();
  }  

  socialLinks = [
    {
      href: "https://linkedin.com/company/easihub",
      icon: "fab fa-linkedin-in",
      label: "LinkedIn"
    },
    { href: "https://twitter.com/easihub", icon: "fab fa-twitter", label: "Twitter" },
    { href: "https://github.com/easihub", icon: "fab fa-github", label: "GitHub" },
    { href: "mailto:hello@easihub.com", icon: "fas fa-envelope", label: "Email" }
  ];

  popularLinks = [
    { text: "ERP Systems", link: "/c/erp-enterprise-resource-planning/69", icon: "fas fa-building", primary: true },
    { text: "CRM Platforms", link: "/c/crm-customer-relationship-management/14", icon: "fas fa-users" },
    { text: "HCM Solutions", link: "/c/hcm-human-capital-management/2153", icon: "fas fa-user-group" },
    { text: "PLM Platforms", link: "/c/plm-product-lifecycle-management/5", icon: "fas fa-cube" },
    { text: "Analytics & BI", link: "/c/ba-bi-business-analysis-business-intelligence/1031", icon: "fas fa-chart-line", primary: true },
    { text: "Supply Chain", link: "/c/scm-supply-chain-management/1034", icon: "fas fa-truck" },
    { text: "View All Platforms", link: "/features", icon: "fas fa-th-large" },
  ];

  communityLinks = [
    { text: "Recent Discussions", link: "/discussions", icon: "fas fa-comments" },
    { text: "Join Moderators", link: "/moderators", icon: "fas fa-handshake" },
    { text: "Community Guidelines", link: "/guidelines", icon: "fas fa-list" },
    { text: "Posting Guidelines", link: "/posting", icon: "fas fa-pen-to-square" },
    { text: "Code of Conduct", link: "/code-of-conduct", icon: "fas fa-shield" },
    { text: "Help Center", link: "/help", icon: "fas fa-life-ring" },
    { text: "Contact Support", link: "/contact", icon: "fas fa-headset" },
    { text: "Report Content", link: "/report", icon: "fas fa-flag" },
  ];

  platformLinks = [
    { text: "Main Platform", link: "https://www.development.branches.easihub.com/", icon: "fas fa-globe" },
    { text: "About Community", link: "/about", icon: "fas fa-users" },
    { text: "EASiHub Talent", link: "/talent", icon: "fas fa-user-tie" },
    { text: "EASiHub Academy", link: "/academy", icon: "fas fa-graduation-cap" },
    { text: "Success Stories", link: "/success", icon: "fas fa-star" },
    { text: "About EASiHub", link: "/easihub/help", icon: "fas fa-info-circle" },
    { text: "Contact", link: "/contact", icon: "fas fa-envelope" },
    { text: "Blog", link: "/blog", icon: "fas fa-blog" },
  ];

  contactItems = [
    { href: "mailto:hello@easihub.com", icon: "fas fa-envelope text-slate-300", text: "hello@easihub.com" },
    { href: "tel:+1-800-EASIHUB", icon: "fas fa-phone text-slate-300", text: "+1-800-EASIHUB" },
    { href: "/chat", icon: "fas fa-comments text-slate-300", text: "Live Chat" }
  ];

  socialPlatforms = [
    { href: "https://linkedin.com/company/easihub", icon: "fab fa-linkedin-in", label: "LinkedIn" },
    { href: "https://twitter.com/easihub", icon: "fab fa-twitter", label: "Twitter" },
    { href: "https://discord.gg/easihub", icon: "fab fa-discord", label: "Discord" },
    { href: "https://github.com/easihub", icon: "fab fa-github", label: "GitHub" }
  ];

  <template>
    <div class="page-container">

        <!-- Welcome Banner -->
        <div class="welcome-banner-footer">
            <div class="banner-content">
            <h3>New to EASiHub?</h3>
            <p>The premier platform connecting enterprise application professionals worldwide</p>
            </div>
            <div class="banner-actions">
            <a href="/community" class="banner-cta secondary">
                <i class="fas fa-users"></i>
                Join Community
            </a>
            <a href="/get-started" class="banner-cta primary">
                Get Started <i class="fas fa-arrow-right"></i>
            </a>
            </div>
        </div>

        <!-- Community Quick-Links Bar -->
        {{!-- <div class="community-quicklinks-bar">
            <div class="community-bar-header">
            <h5>
                <i class="fas fa-users"></i>
                Community
            </h5>
            </div>
            <div class="community-links">
            {{#each this.communityLinks as |link|}}
                <a
                href={{link.link}}
                class="community-link {{if link.primary "primary"}}"
                >
                <i class={{link.icon}}></i>
                {{link.text}}
                </a>
            {{/each}}
            </div>
        </div> --}}

        <!-- Main Footer Grid -->
        <div class="footer-grid">

            <!-- Brand Section -->
            <div class="brand-section surface glass">
                <div class="brand-header">
                    <div class="brand-logo">E</div>
                    <div class="brand-title">EASiHub</div>
                </div>
                <p class="brand-tagline">The enterprise application platform ecosystem</p>
                <p class="brand-description">
                    Where enterprise application expertise meets opportunity. Connect with the professionals shaping how business gets done—from implementation to innovation across <strong>the world's most critical business systems.</strong>
                </p>

                <div class="stats-panels">
                    <div class="stat-panel">
                        <span class="stat-number">50K+</span>
                        <span class="stat-label">Members</span>
                    </div>
                    <div class="stat-panel">
                        <span class="stat-number">1K+</span>
                        <span class="stat-label">Daily Posts</span>
                    </div>
                    <div class="stat-panel">
                        <span class="stat-number">120+</span>
                        <span class="stat-label">Countries</span>
                    </div>
                    <div class="stat-panel">
                        <span class="stat-number">98%</span>
                        <span class="stat-label">Solved</span>
                    </div>
                </div>
            </div>

            <!-- Platform Section -->
            <div class="footer-menu surface glass">
            <div class="footer-column">
                <h4>
                <i class="fas fa-cube text-slate-300"></i>
                Popular Platform
                </h4>
                <ul>
                {{#each this.popularLinks as |link|}}
                    <li>
                    <a href={{link.link}} class="{{if link.primary "primary"}}">
                        <i class={{link.icon}}></i>
                        {{link.text}}
                    </a>
                    </li>
                {{/each}}
                </ul>
            </div>
            </div>

            <!-- Company Section -->
            <div class="footer-menu surface glass">
            <div class="footer-column">
                <h4>
                <i class="fas fa-building text-slate-300"></i>
                Community
                </h4>
                <ul>
                {{#each this.communityLinks as |link|}}
                    <li>
                    <a href={{link.link}}>
                        <i class={{link.icon}}></i>
                        {{link.text}}
                    </a>
                    </li>
                {{/each}}
                </ul>
            </div>
            </div>

            <!-- Easihub Platform Section -->
            <div class="footer-menu surface glass">
            <div class="footer-column">
                <h4 class="easihub-block">
                    <i class="fas fa-book text-slate-300"></i>
                    EASiHub Platform
                </h4>
                <ul>
                {{#each this.platformLinks as |link|}}
                    <li>
                    <a href={{link.link}}>
                        <i class={{link.icon}}></i>
                        {{link.text}}
                    </a>
                    </li>
                {{/each}}
                </ul>
            </div>
            </div>

        </div>

        <!-- Contact Bar -->
        <div class="contact-bar">
            <div class="contact-content">
            <h4 class="contact-heading">
                <i class="fas fa-headset text-primary-400"></i>
                Get In Touch
            </h4>
            <div class="contact-items">
                {{#each this.contactItems as |contact|}}
                <div class="contact-item">
                    <i class={{contact.icon}}></i>
                    <a href={{contact.href}}>{{contact.text}}</a>
                </div>
                {{/each}}
            </div>
            </div>
            <div class="contact-social">
            <h5>Follow Us</h5>
            <div class="social-platforms">
                {{#each this.socialPlatforms as |social|}}
                <a href={{social.href}} aria-label={{social.label}}>
                    <i class={{social.icon}}></i>
                </a>
                {{/each}}
            </div>
            </div>
        </div>

        <!-- Footer Bottom -->
        <div class="footer-bottom">
            <div class="copyright">
            © {{this.currentYear}} EASiHub <br>
            Built for Enterprise Application Software (EAS) Professionals
            </div>
            <div class="legal-links">
            <a href="/privacy">Privacy Policy</a>
            <a href="/terms">Terms of Service</a>
            <a href="/conduct">Code of Conduct</a>
            <a href="/cookies">Cookie Policy</a>
            </div>
        </div>
        </div>

  </template>
}


