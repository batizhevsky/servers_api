class CreateHosts < ActiveRecord::Migration
  def change
    create_table :hosts do |t|
      t.references :rack, index: true
      t.string :name, nil: false
      t.string :type, nil: false

      t.timestamps
    end
  end
end
