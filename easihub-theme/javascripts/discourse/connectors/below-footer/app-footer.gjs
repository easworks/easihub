import Component from '@glimmer/component';

export default class AppFooter extends Component {
  navigationLinks = [
    { href: '/categories', icon: 'fas fa-th-large', text: 'Platform Hubs' },
    { href: '/guidelines', icon: 'fas fa-shield-alt', text: 'Guidelines' },
    { href: '/help', icon: 'fas fa-life-ring', text: 'Help Center' },
    { href: '/moderator', icon: 'fas fa-user-shield', text: 'Become Moderator' },
    { href: '/contact', icon: 'fas fa-headset', text: 'Support' }
  ];

  platformCommunities = [
    {
      category: 'Systems',
      links: [
        { href: 'https://easihub.com/c/erp-enterprise-resource-planning/69', icon: 'fas fa-building', text: 'ERP Systems' },
        { href: 'https://easihub.com/c/crm-customer-relationship-management/14', icon: 'fas fa-handshake', text: 'CRM Solutions' },
        { href: 'https://easihub.com/c/hcm-human-capital-management/2153', icon: 'fas fa-users', text: 'HCM Platforms' },
        { href: 'https://easihub.com/c/scm-supply-chain-management/1034', icon: 'fas fa-truck', text: 'SCM Technologies' },
        { href: 'https://easihub.com/c/plm-product-lifecycle-management/5', icon: 'fas fa-cogs', text: 'PLM Solutions' }
      ]
    },
    {
      category: 'Platforms',
      links: [
        { href: 'https://easihub.com/c/cloud-platforms/1032', icon: 'fas fa-cloud', text: 'Cloud Platforms' },
        { href: 'https://easihub.com/c/ba-bi-business-analysis-business-intelligence/1031', icon: 'fas fa-chart-bar', text: 'Analytics & BI' },
        { href: 'https://easihub.com/c/mes-manufacturing-execution-system/1033', icon: 'fas fa-industry', text: 'MES Systems' },
        { href: 'https://easihub.com/c/qms-quality-management-system/2156', icon: 'fas fa-award', text: 'Quality Management' }
      ]
    }
  ];

  socialLinks = [
    { href: 'https://facebook.com/EASIHUB', icon: 'fab fa-facebook-f', label: 'Facebook' },
    { href: 'https://linkedin.com/company/EASIHUB', icon: 'fab fa-linkedin-in', label: 'LinkedIn' },
    { href: 'https://twitter.com/EASIHUB', icon: 'fab fa-twitter', label: 'Twitter' },
    { href: 'https://github.com/EASIHUB', icon: 'fab fa-github', label: 'GitHub' }
  ];

  policyLinks = [
    { href: '/privacy-policy', text: 'Privacy Policy' },
    { href: '/terms-of-use', text: 'Terms of Service' },
    { href: '/code-of-conduct', text: 'Code of Conduct' },
    { href: '/cookies', text: 'Cookie Policy' }
  ];

  <template>
    <footer class="app-footer">
      <div class="footer-container">
        <div class="main-footer">

          <!-- Main Footer Grid -->
          <div class="footer-grid">

            <!-- About EASIHUB -->
            <div class="footer-about footer-section">
              <h3><i class="fas fa-cube"></i> EASIHUB</h3>
              <p>The premier platform connecting enterprise application professionals—developers, consultants, architects, and business analysts. Collaborate, innovate, and advance your expertise in ERP, CRM, PLM, BI, and cutting-edge enterprise technologies.</p>
            </div>

            <!-- Navigation Links -->
            <div class="footer-navi footer-section">
              <h4><i class="fas fa-compass"></i> Navigation</h4>
              <ul>
                {{#each this.navigationLinks as |link|}}
                  <li>
                    <a href={{link.href}}>
                      <i class={{link.icon}}></i> {{link.text}}
                    </a>
                  </li>
                {{/each}}
              </ul>
            </div>

            <!-- Platform Communities -->
            <div class="footer-communities footer-section">
              <h4><i class="fas fa-network-wired"></i> Platform Communities</h4>
              <div class="communities-grid">
                {{#each this.platformCommunities as |category|}}
                  <ul>
                    {{#each category.links as |link|}}
                      <li>
                        <a href={{link.href}}>
                          <i class={{link.icon}}></i> {{link.text}}
                        </a>
                      </li>
                    {{/each}}
                  </ul>
                {{/each}}
              </div>
            </div>

            <!-- Connect & Support -->
            <div class="footer-connect footer-section">
              <h4><i class="fas fa-globe"></i> Connect & Support</h4>
              <div class="social-platforms">
                {{#each this.socialLinks as |social|}}
                  <a href={{social.href}} target="_blank" aria-label={{social.label}}>
                    <i class={{social.icon}}></i>
                  </a>
                {{/each}}
              </div>
              <div class="support-info">
                <h5>24/7 Support Available</h5>
                <p>Get help from our community experts and support team. <a href="/support">Contact Support</a></p>
              </div>
            </div>

          </div>

          <!-- Code of Conduct -->
          <div class="code-conduct">
            <h4><i class="fas fa-balance-scale"></i> Community Standards</h4>
            <p>We're committed to maintaining a professional, inclusive environment for all enterprise application professionals. Please review our <a href="/code-of-conduct">Community Guidelines</a> and <a href="/terms">Terms of Service</a> to ensure the best experience for everyone.</p>
          </div>

        </div>

        <!-- Footer Bottom -->
        <div class="footer-bottom">
          <div class="footer-bottom-content">
            <p>&copy; 2024 EASIHUB – Built for Enterprise Application Software (EAS) Professionals.</p>
            <div class="policy-links">
              {{#each this.policyLinks as |policy|}}
                <a href={{policy.href}}>{{policy.text}}</a>
              {{/each}}
            </div>
          </div>
        </div>

      </div>
    </footer>
  </template>
}


