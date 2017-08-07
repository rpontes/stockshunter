class CreateQuotations < ActiveRecord::Migration[5.1]
  def change
    create_table :quotations do |t|
      t.decimal :buy
      t.decimal :sell
      t.decimal :variation
      t.datetime :quotation_at
      t.references :currency

      t.timestamps
    end
  end
end
