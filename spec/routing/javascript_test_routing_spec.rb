require "spec_helper"

describe "javascript routes" do
  it "finds the correct routes" do
    { get: "/javascript_tests"}.should route_to("javascript_tests#show")
  end
end
