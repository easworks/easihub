import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { on } from '@ember/modifier';
import { action } from '@ember/object';

export class MessageTemplate extends Component {

  @tracked expanded;

  @action
  toggleExpansion() {
    this.expanded = !this.expanded;
  }

  <template>
    <div class="p-2 mb-4 bg-primary-50 rounded-lg border-l-4 border-l-primary-500">
      <h4 class="flex gap-4 items-center justify-between">
        <span class="font-bold">💡 Need help asking a great question?</span>
        <span class="text-primary-400 mr-2 cursor-pointer"
          {{on "click" this.toggleExpansion}}>
          {{if this.expanded 'Show Less ▲' 'Show More ▼'}}
        </span>
      </h4>

      <div class="overflow-hidden transition-all duration-300 ease-in-out {{if this.expanded 'max-h-96 opacity-100' 'max-h-0 opacity-0'}}">
        <div class="pt-4">
          <p>A great question includes software and technical context (e.g., SAP S/4HANA, Salesforce API), the exact error or scenario, and what you've already tried.</p>
          <p class="mt-4"><span class="font-bold">Example</span>: "How can I enable OAuth between Salesforce and Azure AD? I configured the connected app but keep getting 'invalid grant'. I tried updating callback URL and resetting secrets."</p>
          <p class="mt-4">Ask clearly, and others can help you faster.</p>
        </div>
      </div>
    </div>
  </template>
}

export default MessageTemplate;