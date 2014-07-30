require "spec_helper"

describe User do
  it { should have_many(:reviews) }
  it { should have_many(:followers) }
  it { should have_many(:followed_users) }
  it { should have_many(:invitations)}
end
