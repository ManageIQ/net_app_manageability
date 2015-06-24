require 'spec_helper'

describe NetAppManageability::API do
  it ".server_open" do
    pending_if_not_available
    expect(NetAppManageability::API).to respond_to(:server_open)
  end
end
