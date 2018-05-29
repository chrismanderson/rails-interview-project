class AddLastCountToTenant < ActiveRecord::Migration[5.1]
  def change
    add_column :tenants, :request_count, :integer
    add_column :tenants, :last_accessed_at, :datetime
  end
end
