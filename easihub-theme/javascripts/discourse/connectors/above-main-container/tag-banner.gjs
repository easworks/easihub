import Component from '@glimmer/component';
import { service } from '@ember/service';
import { tracked } from '@glimmer/tracking';
import { action } from '@ember/object';
import { schedule, later } from '@ember/runloop';

export class TagBanner extends Component {
  @service router;

  @tracked catName;

  constructor() {
    super(...arguments);
    this.setupBanner();
    this.router.on('routeDidChange', () => {
      this.setupBanner();
    });
  }

  setupBanner() {
    schedule('afterRender', () => {
      this.retrySetup(0);
    });
  }

  retrySetup(attempt) {
    if (attempt > 10) return; // Max 10 attempts
    
    const tagTitleHeader = document.querySelector('.tag-title-header');
    const tagBannerText = document.querySelector('.tag-title-contents h1');
    
    if (tagTitleHeader && tagBannerText && this.isTagPage) {
      this.bannerImgSetter();
      this.dynamicText();
    } else {
      later(() => this.retrySetup(attempt + 1), 100);
    }
  }

  get isTagPage() {
    return this.router.currentRouteName === "tags.showCategory";
  }

  get parentCategoryBannerImage() {
    return this.router.currentRoute?.attributes?.category?.parentCategory?.uploaded_background?.url || null;
  }

  get currentCategoryBannerImage() {
    return this.router.currentRoute?.attributes?.category?.uploaded_background?.url || null;
  }

  
  @action
  dynamicText() {
    if (this.router.currentRouteName !== "tags.showCategory") return;
    
    const route = this.router.currentRoute;
    if (!route?.attributes?.category || !route?.attributes?.tag) return;
    
    const currentCatName = route.attributes.category.name;
    const tagName = route.attributes.tag.id.toUpperCase();
    const tagBannerText = document.querySelector('.tag-title-contents h1');

    if(tagBannerText) {
      if(route.attributes.category.parentCategory) {
        const parentCatName = route.attributes.category.parentCategory.name;
        tagBannerText.innerHTML = `<div class="flex flex-col"><span class="text-lg">${parentCatName}</span><span class="text-base">${currentCatName}</span><span class="text-sm">${tagName}</span></div>`;
      } else {
        tagBannerText.innerHTML = `<div class="flex flex-col"><span class="text-base">${currentCatName}</span><span class="text-sm">${tagName}</span></div>`;
      }
    }
  }

  @action
  bannerImgSetter() {
    const tagTitleHeader = document.querySelector('.tag-title-header');
    const bannerImage = this.currentCategoryBannerImage || this.parentCategoryBannerImage;
    
    if (tagTitleHeader && bannerImage) {
      tagTitleHeader.style.backgroundColor = 'transparent';
      tagTitleHeader.style.backgroundImage = `url(${bannerImage})`;
      tagTitleHeader.style.backgroundSize = 'cover';
      tagTitleHeader.style.backgroundPosition = 'center';
    }
  }

  <template>
    {{log this.router.currentRoute.attributes.category.parentCategory.uploaded_background.url this.router.currentRoute.attributes.category.uploaded_background.url}}
    {{#if this.isTagPage}}
      <div class="cat-desc flex items-center absolute top-66 left-169 w-[48%] h-36 p-4 bg-white rounded-2xl shadow-lg gap-4 overflow-hidden z-10">
        <span class="block overflow-hidden" style="display: -webkit-box; -webkit-line-clamp: 4; -webkit-box-orient: vertical; text-overflow: ellipsis;">
          {{{this.router.currentRoute.attributes.category.description}}}
        </span>
      </div>
    {{/if}}
  </template>
}

export default TagBanner;
