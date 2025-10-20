import Component from '@glimmer/component';
import DButton from "discourse/components/d-button";
import concatClass from "discourse/helpers/concat-class";
import { service } from '@ember/service';
import { action } from '@ember/object';
import { on } from '@ember/modifier';



export default class TopicFallback extends Component {
  @service site;
  @service composer;

  @action
  openReply() {
    this.composer.open({
      action: 'reply',
      topic: this.args.model,
      draftKey: this.args.model.draft_key,
      draftSequence: this.args.model.draft_sequence
    });
  }

  get showReply() {
    return this.args.model.replyCount <= 2;
  }

  get title() {
    return this.args.model.replyCount === 0
    ? "Be the first to respond"
    : "Encouraging early contribution";
  }

  get description() {
    return this.args.model.replyCount === 0
    ? "Share your expertise and help start the conversation. Your insights could be valuable to the community."
    : "Join the conversation early Add your perspective or experience to help build a more complete discussion.";
  }

  <template>
    {{log this.args.model}}
    {{#if this.showReply}}
    <div class="empty-state">
        <div class="empty-icon">
          <svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
            <path
              d="M20 2H4c-1.1 0-2 .9-2 2v18l4-4h14c1.1 0 2-.9 2-2V4c0-1.1-.9-2-2-2zm0 14H6l-2 2V4h16v12z"
            />
          </svg>
        </div>

        <h2 class="empty-title">{{this.title}}</h2>
        <p class="empty-description">{{this.description}}</p>

        <button class="cta-button" {{on "click" this.openReply}}>
          <svg width="16" height="16" viewBox="0 0 24 24" fill="currentColor">
            <path d="M19 13h-6v6h-2v-6H5v-2h6V5h2v6h6v2z" />
          </svg>
          Add Response
        </button>

        <div class="secondary-actions">
          <a href="#" class="secondary-link">
            <svg width="14" height="14" viewBox="0 0 24 24" fill="currentColor">
              <path
                d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm1 15h-2v-2h2v2zm0-4h-2V7h2v6z"
              />
            </svg>
            View Guidelines
          </a>
          <a href="#" class="secondary-link">
            <svg width="14" height="14" viewBox="0 0 24 24" fill="currentColor">
              <path
                d="M16 11c1.66 0 2.99-1.34 2.99-3S17.66 5 16 5c-1.66 0-3 1.34-3 3s1.34 3 3 3zm-8 0c1.66 0 2.99-1.34 2.99-3S9.66 5 8 5C6.34 5 5 6.34 5 8s1.34 3 3 3zm0 2c-2.33 0-7 1.17-7 3.5V19h14v-2.5c0-2.33-4.67-3.5-7-3.5zm8 0c-.29 0-.62.02-.97.05 1.16.84 1.97 1.97 1.97 3.45V19h6v-2.5c0-2.33-4.67-3.5-7-3.5z"
              />
            </svg>
            Follow Topic
          </a>
        </div>
      </div>
      {{/if}}
  </template>
}

