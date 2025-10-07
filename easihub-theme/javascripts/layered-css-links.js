import { currentThemeId } from 'discourse/lib/theme-selector';

export function addLayersToStyleSheets() {
  wrapDiscourseAssetsCss();
  wrapHeaderCss();
}

/**
 * @returns {HTMLElement}
 */
function getContainer() {
  return document.querySelector('discourse-assets-stylesheets');
}

/**
 * @returns {HTMLLinkElement | null}
 */
function getLayeredCssLinks() {
  return document.querySelector('#layered-css-links');
}

function wrapDiscourseAssetsCss() {
  const allowedTargets = new Set([
    'common',
    'desktop',
    'common_theme',
    'desktop_theme',
    'discourse-ai'
  ]);
  const current = currentThemeId();

  const container = getContainer();

  const links = container.querySelectorAll('link');

  const colorSchemes = [];
  const pluginStyles = [];

  for (const link of links) {
    if (link.getAttribute('data-theme-id') === current.toString()) {
      continue;
    }

    const target = link.getAttribute('data-target');
    if (target) {
      if (allowedTargets.has(target)) {
        pluginStyles.push(link);
      }
    }
    else {
      try {
        const url = new URL(link.href);
        if (isColorDefinition(url)) {
          colorSchemes.push(link);
        }
      }
      catch (e) {
        console.error('could not parse url', e);
      }
    }
  }

  const toProcess = [...colorSchemes, ...pluginStyles];

  const stylesheet = constructStyleElementForLinks(toProcess);
  stylesheet.id = 'layered-css-links';

  const existing = getLayeredCssLinks();
  if (existing) {
    existing.replaceWith(stylesheet);
  }
  else {
    container.insertAdjacentElement('afterbegin', stylesheet);

  }

  toProcess.forEach(link => link.remove());
}

function wrapHeaderCss() {
  const allowedLinks = [
    'https://cdnjs.cloudflare.com/ajax/libs/font-awesome'
  ];

  const links = document.head.querySelectorAll('link[rel=stylesheet]');
  for (const link of links) {
    if (allowedLinks.some(al => link.href.startsWith(al))) {
      processStyleLink(link);
    }
  }
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

    const { css, fontFaces } = extractFontFaces(cssContent, linkElement.href);

    const styleElement = document.createElement('style');
    styleElement.textContent = [
      fontFaces,
      '\n',
      '@layer base {',
      css,
      '}'
    ].join('\n');

    const target = linkElement.getAttribute('data-target');
    if (target) {
      styleElement.setAttribute('data-target', target);
    }

    linkElement.parentElement.replaceChild(styleElement, linkElement);
  } catch (error) {
    console.error('Failed to process stylesheet:', error);
  }
}


/**
 * @param {HTMLLinkElement[]} linkElements
 * @returns {HTMLStyleElement}
 */
function constructStyleElementForLinks(linkElements) {
  const styleElement = document.createElement('style');

  styleElement.textContent = linkElements.map(link =>
    `@import url('${link.href}') layer(base);`
  ).join('\n');

  return styleElement;
}

const fontFaceRegex = /@font-face\s*\{[^}]*\}/g;

function extractFontFaces(contents, baseUrl) {
  const fontFaces = (contents.match(fontFaceRegex) || [])
    .map(fontFace => resolveRelativeUrls(fontFace, baseUrl))
    .join('\n\n');
  const css = contents.replace(fontFaceRegex, '');

  return {
    css,fontFaces
  };
}

function resolveRelativeUrls(fontFace, baseUrl) {
  const urlRegex = /url\(["']?([^"')]+)["']?\)/g;
  return fontFace.replace(urlRegex, (match, url) => {
    if (url.startsWith('http') || url.startsWith('//')) {
      return match;
    }
    const resolvedUrl = new URL(url, baseUrl).href;
    return match.replace(url, resolvedUrl);
  });
}

/**
 * @param {URL} url
 */
function isColorDefinition(url) {
  const last = url.pathname.split('/').at(-1);
  return last.startsWith('color_definitions_');
}