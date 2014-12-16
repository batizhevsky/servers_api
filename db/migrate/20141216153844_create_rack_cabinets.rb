class CreateRackCabinets < ActiveRecord::Migration
  def change
    create_table :rack_cabinets do |t|
      t.string :name, nil: false
      t.string :location, nil: false

      t.timestamps
    end
  end
end
