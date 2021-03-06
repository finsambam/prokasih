require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Prokasih
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.assets.paths << Rails.root.join('vendor', 'assets', 'components')

    config.assets.paths << Rails.root.join('app','assets','fonts')

    config.assets.precompile << /\.(?:svg|eot|woff|ttf)$/

    # # Bower asset paths
    # root.join('vendor', 'assets', 'components').to_s.tap do |bower_path|
    #   config.sass.load_paths << bower_path
    #   config.assets.paths << bower_path
    # end
    # # Precompile Bootstrap fonts
    # config.assets.precompile << %r(bootstrap-sass/assets/fonts/bootstrap/[\w-]+\.(?:eot|svg|ttf|woff2?)$)
    # # Minimum Sass number precision required by bootstrap-sass
    # ::Sass::Script::Value::Number.precision = [8, ::Sass::Script::Value::Number.precision].max
    config.assets.precompile += ['bootstrap.css']
    config.assets.precompile += ['pdf.css']
    config.assets.precompile += ['jquery.js']
    config.assets.precompile << Proc.new { |path| path =~ /font-awesome\/fonts/ and File.extname(path).in?(['.otf', '.eot', '.svg', '.ttf', '.woff']) }
  end
end
