require 'spec_helper'

describe NetAppManageability::Client do
  let(:client) do
    NetAppManageability::Client.new(
      :server       => "127.0.0.1",
      :'auth-style' => 'foo',
    )
  end

  it "non-existent method" do
    expect(client).to_not respond_to(:foobar)
  end

  it "#aggr_add" do
    expect(client).to respond_to(:aggr_add)
  end
end
