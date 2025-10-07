import { apiInitializer } from 'discourse/lib/api';

export default apiInitializer(api => {

  api.onAppEvent('composer:open', ({ model }) => {
    // Only hide fields for customized new topics

    setTimeout(() => {
      const input = getInputElement();
      const textarea = getTextareaElement();


      if(!input && !textarea) {
        return;
      }

      // Hide default fields for customized composers
      if (input) {
        input.classList.add('hidden');
      }
      if (textarea) {
        textarea.classList.add('hidden');
      }
    },100);


    if (model.action !== 'createTopic' || !model.customization) {
      showDefaultFields();
      return;
    }

  });

  // Show fields when composer is closed or for non-customized composers
  api.onAppEvent('composer:closed', () => {
    showDefaultFields();
  });
});

function getInputElement() {
  return document.querySelector('.title-and-category .title-input');
}

function getTextareaElement() {
  return document.querySelector(
    '.toolbar-visible > .d-editor > .d-editor-container.--rich-editor-enabled > .d-editor-textarea-column > .d-editor-textarea-wrapper:last-of-type'
  );
}





function showDefaultFields() {
  const input = getInputElement();
  const textarea = getTextareaElement();

  if (input) {
    input.classList.remove('hidden');
  }
  if (textarea) {
    textarea.classList.remove('hidden');
  }
}
