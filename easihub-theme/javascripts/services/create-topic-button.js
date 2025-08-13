import Service from '@ember/service';
import { sleep } from '../utils/sleep';

export class CreateTopicButtonService extends Service {
  static init(api) {
    api.container.registry.register('service:create-topic-button', CreateTopicButtonService);
  }

  /** @type {HTMLButtonElement | null} */
  #button;

  constructor() {
    super(...arguments);
  }

  async getButton() {
    if (this.#button && this.#button.isConnected) {
      return this.#button;
    }

    const totalTime = 3000;
    const interval = 50;
    const maxAttempts = Math.floor(totalTime / interval);

    for (let i = 0; i < maxAttempts; i++) {
      await sleep(interval);
      const button = this.#findButton();
      if (button) {
        this.#button = button;
        return this.#button;
      }
    }

    throw new Error(`'create-topic' button not found within ${totalTime / 1000} seconds`);
  }

  #findButton() {
    return document.querySelector('#create-topic');
  }

  async setText(labelText) {
    const button = await this.getButton();
    const label = button.querySelector('.d-button-label');
    label.textContent = labelText || 'New Topic';
  }
}