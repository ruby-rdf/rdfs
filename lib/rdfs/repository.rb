module RDFS
  ##
  # An RDF repository with RDFS entailment rules.
  class Repository < RDF::Repository
    include RDFS::Semantics
  end
end
