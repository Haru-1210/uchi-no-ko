class CreateAccessCodes < ActiveRecord::Migration[7.1]
  def change
    create_table :access_codes do |t|

      t.timestamps
    end
  end
end
