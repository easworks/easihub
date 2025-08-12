export function addLayersToStyleSheets() {
  wrapDiscourseAssetsCss();
}

function wrapDiscourseAssetsCss() {
  const allowedTargets = [
    'common'
  ];

  const container = document.querySelector('discourse-assets-stylesheets');

  const colorSchemes = container.querySelectorAll('link[data-scheme-id]');
  const pluginStyles = allowedTargets
    .map(t => container.querySelector(`link[data-target=${t}]`));

  [...colorSchemes, ...pluginStyles]
    .forEach(link => processStyleLink(link));
}

// const ALLOWED_URLS = [
//   'https://cdn.easihub.com/stylesheets/common_'
// ];

// /**
//  * @param {string} url - The URL to validate
//  * @returns {boolean} Whether the URL is allowed
//  */
// function isUrlAllowed(url) {
//   return ALLOWED_URLS.some(allowedUrl => url.startsWith(allowedUrl));
// }

// /**
//  * @param {HTMLElement} element - The HTML element to observe
//  */
// function observeElement(element) {

//   element.childNodes.forEach(node => processNode(node));

//   observer.observe(document.head, { childList: true });

//   return () => observer.disconnect();
// };


// const observer = new MutationObserver(mutations => {
//   mutations.forEach(mutation => {
//     mutation.addedNodes.forEach(node => processNode(node));
//   });
// })


// /**
//  * @param {Node} node - The DOM node to process
//  */
// function processNode(node) {
//   if (node.nodeType !== Node.ELEMENT_NODE) return;
//   if (node.tagName !== 'LINK' || node.rel !== 'stylesheet') return;
//   if (!isUrlAllowed(node.href)) return;

//   processStylesheet(node);
// }

/**
 * @param {HTMLLinkElement} linkElement - The link element to process
 */
async function processStyleLink(linkElement) {
  try {
    const response = await fetch(linkElement.href);
    const cssContent = await response.text();

    const styleElement = document.createElement('style');
    styleElement.textContent = `@layer base { ${cssContent} }`;

    const target = linkElement.getAttribute('data-target');
    if (target)
      styleElement.setAttribute('data-target', target);

    linkElement.parentElement.replaceChild(styleElement, linkElement);
  } catch (error) {
    console.error('Failed to process stylesheet:', error);
  }
}
