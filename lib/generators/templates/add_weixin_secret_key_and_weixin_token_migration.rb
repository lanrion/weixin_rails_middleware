class AddWeixinSecretKeyAndWeixinTokenTo<%= table_name.camelize %> < ActiveRecord::Migration
  def self.up
    change_table(:<%= table_name %>) do |t|
      t.string :weixin_secret_key, :null => false
      t.string :weixin_token,      :null => false
    end
    add_index :<%= table_name %>, :weixin_secret_key, :unique => true
    add_index :<%= table_name %>, :weixin_token,      :unique => true
  end

  def self.down
    # By default, we don't want to make any assumption about how to roll back a migration when your
    # model already existed. Please edit below which fields you would like to remove in this migration.
    raise ActiveRecord::IrreversibleMigration
  end
end
