# frozen_string_literal: true

# name: eas-custom-fields
# about: super-simple plugin for custom fields
# version: 0.1.0

enabled_site_setting :eas_custom_fields_enabled

after_initialize do
  # Register and preload the custom field type
  Category.register_custom_field_type("eas", :json)
  register_preloaded_category_custom_fields("eas")
  
  # Add to category serializer so it's sent to frontend
  # add_to_serializer(:category, :eas) do
    # object.custom_fields["eas"]
  # end
end