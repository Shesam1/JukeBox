class InitialSchema < ActiveRecord::Migration[5.1]
  def change
  	create_table :users do |t|
  		t.string :name, limit: 32
  		t.string :last, limit: 32
  		t.string :username, limit: 32
  		t.string :password, limit: 32
  		t.string :photo
  		t.string :occupancy
  		t.string :relationship 
  	end
  	create_table :posts do |t|
  		t.string :message, limit: 150
  		t.string :photo
  		t.references :user, foreign_key: {to_table: :users}, index: true
  	end
  	create_table :comments do |t|
  		t.string :message, limit: 64 
  		t.references :user, foreign_key: {to_table: :users}, index: true
  		t.references :post, foreign_key: {to_table: :posts}, index: true
  	end
  	create_table :followings do |t|
  		t.references :follower, foreign_key: {to_table: :users}, index: true
  		t.references :followee, foreign_key: {to_table: :users}, index: true
  	end
  end
end
