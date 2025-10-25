import RouteTemplate from "ember-route-template";
import hideApplicationSidebar from "discourse/helpers/hide-application-sidebar";

export default RouteTemplate(
  
  <template>
    {{hideApplicationSidebar}}
    <div class="header-section">
      <h1>EASIHUB Help Center</h1>
      <p>Find everything you need to navigate, post, and participate in the EASIHUB Community.</p>
    </div>

    <div class="container">

      <div class="group-title">Getting Started</div>
      <div class="grid-row">
        <a class="card" href='/getting-started'><div><div class="card-title"><i class="fas fa-user-plus"></i> Getting Started with EASIHUB</div><div class="card-description">How to register, log in, customize your profile, and set up preferences for using EASIHUB.</div></div><i class="fas fa-share-alt share-icon"></i></a>
        <a class="card" href='/getting-started'><div><div class="card-title"><i class="fas fa-id-card"></i> Registration Options</div><div class="card-description">Explore account types and social login methods like Google, GitHub, and LinkedIn.</div></div><i class="fas fa-share-alt share-icon"></i></a>
      </div>



      <div class="group-title">Platform Navigation</div>
      <div class="grid-row">
        <a class="card" href='/platform-navigation'><div><div class="card-title"><i class="fas fa-sitemap"></i> Domains vs Software Hubs</div><div class="card-description">Understand the relationship between Enterprise Domains, Software Hubs, and Technical Areas within EASIHUB.</div></div><i class="fas fa-share-alt share-icon"></i></a>
        <a class="card" href='/platform-navigation'><div><div class="card-title"><i class="fas fa-newspaper"></i> Exploring Articles, Bulletins, Events, Jobs</div><div class="card-description">Find curated knowledge articles, updates, upcoming events, job listings, and important bulletins.</div></div><i class="fas fa-share-alt share-icon"></i></a>
      </div>

      <div class="group-title">Posting Content</div>
      <div class="grid-row">
        <a class="card" href='/posting-content'><div><div class="card-title"><i class="fas fa-question-circle"></i> Posting Questions</div><div class="card-description">Guidelines for asking technical, general, and implementation-focused questions effectively.</div></div><i class="fas fa-share-alt share-icon"></i></a>
        <a class="card" href='/posting-content'><div><div class="card-title"><i class="fas fa-comments"></i> Starting Discussions</div><div class="card-description">How to engage in open discussions about challenges and solutions.</div></div><i class="fas fa-share-alt share-icon"></i></a>
        <a class="card" href='/posting-content'><div><div class="card-title"><i class="fas fa-lightbulb"></i> Sharing Use Cases</div><div class="card-description">Share real-world project experiences and enterprise software solutions.</div></div><i class="fas fa-share-alt share-icon"></i></a>
      </div>

      <div class="group-title">Optimizing Participation</div>
      <div class="grid-row">
        <a class="card" href='/optimizing-participation'><div><div class="card-title"><i class="fas fa-tags"></i> Using Tags Effectively</div><div class="card-description">How to tag posts properly for better visibility and searchability.</div></div><i class="fas fa-share-alt share-icon"></i></a>
        <a class="card" href='/optimizing-participation'><div><div class="card-title"><i class="fas fa-star"></i> Content Quality Tips</div><div class="card-description">Tips to improve your contributions by writing structured, helpful content.</div></div><i class="fas fa-share-alt share-icon"></i></a>
        <a class="card" href='/optimizing-participation'><div><div class="card-title"><i class="fas fa-edit"></i> Managing Your Content</div><div class="card-description">Learn how to edit, delete, or bookmark your posts easily.</div></div><i class="fas fa-share-alt share-icon"></i></a>
      </div>

      <div class="group-title">Notifications & Following</div>
      <div class="grid-row">
        <a class="card" href='/notification'><div><div class="card-title"><i class="fas fa-bell"></i> Notification Settings and Following Topics/Tags</div><div class="card-description">Customize notifications and stay updated on relevant discussions and updates.</div></div><i class="fas fa-share-alt share-icon"></i></a>
      </div>

      <div class="group-title">Community Engagement</div>
      <div class="grid-row">
        <a class="card" href='/community'><div><div class="card-title"><i class="fas fa-thumbs-up"></i> Voting, Likes, and Reputation Building</div><div class="card-description">How engagement builds your reputation and credibility within the community.</div></div><i class="fas fa-share-alt share-icon"></i></a>
        <a class="card" href='/community'><div><div class="card-title"><i class="fas fa-award"></i> Badge System and Recognition</div><div class="card-description">Earn badges and recognition through active and quality contributions.</div></div><i class="fas fa-share-alt share-icon"></i></a>
        <a class="card" href='/community'><div><div class="card-title"><i class="fas fa-level-up-alt"></i> Understanding Trust Levels</div><div class="card-description">Learn how trust levels work and what new privileges they unlock.</div></div><i class="fas fa-share-alt share-icon"></i></a>
      </div>

      <div class="group-title">User Roles & Conduct</div>
      <div class="grid-row">
        <a class="card" href='/user-roles'><div><div class="card-title"><i class="fas fa-user-shield"></i> Roles and Privileges</div><div class="card-description">Understand different user roles and responsibilities within the platform.</div></div><i class="fas fa-share-alt share-icon"></i></a>
        <a class="card" href='/user-roles'><div><div class="card-title"><i class="fas fa-balance-scale"></i> Community Guidelines</div><div class="card-description">Expected behavior, prohibited activities, and EASIHUB standards of conduct.</div></div><i class="fas fa-share-alt share-icon"></i></a>
        <a class="card" href='/user-roles'><div><div class="card-title"><i class="fas fa-user-check"></i> Moderation and Reporting Issues</div><div class="card-description">How moderators maintain fairness and how you can report concerns.</div></div><i class="fas fa-share-alt share-icon"></i></a>
      </div>

      <div class="group-title">Privacy and Policies</div>
      <div class="grid-row">
        <a class="card" href='/privacy'><div><div class="card-title"><i class="fas fa-lock"></i> Intellectual Property, Trademarks, and Confidentiality</div><div class="card-description">Guidelines to protect sensitive information and respect trademarks.</div></div><i class="fas fa-share-alt share-icon"></i></a>
        <a class="card" href='/privacy'><div><div class="card-title"><i class="fas fa-user-secret"></i> Privacy and Data Security</div><div class="card-description">Understand how EASIHUB protects your personal data and privacy rights.</div></div><i class="fas fa-share-alt share-icon"></i></a>
      </div>

      <div class="group-title">Support & Contribution</div>
      <div class="grid-row">
        <a class="card" href='/support'><div><div class="card-title"><i class="fas fa-hands-helping"></i> Help and Support Channels</div><div class="card-description">Where to find FAQs, get help, and submit platform feedback.</div></div><i class="fas fa-share-alt share-icon"></i></a>
        <a class="card" href='/support'><div><div class="card-title"><i class="fas fa-briefcase"></i> Posting Jobs and Recruitment Events</div><div class="card-description">Guidelines for companies posting job openings and hosting events.</div></div><i class="fas fa-share-alt share-icon"></i></a>
        <a class="card" href='/support'><div><div class="card-title"><i class="fas fa-road"></i> Platform Roadmap and Contributing Suggestions</div><div class="card-description">How to suggest improvements and stay informed about platform growth.</div></div><i class="fas fa-share-alt share-icon"></i></a>
      </div>

      <div class="group-title">About EASIHUB</div>
      <div class="grid-row">
        <a class="card" href='/about-easihub'><div><div class="card-title"><i class="fas fa-bullseye"></i> About EASIHUB (Mission, Vision, Focus Areas)</div><div class="card-description">Learn more about EASIHUB's core mission, vision, and enterprise focus areas.</div></div><i class="fas fa-share-alt share-icon"></i></a>
      </div>

    </div>

  </template>
);