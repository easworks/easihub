import { apiInitializer } from "discourse/lib/api";
import { addLayersToStyleSheets } from '../../layered-css-links';
import { CreateTopicButtonService } from '../../services/create-topic-button';

export default apiInitializer(async (api) => {
  CreateTopicButtonService.init(api);

  await runOnInit(api, async () => {
    addLayersToStyleSheets();
  });
});

function runOnInit(api, callback) {
  return new Promise((resolve, reject) => {
    let initialized = false;
    api.onPageChange(() => {
      if (initialized) {
        return;
      }

      initialized = true;

      callback()
        .then(resolve)
        .catch(reject);
    });
  });
}