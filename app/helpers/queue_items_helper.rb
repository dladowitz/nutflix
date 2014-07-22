module QueueItemsHelper
  def user_rating_template(rating)
    rating = 0 unless rating.is_a?(Integer)

    template = ["<option>none</option>",
                "<option>1 Star</option>",
                "<option>2 Stars</option>",
                "<option>3 Stars</option>",
                "<option>4 Stars</option>",
                "<option>5 Stars</option>"
               ]
    template[rating].gsub! "<option>", "<option selected='selected'>"
    template.join
  end
end
