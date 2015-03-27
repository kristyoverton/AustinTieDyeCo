class AddAttachmentImgToBlankets < ActiveRecord::Migration
  def self.up
    change_table :blankets do |t|
      t.attachment :img
    end
  end

  def self.down
    remove_attachment :blankets, :img
  end
end
