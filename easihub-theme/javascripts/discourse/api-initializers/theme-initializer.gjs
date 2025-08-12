import { apiInitializer } from "discourse/lib/api";

export default apiInitializer((api) => {
  //
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