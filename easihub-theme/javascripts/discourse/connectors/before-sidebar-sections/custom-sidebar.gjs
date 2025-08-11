import Component from '@glimmer/component';

export default class CustomSidebarComponent extends Component {
  categories = [];

  <template>
    <div id="custom-sidebar" class="w-64 bg-white shadow-md">
      <div class="nbg-gray-100 navigation-cont">

        <!-- Sidebar -->
        <ul class="side-navigation-ul">
          <li class="flex items-center hover:bg-gray-200 cursor-pointer home">
            <a href="/" class="text-gray-8001">
              <i class="fas fa-home fa-icon"></i>
              <span>Home</span>
            </a>
          </li>

          <li class="flex items-center hover:bg-gray-200 cursor-pointer myposts">
            <a id="myposts-link" href="#" class="text-gray-8001">
              <i class="fas fa-clipboard fa-icon"></i>
              <span>My Posts</span>
            </a>
          </li>

          <li class="submenu-toggle more">
            <a href="javascript:void(0);" class="flex items-center hover:bg-gray-200 cursor-pointer">
              <i class="fas fa-ellipsis-h fa-icon"></i>
              <span class="flex-grow text-gray-8001">More</span>
              <i class="fas fa-chevron-down"></i>
            </a>
            <ul class="submenu">
              <li class="flex items-center hover:bg-gray-200 cursor-pointer about">
                <a href="/about-us"><i class="fas fa-info-circle fa-icon"></i><span>About</span></a>
              </li>
              <li class="flex items-center hover:bg-gray-200 cursor-pointer faqs">
                <a href="/faq"><i class="fas fa-question fa-icon"></i><span>FAQs</span></a>
              </li>
              <li class="flex items-center hover:bg-gray-200 cursor-pointer groups">
                <a href="/g"><i class="fas fa-users fa-icon"></i><span>Groups</span></a>
              </li>
              <li class="flex items-center hover:bg-gray-200 cursor-pointer badges">
                <a href="/badges"><i class="fas fa-award fa-icon"></i><span>Badges</span></a>
              </li>
            </ul>
          </li>

          <li class="flex items-center hover:bg-gray-200 cursor-pointer review">
            <a href="https://easihub.com/review" class="text-gray-8001">
              <i class="fas fa-review-circle fa-icon"></i>
              <span>Review</span>
            </a>
          </li>

          <li class="flex items-center hover:bg-gray-200 cursor-pointer admin">
            <a href="https://easihub.com/admin" class="text-gray-8001">
              <i class="fas fa-admin-circle fa-icon"></i><span>Admin</span>
            </a>
          </li>

          <li class="submenu-toggle hub hub-cat-listing">
            <div class="hyperlinke-menu flex items-center hover:bg-gray-200 cursor-pointer">
              <i class="fas fa-network-wired fa-icon"></i>
              <span class="flex-grow text-gray-8001">Hubs</span>
              <i class="fas fa-chevron-down"></i>
            </div>
            <ul class="submenu">
              <!-- ERP Category -->
              <li class="submenu-toggle">
                <div class="hover:bg-gray-200 cursor-pointer">
                  <a href="/c/erp" class="flex-grow text-gray-8001">
                    <span>ERP</span><i class="fas fa-chevron-down"></i>
                  </a>
                </div>
                <ul class="submenu">
                  <li class="flex items-center hover:bg-gray-200 cursor-pointer">
                    <a href="/c/erp/subcat1"><i class="fas fa-sitemap fa-icon"></i> <span> Sub-Category 1 </span></a>
                  </li>
                  <li class="flex items-center hover:bg-gray-200 cursor-pointer">
                    <a href="/c/erp/subcat2"><i class="fas fa-sitemap fa-icon"></i><span>Sub-Category 2</span></a>
                  </li>
                </ul>
              </li>

              <!-- Additional categories... -->
            </ul>
          </li>

          <li class="flex items-center hover:bg-gray-200 cursor-pointer allhubs">
            <a href="/categories" class="text-gray-8001"><span>All Hubs</span></a>
          </li>

          <li class="flex items-center hover:bg-gray-200 cursor-pointer questions">
            <a href="https://easihub.com/tag/questions" class="text-gray-8001">
              <i class="fas fa-question-circle fa-icon"></i>
              <span>Questions</span>
            </a>
          </li>

          <li class="submenu-toggle tags">
            <a href="javascript:void(0);" class="flex items-center hover:bg-gray-200 cursor-pointer">
              <i class="fas fa-tags fa-icon"></i>
              <span class="flex-grow text-gray-8001">Tags</span>
              <i class="fas fa-chevron-down"></i>
            </a>
            <ul class="submenu">
              <li class="flex items-center hover:bg-gray-200 cursor-pointer">
                <i class="fas fa-tag fa-icon"></i><a href="#">Tag 1</a>
              </li>
              <li class="flex items-center hover:bg-gray-200 cursor-pointer">
                <i class="fas fa-tag fa-icon"></i><a href="#">Tag 2</a>
              </li>
            </ul>
          </li>

          <li class="flex items-center hover:bg-gray-200 cursor-pointer all-tags allhubs">
            <a href="/tags" class="text-gray-8001"><span>All Tags</span></a>
          </li>

          <li class="flex items-center hover:bg-gray-200 cursor-pointer drafts">
            <a id="drafts-link" class="text-gray-8001">
              <i class="fas fa-file-alt fa-icon"></i>
              <span>Drafts</span>
            </a>
          </li>

          <li class="flex items-center hover:bg-gray-200 cursor-pointer users">
            <a href="/u" class="text-gray-8001">
              <i class="fas fa-users fa-icon"></i>
              <span>Users</span>
            </a>
          </li>

          <li class="submenu-toggle companies">
            <a href="javascript:void(0);" class="flex items-center hover:bg-gray-200 cursor-pointer">
              <i class="fas fa-building fa-icon"></i>
              <span class="flex-grow text-gray-8001">Companies</span>
              <i class="fas fa-chevron-down"></i>
            </a>
            <ul class="submenu job">
              <li class="flex items-center hover:bg-gray-200 cursor-pointer job">
                <i class="fas fa-briefcase fa-icon"></i>
                <a href="/tag/job">Jobs</a>
              </li>
            </ul>
          </li>

          <li class="submenu-toggle messages">
            <a href="javascript:void(0);" class="flex items-center hover:bg-gray-200 cursor-pointer">
              <i class="fas fa-envelope fa-icon"></i>
              <span class="flex-grow text-gray-8001">Messages</span>
              <i class="fas fa-chevron-down"></i>
            </a>
            <ul class="submenu">
              <li class="flex items-center hover:bg-gray-200 cursor-pointer inbox">
                <i class="fas fa-inbox fa-icon"></i>
                <a href="https://easihub.com/u/easdevub_admin/messages" id="inbox-link">Inbox</a>
              </li>
              <li class="flex items-center hover:bg-gray-200 cursor-pointer new">
                <i class="fas fa-edit fa-icon"></i>
                <a href="https://easihub.com/u/easdevub_admin/messages/new" id="new-link">New</a>
              </li>
              <li class="flex items-center hover:bg-gray-200 cursor-pointer unread">
                <i class="fas fa-envelope-open fa-icon"></i>
                <a href="https://easihub.com/u/easdevub_admin/messages/unread" id="unread-link">Unread</a>
              </li>
              <li class="flex items-center hover:bg-gray-200 cursor-pointer sent">
                <i class="fas fa-paper-plane fa-icon"></i>
                <a href="https://easihub.com/u/easdevub_admin/messages/sent" id="sent-link">Sent</a>
              </li>
              <li class="flex items-center hover:bg-gray-200 cursor-pointer archive">
                <i class="fas fa-archive fa-icon"></i>
                <a href="https://easihub.com/u/easdevub_admin/messages/archive" id="archive-link">Archive</a>
              </li>
            </ul>
          </li>

          <li class="flex items-center hover:bg-gray-200 cursor-pointer discussion">
            <a href="https://easihub.com/tag/discussion" class="text-gray-8001">
              <i class="fas fa-comments fa-icon"></i><span>Discussions</span>
            </a>
          </li>

          <li class="flex items-center hover:bg-gray-200 cursor-pointer articles">
            <a href="https://easihub.com/tag/articles" class="text-gray-8001">
              <i class="fas fa-file-alt fa-icon"></i><span>Articles</span>
            </a>
          </li>

          <li class="flex items-center hover:bg-gray-200 cursor-pointer usercases">
            <a href="https://easihub.com/tag/use-cases" class="text-gray-8001">
              <i class="fas fa-briefcase fa-icon"></i><span>Use Cases</span>
            </a>
          </li>

          <li class="flex items-center hover:bg-gray-200 cursor-pointer events">
            <a href="https://easihub.com/tag/events" class="text-gray-8001">
              <i class="fas fa-calendar-alt fa-icon"></i><span>Events</span>
            </a>
          </li>

          <li class="flex items-center hover:bg-gray-200 cursor-pointer bulletins">
            <a href="https://easihub.com/tag/bulletins" class="text-gray-8001">
              <i class="fas fa-bell fa-icon"></i><span>Bulletins</span>
            </a>
          </li>
        </ul>
      </div>
    </div>
  </template>
}
