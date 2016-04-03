module PropLogic
  module Sat4j
    #
    # Incremental solver using Sat4j.
    #
    class IncrementalSolver

      # shorthand for Java class
      VecInt = org.sat4j.core.VecInt
      ContradictionException = Java::OrgSat4jSpecs::ContradictionException

      # constructor.
      # @param [Term] initial term for starting SAT solver.
      def initialize(initial_term)
        @solver = Java::OrgSat4jMinisat::SolverFactory.newDefault
        @solver.newVar initial_term.variables.length
        # automagically add variable in Hash
        @variables_map = Hash.new { |h, k| h[k] = h.length + 1 }
        @terms = []
        @variables = []
        @reversed_count = 0
        # true if False was added
        @contradicted = false
        add initial_term
      end

      # @return [Array] containing variables
      def variables
        @variables.dup
      end

      def term
        return False if @contradicted
        return True if @terms.empty?
        PropLogic.all_and(*@terms)
      end

      # add terms to this solver.
      # @return [IncrementalSolver] returns self
      def add(*terms)
        terms.each { |term| add_one_term term }
        self
      end

      alias_method :<<, :add

      # check if terms are satisfiable.
      # @return [Term] term satisfying conditions.
      # @return [false] if unsatisfied.
      def sat?
        return false if @contradicted
        return True if variables.empty?
        solver_vars = []
        unless @terms.empty?
          return false unless @solver.satisfiable?
          sat_model = @solver.model.to_a
          solver_vars = sat_model.map { |i| variable_from_int i }.compact
        end
        solver_true_vars = solver_vars.map do |v|
          v.is_a?(NotTerm) ? v.terms[0] : v
        end
        extra_vars = variables - solver_true_vars
        PropLogic.all_and(*solver_vars, *extra_vars)
      end

      private

      def generate_inverse_map
        return unless @reversed_count != @variables_map.length
        @reversed_vars = {}
        set_vars = @variables_map.keys & variables
        set_vars.each { |v| @reversed_vars[@variables_map[v]] = v }
      end

      def variable_from_int(num)
        generate_inverse_map
        var = @reversed_vars[num.abs]
        return unless var
        num > 0 ? var : ~var
      end

      def sat_variable(maybe_inversed_variable)
        case maybe_inversed_variable
        when Variable
          @variables_map[maybe_inversed_variable]
        when NotTerm
          -@variables_map[maybe_inversed_variable.terms[0]]
        else
          raise TypeError
        end
      end

      def add_or_term(term)
        vars = if term.is_a?(OrTerm)
                 term.terms.map { |v| sat_variable v }
               else
                 [sat_variable(term)]
               end
        @terms << term
        @solver.addClause VecInt.new(vars.to_java(Java::int))
      rescue ContradictionException
        @contradicted = true
      end

      def add_one_term(term)
        @variables |= term.variables
        term = term.to_cnf
        return if term == True
        if term == False
          @contradicted = true
          return
        end
        if term.is_a?(AndTerm)
          term.terms.each { |t| add_or_term t }
        else
          add_or_term term
        end
      end

    end
  end
end
