class CreateUploadimgs < ActiveRecord::Migration[7.1]
  def change
    create_table :uploadimgs do |t|

      t.timestamps
    end
  end
end
