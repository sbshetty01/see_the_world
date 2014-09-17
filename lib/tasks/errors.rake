namespace :errors do
  task :build_error_pages => :environment do
    status = 500
    I18n.available_locales.each do |locale|
      I18n.with_locale locale do
        write_error_page(status, locale)
        # We need a default error page for when Rails doesn't work
        write_error_page(status) if locale.to_sym == default_error_page_locale
      end
    end
  end

  def write_error_page(status, locale = nil)
    dest_filename = [status.to_s, locale, "html"].compact.join(".")
    File.open(File.join(Rails.root, "public", dest_filename), "w") do |file|
      path = File.join(Rails.root, "app", "views", "shared", "#{status}.html.haml")

      template = File.read(path)
      haml_engine = Haml::Engine.new(template)
      output = haml_engine.render

      file.print output
    end
  end

  def default_error_page_locale
    :en
  end

end
