import Component from '@glimmer/component';


export default class AppFooter extends Component {

  // Dynamic year
  get currentYear() {
    return new Date().getFullYear();
  }  


  communityLinks = [
    { text: "Explore", link: "/community", icon: "fas fa-rocket", primary: true },
    { text: "Discussions", link: "/community/discussions", icon: "fas fa-comments" },
    { text: "Experts", link: "/community/experts", icon: "fas fa-crown" },
    { text: "Stories", link: "/community/success-stories", icon: "fas fa-trophy" }
  ];

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

  platformLinks = [
    { text: "Join Community", link: "/community", icon: "fas fa-users", primary: true },
    { text: "Browse Experts", link: "/experts", icon: "fas fa-user-tie" },
    { text: "Success Stories", link: "/stories", icon: "fas fa-trophy" },
    { text: "Become Expert", link: "/experts/become", icon: "fas fa-star" },
    { text: "EASiHub Talent", link: "/talent", icon: "fas fa-briefcase", primary: true },
    { text: "Platform Features", link: "/features", icon: "fas fa-wand-magic-sparkles" }
  ];

  companyLinks = [
    { text: "About EASiHub", link: "/about", icon: "fas fa-info-circle" },
    { text: "Careers", link: "/careers", icon: "fas fa-handshake" },
    { text: "Press Kit", link: "/press", icon: "fas fa-newspaper" },
    { text: "Contact", link: "/contact", icon: "fas fa-envelope" }
  ];

  resourcesLinks = [
    { text: "Help Center", link: "/help", icon: "fas fa-life-ring" },
    { text: "Blog", link: "/blog", icon: "fas fa-newspaper" },
    { text: "Community Guidelines", link: "/community/guidelines", icon: "fas fa-list" },
    { text: "Posting Guidelines", link: "/community/posting-guidelines", icon: "fas fa-pen-to-square" },
    { text: "Code of Conduct", link: "/community/code-of-conduct", icon: "fas fa-shield" },
    { text: "Start Exploring", link: "/community", icon: "fas fa-compass" }
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
        <div class="community-quicklinks-bar">
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
        </div>

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

                <div class="social-links">
                    {{#each this.socialLinks as |social|}}
                    <a href={{social.href}} aria-label={{social.label}}>
                        <i class={{social.icon}}></i>
                    </a>
                    {{/each}}
                </div>
            </div>

            <!-- Platform Section -->
            <div class="footer-menu surface glass">
            <div class="footer-column">
                <h4>
                <i class="fas fa-cube text-slate-300"></i>
                Platform
                </h4>
                <ul>
                {{#each this.platformLinks as |link|}}
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
                Company
                </h4>
                <ul>
                {{#each this.companyLinks as |link|}}
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

            <!-- Resources Section -->
            <div class="footer-menu surface glass">
            <div class="footer-column">
                <h4>
                <i class="fas fa-book text-slate-300"></i>
                Resources
                </h4>
                <ul>
                {{#each this.resourcesLinks as |link|}}
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


