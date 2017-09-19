RailsAdmin.config do |config|

  ### Popular gems integration

  ## == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)

  ## == Cancan ==
  config.authorize_with :cancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new do
      except [Review]
    end
    export
    bulk_delete
    show
    edit
    delete
    show_in_app do
      except ['OrderIdem', 'Order']
    end
    state
    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end

  config.model Book do
    list do
      configure :dimensions do
        searchable false
        filterable false
        queryable false
        sortable false
      end
    end
  end

  config.model Review do
    list do
      fields :title, :user, :book, :created_at, :rating
      field :status, :state
    end

    edit do
      fields :title, :content, :user, :book, :rating, :created_at
      field :status, :state
    end

    state({
    states: {unprocessed: 'btn-warning', approved: 'btn-success', rejected: 'btn-danger'},
    events: {approve: 'btn-success', reject: 'btn-danger'}
    })
  end

  config.model Order do
    list do
      fields :total_price, :user, :delivery, :created_at, :coupon
      field :state, :state
    end

    edit do
      fields :total_price, :user, :delivery, :coupon, :created_at, :credit_card, :order_items
      field :state, :state
    end

    state({
    states: {in_delivery: 'btn-warning', delivered: 'btn-success', canceled: 'btn-danger', in_progress: 'btn-warning', in_queuen: 'btn-warning'},
    events: {start_delivery: 'btn-success', finish_delivery: 'btn-success', cancel: 'btn-danger'}
    })
  end

  config.model 'Address' do
    visible false
  end

  config.model 'CreditCard' do
    visible false
  end

  config.model 'OrderItem' do
    visible false
  end

  config.model 'Delivery' do
    visible false
  end

  config.model 'Users' do
    visible false
  end
end
