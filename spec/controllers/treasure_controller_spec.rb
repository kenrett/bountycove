require 'spec_helper'

describe TreasuresController do
  describe "POST 'create'" do
    it "routes to the 'create' action" do
      { get: "/captains/acsart/treasures/1"}. 
        should route_to controller: 'treasures',
        action: "show",
        captain_id: "acsart",
        id: "1"
    end
  end
end
