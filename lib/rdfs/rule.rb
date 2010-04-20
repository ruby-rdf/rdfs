module RDFS
  ##
  # An RDFS entailment rule.
  class Rule
    include RDF

    PLACEHOLDERS = [:aaa, :bbb, :uuu, :vvv, :xxx, :yyy]
    
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
    # Evaluates whether a rule pattern matches a set of statements.
    #
    # @param  Statement statement1
    # @param  Statement statement2
    # 
    # @return [Array<Statement>],  :consequents ([]) or nil
    def [](statement1, statement2=nil)
      if [statement1, statement2].compact.size != antecedents
        return nil
      end
      s1, p1, o1 = (statement1.subject, statement1.predicate, statement1.object rescue [nil, nil, nil])
      s2, p2, o2 = (statement2.subject, statement2.predicate, statement2.object rescue [nil, nil, nil])
      
      #now try to match the statements to the antecents.  start with the first ant.
      
      if antecedents.size == 1
        antecedent = antecedents.first
        #make a hash out of the antecedent
        pattern = antecedent.to_hash
        assignments = {}
        slots = {}
      
        #nil the placeholders
        pattern.each {|k,v| slots[k] = pattern.delete(k) if PLACEHOLDERS.include?(v) }
        
        [:subject, :object, :predicate].select {|k| pattern[k].nil?}.each {|k| 
          #grab the metasyntactic variable
          msv = slots[k]
          assignments[msv] = statement[k]
          }
      
        #match the pattern
        pattern = Statement.new(pattern)
        return false unless pattern === statement1
        return consequents_from(assignments)
      else
        pattern1, pattern2 = antecedents.collect(&:to_hash)
        slots = {}
        assignments = {}
        #nil the placeholders and store them
        pattern1.each {|k,v| (slots.merge! {"#{k}_1" => pattern1.delete(k)}) if PLACEHOLDERS.include?(v) }
        pattern2.each {|k,v| (slots.merge! {"#{k}_2" => pattern2.delete(k)}) if PLACEHOLDERS.include?(v) }
      
        #match the pattern
        pattern1, pattern2 = Statement.new(pattern1), Statement.new(pattern2)
        if (pattern1 === statement1) && (pattern2 === statement2)
          #assign slots
          [:subject, :object, :predicate].select {|k| pattern1[k].nil?}.each {|k| 
            #grab the metasyntactic variable
            msv = slots["#{k.to_s}_1"]
            assignments[msv] = statement1[k]
            }
            
          [:subject, :object, :predicate].select {|k| pattern2[k].nil?}.each {|k| 
            #grab the metasyntactic variable
            msv = slots["#{k.to_s}_2"]
            assignments[msv] = statement2[k]
            }
          return consequent_from(assignments)
        elsif (pattern1 === statement2) && (pattern2 === statement1)
          #assign slots
          [:subject, :object, :predicate].select {|k| pattern1[k].nil?}.each {|k| 
            #grab the metasyntactic variable
            msv = slots["#{k.to_s}_1"]
            assignments[msv] = statement2[k]
            }
            
          [:subject, :object, :predicate].select {|k| pattern2[k].nil?}.each {|k| 
            #grab the metasyntactic variable
            msv = slots["#{k.to_s}_2"]
            assignments[msv] = statement1[k]
            }
          return consequents_from(assignments)
        else
          return false
        end
      end
      
    end
    
    def consequents_from(assignments)
      consequent_patterns = consequents.collect(&:to_hash)
      output = []
      consequent_patterns.each_with_index {|c,i|
        c.each {|k,v| 
          #if the consequent value is a placeholder, replace that value with the assignment
          (c[k] = assignments[v]; output << c) if PLACEHOLDERS.include?(v) }        
      }
      return output
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
