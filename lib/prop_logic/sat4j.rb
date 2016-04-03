require "prop_logic/sat4j/version"
require 'java'
require 'org.sat4j.core'
require 'prop_logic'
require 'prop_logic/sat4j/incremental_solver'


module PropLogic
  module Sat4j
    module Solver
      def self.call(term)
        IncrementalSolver.new(term).sat?
      end
    end
  end
  PropLogic.sat_solver = Sat4j::Solver
  PropLogic.incremental_solver = Sat4j::IncrementalSolver
end
