module RDFS
  ##
  # The RDFS semantics.
  module Semantics
    ##
    # RDF entailment rule `rdf1`.
    #
    # @see http://www.w3.org/TR/rdf-mt/#RDFRules
    class RDF1 < Rule
      antecedent :uuu, :aaa, :yyy
      consequent :aaa, RDF.type, RDF.Property
    end

    ##
    # RDFS entailment rule `rdfs2` for `rdfs:domain`.
    #
    # @see http://www.w3.org/TR/rdf-mt/#RDFSRules
    class RDFS2 < Rule
      antecedent :aaa, RDFS.domain, :xxx
      antecedent :uuu, :aaa, :yyy
      consequent :uuu, RDF.type, :xxx
    end

    ##
    # RDFS entailment rule `rdfs3` for `rdfs:range`.
    #
    # @see http://www.w3.org/TR/rdf-mt/#RDFSRules
    class RDFS3 < Rule
      antecedent :aaa, RDFS.range, :xxx
      antecedent :uuu, :aaa, :vvv
      consequent :vvv, RDF.type, :xxx
    end

    ##
    # RDFS entailment rule `rdfs4a`.
    #
    # @see http://www.w3.org/TR/rdf-mt/#RDFSRules
    class RDFS4a < Rule
      antecedent :uuu, :aaa, :xxx
      consequent :uuu, RDF.type, RDFS.Resource
    end

    ##
    # RDFS entailment rule `rdfs4b`.
    #
    # @see http://www.w3.org/TR/rdf-mt/#RDFSRules
    class RDFS4b < Rule
      antecedent :uuu, :aaa, :vvv
      constraint :vvv => RDF::Node
      consequent :vvv, RDF.type, RDFS.Resource
    end

    ##
    # RDFS entailment rule `rdfs5` for `rdfs:subPropertyOf`.
    #
    # @see http://www.w3.org/TR/rdf-mt/#RDFSRules
    class RDFS5 < Rule
      antecedent :uuu, RDFS.subPropertyOf, :vvv
      antecedent :vvv, RDFS.subPropertyOf, :xxx
      consequent :uuu, RDFS.subPropertyOf, :xxx
    end

    ##
    # RDFS entailment rule `rdfs6` for `rdfs:subPropertyOf`.
    #
    # @see http://www.w3.org/TR/rdf-mt/#RDFSRules
    class RDFS6 < Rule
      antecedent :uuu, RDF.type, RDF.Property
      consequent :uuu, RDFS.subPropertyOf, :uuu
    end

    ##
    # RDFS entailment rule `rdfs7` for `rdfs:subPropertyOf`.
    #
    # @see http://www.w3.org/TR/rdf-mt/#RDFSRules
    class RDFS7 < Rule
      antecedent :aaa, RDFS.subPropertyOf, :bbb
      antecedent :uuu, :aaa, :yyy
      consequent :uuu, :bbb, :yyy
    end

    ##
    # RDFS entailment rule `rdfs8` for `rdfs:subClassOf`.
    #
    # @see http://www.w3.org/TR/rdf-mt/#RDFSRules
    class RDFS8 < Rule
      antecedent :uuu, RDF.type, RDFS.Class
      consequent :uuu, RDFS.subClassOf, RDFS.Resource
    end

    ##
    # RDFS entailment rule `rdfs9` for `rdfs:subClassOf`.
    #
    # @see http://www.w3.org/TR/rdf-mt/#RDFSRules
    class RDFS9 < Rule
      antecedent :uuu, RDFS.subClassOf, :xxx
      antecedent :vvv, RDF.type, :uuu
      consequent :vvv, RDF.type, :xxx
    end

    ##
    # RDFS entailment rule `rdfs10` for `rdfs:subClassOf`.
    #
    # @see http://www.w3.org/TR/rdf-mt/#RDFSRules
    class RDFS10 < Rule
      antecedent :uuu, RDF.type, RDFS.Class
      consequent :uuu, RDFS.subClassOf, :uuu
    end

    ##
    # RDFS entailment rule `rdfs11` for `rdfs:subClassOf`.
    #
    # @see http://www.w3.org/TR/rdf-mt/#RDFSRules
    class RDFS11 < Rule
      antecedent :uuu, RDFS.subClassOf, :vvv
      antecedent :vvv, RDFS.subClassOf, :xxx
      consequent :uuu, RDFS.subClassOf, :xxx
    end

    ##
    # RDFS entailment rule `rdfs12`.
    #
    # @see http://www.w3.org/TR/rdf-mt/#RDFSRules
    class RDFS12 < Rule
      antecedent :uuu, RDF.type, RDFS.ContainerMembershipProperty
      consequent :uuu, RDFS.subPropertyOf, RDFS.member
    end

    ##
    # RDFS entailment rule `rdfs13`.
    #
    # @see http://www.w3.org/TR/rdf-mt/#RDFSRules
    class RDFS13 < Rule
      antecedent :uuu, RDF.type, RDFS.Datatype
      consequent :uuu, RDFS.subClassOf, RDFS.Literal
    end
  end
end
