shared_examples "requires signin without an authenticated user" do
  it "redirects to the the correct path with an unauthenticated user" do
    logout
    http_request
    expect(response).to redirect_to signin_path
  end
end

shared_examples "redirects with an authenticated user" do
  it "redirects to the the correct path with an unauthenticated user" do
    http_request

    expect(response).to redirect_to authenticated_path
  end
end

shared_examples "renders template with an authenticated user" do
  it "redirects to the the correct path with an unauthenticated user" do
    http_request

    expect(response).to render_template authenticated_template
  end
end
