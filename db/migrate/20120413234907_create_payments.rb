class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.string :trans_id
      t.string :payment_status
      t.string :payer_name
      t.string :payer_address

      t.timestamps
    end
  end
end
