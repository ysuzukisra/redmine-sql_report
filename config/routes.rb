# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html

match "repo", :to => 'repo#index', via: [:get, :post]
