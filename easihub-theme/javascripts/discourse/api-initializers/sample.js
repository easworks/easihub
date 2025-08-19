import { apiInitializer } from 'discourse/lib/api';

export default apiInitializer(api => {
  api.modifyClass('route:discovery.categories',
    klass => class extends klass {
      async model() {
        const s = await super.model(...arguments);
        return s;
      }
    }
  );
});