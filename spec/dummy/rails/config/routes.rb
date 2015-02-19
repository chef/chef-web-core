Rails.application.routes.draw do
  mount Chef::Web::Core::Engine, at: '/guide'
  get '/', to: redirect('/guide')
end
