class AddVerticalPosterProcessingAndHorizontalPosterProcessingToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :small_cover_processing, :boolean, null: false, default: false
    add_column :videos, :large_cover_processing, :boolean, null: false, default: false
  end
end
