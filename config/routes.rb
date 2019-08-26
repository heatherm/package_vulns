Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  scope :ujs, defaults: { format: :ujs } do
    post "search" => "pages#search"
  end

  root to: "pages#root"
end
