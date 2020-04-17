Rails.application.routes.draw do
  resources :lists
  resources :organizations
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  scope :api, defaults: { format: :json } do
    scope "users" do
	  	post "update_name" => 'users#update_name'
	  	get "retrieve/:phone" => 'users#retrieve'

		  devise_scope :user do
	      post "/sign_up" => 'registrations#sign_up'
	    end
	  end

	  scope "lists" do
	  	post "add_item" => "lists#add_item"
	  	post "remove_item" => "lists#remove_item"
	  	get "show_items/:phone" => "lists#show_items"
	  end

	  scope "commands" do
	  	post "trigger_mylist/:phone" => "commands#trigger_mylist"
	  end
  end
  
  
  authenticate :user do
    # Rails 4 users must specify the 'as' option to give it a unique name
    root :to => "home#index", :as => "authenticated_root"
  end
end