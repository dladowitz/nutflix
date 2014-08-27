require "spec_helper"

describe VideoDecorator, "#large_poster_image" do
  let(:video) { videos :iron_man }
  subject { video.decorate.large_poster_image }

  context "when large_cover is still processing" do
    it "returns the processing image" do
      video.update_attributes(large_cover_processing: true)
      expect(subject).to eq "fallback/large_cover_processing.png"
    end
  end

  context "when large_cover is done processing" do
    context "when video does not have a large_cover" do
      it "returns the default image" do
        expect(subject).to eq "fallback/large_default.jpg"
      end
    end

    context "when video does have a large_cover" do
      it "returns the large cover image" do
        video.large_cover =  File.open("public/tmp/monk_large.jpg")
        video.process_large_cover_upload = true
        video.save

        expect(subject).to eq "/test/video/large_cover/45/monk_large.jpg"
      end
    end
  end
end
