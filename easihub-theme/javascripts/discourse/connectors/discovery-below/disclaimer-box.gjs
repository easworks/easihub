import Component from '@glimmer/component';
import { on } from '@ember/modifier';
import { action } from '@ember/object';
import { service } from '@ember/service';
import { tracked } from '@glimmer/tracking';

export default class DisclaimerBox extends Component {
  @service router;
  @tracked tag = null;

  allowedTags = ['article', 'event', 'bulletin', 'job'];


  @action
  openBox() {
    const tipDetails = document.getElementById('tipDetails');
    const toggleText = document.getElementById('toggleText');
    const arrow = document.getElementById('arrow');

    if (tipDetails.style.display === 'none') {
        tipDetails.style.display = 'block';
        toggleText.innerText = 'Show less';
        arrow.innerText = '▲';
      } else {
        tipDetails.style.display = 'none';
        toggleText.innerText = 'Show more';
        arrow.innerText = '▼';
      }
  }

  get tagPages() {
    this.tag = this.router.currentRoute.params.tag_id;
    if(this.tag && this.allowedTags.includes(this.tag)) {
      return true;
    } else {
      return false;
    }
  }

  <template>
    {{#if this.tagPages}}
      <div class="tip-box-collapsed">
      💡 <strong>Disclaimer:</strong> Most content on this page is aggregated from
        publicly available sources and is shared for informational purposes only.
        <a onclick="toggleTip(event)">
          <span id="toggleText" {{on "click" this.openBox}}>Show more</span> <span id="arrow">▼</span>
        </a>
        <div
          class="tip-details"
          id="tipDetails"
          style="display: none; margin-top: 10px"
        >
          All trademarks, images, and articles belong to their respective owners, and
          each card links directly to the original publisher. Additionally, some
          content may be contributed by forum users. We do not claim ownership of
          third-party content and are not affiliated with or endorsed by the original
          publishers.
        </div>
      </div>
    {{/if}}
  </template>
}