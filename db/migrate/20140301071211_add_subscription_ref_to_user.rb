class AddSubscriptionRefToUser < ActiveRecord::Migration
  def change
    add_reference :users, :subscription, index: true
  end
end
