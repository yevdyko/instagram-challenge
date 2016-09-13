require 'rails_helper'

describe PostsController do
  it { should route(:get, '/browse').to(action: :browse) }
end
