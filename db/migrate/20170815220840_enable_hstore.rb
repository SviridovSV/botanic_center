class EnableHstore < ActiveRecord::Migration[5.1]
  def up
    enable_extension :hstore
  end

  def down
    disable_extension :hstore
  end
end
