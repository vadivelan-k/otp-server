class CreateOtps < ActiveRecord::Migration[7.1]
  def change
    create_table :otps do |t|
      t.string  :code
      t.string  :status
      t.datetime  :expired_at
      t.integer :mobile_number
    end
  end
end
