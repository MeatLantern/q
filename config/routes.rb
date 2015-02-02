DuelOfChampions::Application.routes.draw do
  root :to => redirect('/game/rules')

  devise_for :users
  resources :users
  
  get "users/index"
  get "users/edit"
  get "users/view"
  post "users/add_admin"
  post "users/remove_admin"
  match 'users/admin', to: 'users#admin', via: :post

  resources :characters
  match 'create_suggestion', to: 'suggestion#create', via: :post
  match 'view_suggestion', to: 'suggestion#view', via: :get
  match 'delete_suggestion', to: 'suggestion#delete', via: :post
  match 'create_suggestion', to: 'suggestion#create', via: :post
  match 'delete_all_suggestions', to: 'suggestion#delete_all_suggestions', via: :post

  #match 'transformation_example', to: 'transformation#example', via: :get

  match 'change_order', to: 'characters#change_order', via: :post
  match 'equalize_upvotes', to: 'transformation#equalize_upvotes', via: :post
  match 'transformation/show', to: 'transformation#show', via: :get
  match 'transformation/edit', to: 'transformation#edit', via: :get
  match 'transformation/show', to: 'transformation#show', via: :get
  match 'set_alts_to_original_abilities', to: 'transformation#set_alts_to_original_abilities', via: :post
  match 'select_num_stages', to: 'transformation#select_num_stages', via: :get
  match 'stage_setup', to: 'transformation#stage_setup', via: :post
  match 'change_pref', to: 'invitation_preferences#change', via: :post
  match 'view_comment', to: 'comment#view', via: :get
  match 'create_comment', to: 'comment#create', via: :post
  match 'comment/edit', to: 'comment#edit', via: :get
  match 'update_comment', to: 'comment#update', via: :post
  match 'delete_comment', to: 'comment#delete', via: :post
  match 'comment_admin', to: 'comment#admin', via: :get
  match 'flag_comment', to: 'comment#flag', via: :post


  resources :transformation

  match 'tf', to: 'transformation#new_tf', via: :get

  match 'new_tf3', to: 'transformation#new_tf3', via: :get

  match 'new_tf5', to: 'transformation#new_tf5', via: :get

  match 'tf/new', to: 'transformation#new_tf', via: :get

  match 'create_report', to: 'report#create_report', via: :post
  match 'send_report', to: 'report#send_report', via: :post
  match 'admin_report', to: 'report#admin', via: :get
  match 'edit_report', to: 'report#edit', via: :get
  match 'change_report', to: 'report#change', via: :post
  match 'destroy_report', to: 'report#destroy', via: :post

  match 'set_completed_false' , to: 'transformation#set_completed_and_fully_illustrated_to_false', via: :post

  match 'add_to_character', to: 'transformation#add_to_character', via: :post
  match 'add_to_character3', to: 'transformation#add_to_character3', via: :post
  match 'add_to_character5', to: 'transformation#add_to_character5', via: :post
  match 'auto_write', to: 'transformation#auto_write', via: :post

  get "transformation/new_tf"

  match 'tf_admin', to: 'transformation#admin', via: :get

  match 'update_tf', to: 'transformation#update', via: :post

  match 'delete_tf', to: 'transformation#delete_tf', via: :post

  match 'game/about', to: 'game#about', via: :get

  match 'upvote_character', to: 'characters#upvote', via: :post

  match 'set_upvotes_to_0', to: 'characters#set_upvotes_to_0', via: :post

  match 'select_opponent_ai', to: 'characters#select_opponent', via: :post
   match 'select_opponent_ai', to: 'characters#select_opponent', via: :get

  match 'select_opponent_game', to: 'game#create_choose_ai_game', via: :post

  match 'clean_up_tf', to: 'transformation#clean_up_tf', via: :get
  match 'clean_up_tf', to: 'transformation#clean_up_tf', via: :post
  match 'set_summon_to_original', to: 'transformation#set_summon_to_original', via: :post
  match 'set_summon_to_original', to: 'transformation#set_summon_to_original', via: :get

  match 'edit_creator', to: "characters#edit_creator", via: :post
  match 'update_creator', to: "characters#update_creator", via: :post

  match 'set_tf_creator_to_character_creator', to: "transformation#set_tf_creator_to_character_creator", via: :post

  #match 'transformation/new', to: 'transformation#new', via: :get


  #get "game/new"

  #get "game/create"

  get "game/rules"
  #get "game/show"
  get "game/admin"
  post "game/delete_game"
  post "game/delete_all"
  #resources :games 
  match 'view', to: 'users#view', via: :post
  match 'users/index', to: 'users#index', via: :post

  match 'tf_tag_descriptions', to: 'transformation#tf_tag_descriptions', via: :get

  match 'game/', to: 'game#show', via: :get
  match 'game/show', to: 'game#show', via: :get
  match 'game/game/show', to: 'game#show', via: :get
  match 'game/take_turn', to: 'game#take_turn', via: :post
  match 'game/game/take_turn', to: 'game#take_turn', via: :post
  match 'game/ai_take_turn', to: 'game#ai_take_turn', via: :post
  match 'game/game/ai_take_turn', to: 'game#ai_take_turn', via: :post
  match 'game/cpu_reset_game', to: 'game#cpu_reset_game', via: :post
  match 'game/game/cpu_reset_game', to: 'game#cpu_reset_game', via: :post
  match 'game/create_ai_game', to: 'game#create_ai_game', via: :post
  match 'game/game/create_ai_game', to: 'game#create_ai_game', via: :post
  match 'game/game_not_found', to: 'game#game_not_found', via: :get
  match 'game/game/game_not_found', to: 'game#game_not_found', via: :get
  match 'game/leave_game', to: 'game#leave_game', via: :get
  match 'game/game/leave_game', to: 'game#leave_game', via: :get
  match 'game/destroy_current_game', to: 'game#destroy_current_game', via: :delete
  match 'game/game/destroy_current_game', to: 'game#destroy_current_game', via: :delete
  match 'game/destroy_current_game', to: 'game#destroy_current_game', via: :post
  match 'game/game/destroy_current_game', to: 'game#destroy_current_game', via: :post
  match 'game/game/game/destroy_current_game', to: 'game#destroy_current_game', via: :post
  match 'game/send_message', to: 'game#send_message', via: :post
  match 'game/game/send_message', to: 'game#send_message', via: :post

  match 'check_18', to: 'game#check_18', via: :get
  match 'authorize_18', to: 'game#authorize_18', via: :post
  

  match 'game/abilities', to: 'game#abilities', via: :get
  match 'game/game/abilities', to: 'game#abilities', via: :get

   match 'characters/destroy', to: 'characters#destroy', via: :post
  #match 'character/show', to: 'characters#character_select_ai', via: :get
  match 'characters/show', to: 'characters#show', via: :get
  match 'character/go', to: 'characters#character_select_ai', via: :get
  match 'character/character_select_ai', to: 'characters#character_select_ai', via: :get
  match 'character/character_select_ai', to: 'characters#character_select_ai', via: :post
  match 'character/admin', to: 'characters#admin', via: :get
  match 'character/edit', to: 'characters#edit', via: :get
  match 'character/character/edit', to: 'characters#edit', via: :get
  match 'character/update', to: 'characters#update', via: :post
  match 'character/character/update', to: 'characters#update', via: :post

  match 'invitations_screen', to: 'game_invitation#invitations_screen', via: :get
  match 'game/invitations_screen', to: 'game_invitation#invitations_screen', via: :get
  match 'game_invitation/invitations_screen', to: 'game_invitation#invitations_screen', via: :get
  match 'game_invitation/show', to: 'game_invitation#show', via: :get
  match 'game_invitation/multiplayer_select_character', to: 'game_invitation#multiplayer_select_character', via: :get
  match 'multiplayer_select_character', to: 'game_invitation#multiplayer_select_character', via: :get
  match 'multiplayer_select_character', to: 'game_invitation#multiplayer_select_character', via: :post
  match 'game_invitation/multiplayer_character_choose', to: 'game_invitation#multiplayer_character_choose', via: :post
  match 'multiplayer_character_choose', to: 'game_invitation#multiplayer_character_choose', via: :post
  match 'game_invitation/join_invite', to: 'game_invitation#join_invite', via: :post
  match 'join_invite', to: 'game_invitation#join_invite', via: :post
  match 'game_invitation/leave_invite', to: 'game_invitation#leave_invite', via: :post
  match 'leave_invite', to: 'game_invitation#leave_invite', via: :post
  match 'game_invitation/leave_invite', to: 'game_invitation#leave_invite', via: :post
  match 'leave_invite', to: 'game_invitation#leave_invite', via: :post
  match 'game_invitation/multiplayer_start_game', to: 'game_invitation#multiplayer_start_game', via: :post
  match 'multiplayer_start_game', to: 'game_invitation#multiplayer_start_game', via: :post
  #match 'game/game_invitations/create', to: 'game_invitation#create', via: :post
  #match 'game/game_invitations/invitations_screen', to: 'game_invitation#create', via: :post
  resources :game_invitation

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
