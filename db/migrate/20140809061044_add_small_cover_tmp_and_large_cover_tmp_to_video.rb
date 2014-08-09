class AddSmallCoverTmpAndLargeCoverTmpToVideo < ActiveRecord::Migration
  def change
    add_column :videos, :small_cover_tmp, :string
    add_column :videos, :large_cover_tmp, :string
  end
end
