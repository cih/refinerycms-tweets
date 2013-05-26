Refinery::Core::Engine.routes.draw do
  namespace :tweets, :path => '' do
    # get '/contact', :to => 'inquiries#new', :as => 'new_inquiry'

    # resources :contact,
    #             :only => :create,
    #             :as => :inquiries,
    #             :controller => 'inquiries' do
    #   get :thank_you, :on => :collection
    # end

    namespace :admin, :path => 'refinery' do
      resource :twitter_account
      # scope :path => 'tweets' do
      #   resources :settings, :only => [:edit, :update]
      # end
    end
  end
end