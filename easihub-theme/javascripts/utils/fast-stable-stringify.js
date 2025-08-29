const lib = import('https://esm.run/fast-json-stable-stringify');

export async function fastStableStringify() {
  return (await lib).default(...arguments);
}