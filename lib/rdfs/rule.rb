module RDFS
  ##
  # An RDFS entailment rule.
  class Rule
    include RDF

    # @return [Array<Statement>]
    attr_reader :antecedents

    # @return [Hash{Symbol => Class}]
    attr_reader :constraints

    # @return [Array<Statement>]
    attr_reader :consequents

    ##
    # @option options [Array<Statement>]      :antecedents ([])
    # @option options [Hash{Symbol => Class}] :constraints ({})
    # @option options [Array<Statement>]      :consequents ([])
    # @yield  [rule]
    # @yieldparam [Rule]
    def initialize(options = {}, &block)
      @antecedents = (@@antecedents[self.class] || []).concat(options[:antecedents] || [])
      @constraints = (@@constraints[self.class] || {}).merge( options[:constraints] || {})
      @consequents = (@@consequents[self.class] || []).concat(options[:consequents] || [])

      if block_given?
        case block.arity
          when 1 then block.call(self)
          else instance_eval(&block)
        end
      end
    end

    ##
    # Defines an antecedent for this rule.
    #
    # @param  [Symbol, URI] s
    # @param  [Symbol, URI] p
    # @param  [Symbol, URI] o
    # @return [void]
    def antecedent(s, p, o)
      @antecedents << RDF::Statement.new(s, p, o)
    end

    ##
    # Defines a type constraint for this rule.
    #
    # @param  [Hash{Symbol => Class}] types
    # @return [void]
    def constraint(types = {})
      @constraints.merge!(types)
    end

    ##
    # Defines the consequent of this rule.
    #
    # @param  [Symbol, URI] s
    # @param  [Symbol, URI] p
    # @param  [Symbol, URI] o
    # @return [void]
    def consequent(s, p, o)
      @consequents << RDF::Statement.new(s, p, o)
    end

    protected
      @@antecedents = {} # @private
      @@constraints = {} # @private
      @@consequents = {} # @private

      ##
      # @private
      def self.inherited(subclass)
        @@antecedents[subclass] = []
        @@constraints[subclass] = {}
        @@consequents[subclass] = []
      end

      ##
      # Defines an antecedent for this rule class.
      #
      # @param  [Symbol, URI] s
      # @param  [Symbol, URI] p
      # @param  [Symbol, URI] o
      # @return [void]
      def self.antecedent(s, p, o)
        @@antecedents[self] << RDF::Statement.new(s, p, o)
      end

      ##
      # Defines a type constraint for this rule class.
      #
      # @param  [Hash{Symbol => Class}] types
      # @return [void]
      def self.constraint(types = {})
        @@constraints[self].merge!(types)
      end

      ##
      # Defines the consequent of this rule class.
      #
      # @param  [Symbol, URI] s
      # @param  [Symbol, URI] p
      # @param  [Symbol, URI] o
      # @return [void]
      def self.consequent(s, p, o)
        @@consequents[self] << RDF::Statement.new(s, p, o)
      end

  end
end
