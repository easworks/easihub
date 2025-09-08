import Component from '@glimmer/component';

export default class AppFooter extends Component {
  navigationLinks = [
    { href: '/categories', icon: 'fa-solid fa-th-large', text: 'Platform Hubs' },
    { href: '/guidelines', icon: 'fa-solid fa-shield-alt', text: 'Guidelines' },
    { href: '/help', icon: 'fa-solid fa-life-ring', text: 'Help Center' },
    { href: '/moderator', icon: 'fa-solid fa-user-shield', text: 'Become Moderator' },
    { href: '/contact', icon: 'fa-solid fa-headset', text: 'Support' }
  ];

  platformCommunities = [
    {
      category: 'Systems',
      links: [
        { href: 'https://easihub.com/c/erp-enterprise-resource-planning/69', icon: 'fa-solid fa-building', text: 'ERP Systems' },
        { href: 'https://easihub.com/c/crm-customer-relationship-management/14', icon: 'fa-solid fa-handshake', text: 'CRM Solutions' },
        { href: 'https://easihub.com/c/hcm-human-capital-management/2153', icon: 'fa-solid fa-users', text: 'HCM Platforms' },
        { href: 'https://easihub.com/c/scm-supply-chain-management/1034', icon: 'fa-solid fa-truck', text: 'SCM Technologies' },
        { href: 'https://easihub.com/c/plm-product-lifecycle-management/5', icon: 'fa-solid fa-cogs', text: 'PLM Solutions' }
      ]
    },
    {
      category: 'Platforms',
      links: [
        { href: 'https://easihub.com/c/cloud-platforms/1032', icon: 'fa-solid fa-cloud', text: 'Cloud Platforms' },
        { href: 'https://easihub.com/c/ba-bi-business-analysis-business-intelligence/1031', icon: 'fa-solid fa-chart-bar', text: 'Analytics & BI' },
        { href: 'https://easihub.com/c/mes-manufacturing-execution-system/1033', icon: 'fa-solid fa-industry', text: 'MES Systems' },
        { href: 'https://easihub.com/c/qms-quality-management-system/2156', icon: 'fa-solid fa-award', text: 'Quality Management' }
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
    <footer class="community-footer">
        <div class="footer-container">
            
            <!-- Enhanced Community Banner - Aligned with Parent Banner -->
            <div class="community-banner">
                <div class="banner-content">
                    <h3>New to EASiHub Community?</h3>
                    <p>Connect with enterprise application professionals worldwide</p>
                    <p class="brand-note">Community is part of the EASiHub platform ecosystem</p>
                </div>
                <div class="banner-actions">
                    <a href="/join" class="banner-cta secondary">
                        <i class="fas fa-users"></i> Join Community
                    </a>
                    <a href="https://easihub.com" class="banner-cta primary">
                        Visit EASiHub Platform <i class="fas fa-arrow-right"></i>
                    </a>
                </div>
            </div>

            <!-- Footer Grid -->
            <div class="footer-grid">
                <!-- Enhanced Brand + Stats -->
                <div class="footer-section">
                    <div class="brand-header">
                        <div class="brand-logo">E</div>
                        <div class="brand-title">EASiHub Community</div>
                    </div>
                    <p class="brand-tagline">Part of the EASiHub platform ecosystem</p>
                    <p class="brand-description">
                        Join Enterprise Application Software <strong>(EAS)</strong> professionals building the future of business technology.
                        Connect with developers, consultants, and architects sharing real-world solutions in ERP, CRM, HCM, and emerging platforms.
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

                <!-- Popular Platforms -->
                <div class="footer-section">
                    <div class="footer-column">
                        <h4>
                            <i class="fas fa-cube"></i>
                            Popular Platforms
                        </h4>
                        <ul>
                            <li><a href="/platforms/erp"><i class="fas fa-building"></i>ERP Systems</a></li>
                            <li><a href="/platforms/crm"><i class="fas fa-handshake"></i>CRM Platforms</a></li>
                            <li><a href="/platforms/hcm"><i class="fas fa-users"></i>HCM Solutions</a></li>
                            <li><a href="/platforms/plm"><i class="fas fa-cogs"></i>PLM Platforms</a></li>
                            <li><a href="/platforms/analytics"><i class="fas fa-chart-bar"></i>Analytics & BI</a></li>
                            <li><a href="/platforms/supply-chain"><i class="fas fa-truck"></i>Supply Chain</a></li>
                            <li><a href="/platforms"><i class="fas fa-th"></i>View All Platforms</a></li>
                        </ul>
                    </div>
                </div>

                <!-- Community -->
                <div class="footer-section">
                    <div class="footer-column">
                        <h4>
                            <i class="fas fa-users"></i>
                            Community
                        </h4>
                        <ul>
                            <li><a href="/discussions"><i class="fas fa-comments"></i>Recent Discussions</a></li>
                            <li><a href="/join-moderators"><i class="fas fa-user-shield"></i>Join Moderators</a></li>
                            <li><a href="https://easihub.com/community/guidelines"><i class="fas fa-list"></i>Community Guidelines</a></li>
                            <li><a href="https://easihub.com/community/posting-guidelines"><i class="fas fa-edit"></i>Posting Guidelines</a></li>
                            <li><a href="https://easihub.com/community/code-of-conduct"><i class="fas fa-shield-alt"></i>Code of Conduct</a></li>
                            <li><a href="/help"><i class="fas fa-question-circle"></i>Help Center</a></li>
                            <li><a href="/contact-support"><i class="fas fa-headset"></i>Contact Support</a></li>
                            <li><a href="/report-content"><i class="fas fa-flag"></i>Report Content</a></li>
                        </ul>
                    </div>
                </div>

                <!-- EASiHub Platform -->
                <div class="footer-section easihub-platform">
                    <div class="footer-column">
                        <h4>
                            <i class="fas fa-home"></i>
                            EASiHub Platform
                        </h4>
                        <ul>
                            <li><a href="https://easihub.com"><i class="fas fa-home"></i>Main Platform</a></li>
                            <li><a href="https://easihub.com/community"><i class="fas fa-info-circle"></i>About Community</a></li>
                            <li><a href="https://easihub.com/talent"><i class="fas fa-briefcase"></i>EASiHub Talent</a></li>
                            <li><a href="https://easihub.com/academy"><i class="fas fa-graduation-cap"></i>EASiHub Academy</a></li>
                            <li><a href="https://easihub.com/success-stories"><i class="fas fa-star"></i>Success Stories</a></li>
                            <li><a href="https://easihub.com/about"><i class="fas fa-building"></i>About EASiHub</a></li>
                            <li><a href="https://easihub.com/contact"><i class="fas fa-envelope"></i>Contact</a></li>
                            <li><a href="https://easihub.com/blog"><i class="fas fa-newspaper"></i>Blog</a></li>
                        </ul>
                    </div>
                </div>
            </div>

            <!-- Contact Bar -->
            <div class="contact-bar">
                <div class="contact-content">
                    <h4 class="contact-heading">
                        <i class="fas fa-headset"></i>
                        Get In Touch
                    </h4>
                    <div class="contact-items">
                        <div class="contact-item">
                            <i class="fas fa-envelope"></i>
                            <a href="mailto:hello@easihub.com">hello@easihub.com</a>
                        </div>
                        <div class="contact-item">
                            <i class="fas fa-phone"></i>
                            <a href="tel:+1-800-EASIHUB">+1-800-EASIHUB</a>
                        </div>
                        <div class="contact-item">
                            <i class="fas fa-comments"></i>
                            <a href="/live-chat">Live Chat Support</a>
                        </div>
                        <div class="contact-item">
                            <i class="fas fa-clock"></i>
                            <span>Response within 24 hours</span>
                        </div>
                    </div>
                </div>
                <div class="contact-social">
                    <h5>Follow Us</h5>
                    <div class="social-platforms">
                        <a href="https://linkedin.com/company/easihub" aria-label="LinkedIn">
                            <i class="fab fa-linkedin-in"></i>
                        </a>
                        <a href="https://twitter.com/easihub" aria-label="Twitter">
                            <i class="fab fa-twitter"></i>
                        </a>
                        <a href="https://discord.gg/easihub" aria-label="Discord">
                            <i class="fab fa-discord"></i>
                        </a>
                        <a href="https://github.com/easihub" aria-label="GitHub">
                            <i class="fab fa-github"></i>
                        </a>
                    </div>
                </div>
            </div>

            <!-- Footer Bottom -->
            <div class="footer-bottom">
                <div class="footer-bottom-content">
                    <div class="copyright">
                        © 2024 EASiHub - Built for Enterprise Application Software (EAS) Professionals
                    </div>
                    <div class="legal-links">
                        <a href="https://easihub.com/privacy">Privacy Policy</a>
                        <a href="https://easihub.com/terms">Terms of Service</a>
                        <a href="https://easihub.com/community/code-of-conduct">Code of Conduct</a>
                        <a href="https://easihub.com/cookies">Cookie Policy</a>
                    </div>
                </div>
            </div>
        </div>
    </footer>
  </template>
}


