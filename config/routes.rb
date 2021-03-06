ActionController::Routing::Routes.draw do |map|

  map.resource :account,
    :member => { :activate => :get, :password => :get, :change_password => :put } do |account|
    account.resources :personas do |personas|
      personas.resources :properties
    end
    account.resources :sites do |sites|
      sites.resources :release_policies
    end
  end
  
  map.resource :session
  map.resource :password
  
  map.with_options :controller => 'passwords' do |pwd|
    pwd.forgot_password 'forgot_password', :action => 'new'
    pwd.reset_password  'reset_password/:id', :action => 'edit'
  end
  
  map.with_options :controller => 'sessions' do |sessions|
    sessions.login 'login', :action => 'new'
    sessions.logout 'logout', :action => 'destroy'
  end
  
  map.with_options :controller => 'server' do |server|
    server.formatted_server 'server.:format', :action => 'index'
    server.server 'server', :action => 'index'
    server.decide 'server/decide', :action => 'decide'
    server.proceed 'server/proceed', :action => 'proceed'
    server.complete 'server/complete', :action => 'complete'
    server.cancel 'server/cancel', :action => 'cancel'
  end

  map.with_options :controller => 'consumer' do |consumer|
    consumer.consumer 'consumer', :action => 'index'
    consumer.consumer_start 'consumer/start', :action => 'start'
    consumer.consumer_complete 'consumer/complete', :action => 'complete'
  end

  map.with_options :controller => 'info' do |info|
    info.home '', :action => 'index'
    info.help 'help', :action => 'help'
  end
  
  map.with_options :controller => 'accounts' do |account|
    account.formatted_identity ':account.:format', :action => 'show'
    account.identity ':account', :action => 'show'
  end
  
end
