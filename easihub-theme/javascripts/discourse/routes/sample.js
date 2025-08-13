export default function extendRoute(api) {
  api.modifyClass('route:discovery.categories',
    klass => class extends klass {
      async model() {
        const s = await super.model(...arguments);
        console.debug(s);
        return s;
      }
    }
  );
}

