class MakeEntryLonger < ActiveRecord::Migration
  def change
    def up
      change_column :entries, :body, :text
    end
    def down
      # This might cause trouble if you have strings longer
      # than 255 characters.
      change_column :entries, :body, :string
    end
  end
end
