module QueueItemsHelper
  def user_rating_template(rating)
    rating = 0 unless rating.is_a?(Integer)

    template = ["<option value='0'>none</option>",
                "<option value='1'>1 Star</option>",
                "<option value='2'>2 Stars</option>",
                "<option value='3'>3 Stars</option>",
                "<option value='4'>4 Stars</option>",
                "<option value='5'>5 Stars</option>"
               ]
    template[rating].gsub! "<option", "<option selected='selected'"
    template.join
  end
end
