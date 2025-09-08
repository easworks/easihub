import DiscourseTemplateMap from 'discourse/lib/discourse-template-map';

{
  const original = DiscourseTemplateMap.setModuleNames.bind(DiscourseTemplateMap);
  DiscourseTemplateMap.setModuleNames = function () {
    const base = original(...arguments);

    // discover-categories template override
    {
      const template = DiscourseTemplateMap.templates.get('overrides/discovery/categories');
      if (template) {
        DiscourseTemplateMap.templates.set('discovery/categories', template);
      }
    }

    return base;
  };
}

export default {
  initialize: () => void 0
};