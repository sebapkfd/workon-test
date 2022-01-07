# Rails.application.routes.draw do
#   root "lawyers#index"

#   post "/lawyers", to: "lawyers#index"
# end


Rails.application.routes.draw do
  post "/lawyers", to: "lawyers#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
