class AddStatusToPins < ActiveRecord::Migration
  def change
    add_column :pins, :status, :string, :default => "todo"
    Pin.all.each do |pin|
      pin.update_attributes({:status => "todo"})
    end
  end
end
