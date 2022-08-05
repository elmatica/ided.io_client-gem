require "spec_helper"
require "ided_client/test_helpers"

RSpec.describe IdedClient::TestHelpers do
  it "allows a token to be generated and decoded" do
    token = described_class.user_test_token(id: "pizza-id", user_email: "stevemctester@test.com", user_name: "steven")
    expect(token).to be_present

    payload = JWT.decode token, described_class.public_key, true, { algorithm: "RS512" }

    expect(payload[0]).to include("sub" => "pizza-id")
    expect(payload[0]).to include("user_email" => "stevemctester@test.com")
    expect(payload[0]).to include("user_name" => "steven")
  end
end
