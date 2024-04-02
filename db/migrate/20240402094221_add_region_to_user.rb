# frozen_string_literal: true

class AddRegionToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :region, :integer, default: 0
  end
end
