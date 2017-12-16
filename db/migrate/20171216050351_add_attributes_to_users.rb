class AddAttributesToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :intro, :text
    add_column :users, :avatar, :string # 用來掛載 CarrierWave 的 Uploader
  end
end
