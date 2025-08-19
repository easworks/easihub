import ObjectProxy from '@ember/object/proxy';
import PromiseProxyMixin from '@ember/object/promise-proxy-mixin';

const ObjectPromiseProxy = ObjectProxy.extend(PromiseProxyMixin);

export function createPromiseProxy(promise) {
  return ObjectPromiseProxy.create({ promise });
}