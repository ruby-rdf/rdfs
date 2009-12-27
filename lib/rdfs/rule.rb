module RDFS
  ##
  # An RDFS rule.
  class Rule
    include RDF

    ##
    # Defines an antecedent for this rule.
    #
    # @param  [Symbol, URI] s
    # @param  [Symbol, URI] p
    # @param  [Symbol, URI] o
    # @return [void]
    def self.antecedent(s, p, o)
      # TODO
    end

    ##
    # Defines a constraint for this rule.
    #
    # @param  [Hash{Symbol => Class}] types
    # @return [void]
    def self.constraint(types = {})
      # TODO
    end

    ##
    # Defines the consequent of this rule.
    #
    # @param  [Symbol, URI] s
    # @param  [Symbol, URI] p
    # @param  [Symbol, URI] o
    # @return [void]
    def self.consequent(s, p, o)
      # TODO
    end
  end
end
