require 'spec_helper'

describe NetAppManageability::API do
  it ".server_open" do
    expect(NetAppManageability::API).to respond_to(:server_open)
  end
end
