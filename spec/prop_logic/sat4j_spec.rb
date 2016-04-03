require 'spec_helper'

describe PropLogic::Sat4j do
  it 'has a version number' do
    expect(PropLogic::Sat4j::VERSION).not_to be nil
  end

  it 'loads Sat4j jar' do
    expect(Java::OrgSat4jMinisat::SolverFactory).to be_a(Class)
  end
end
