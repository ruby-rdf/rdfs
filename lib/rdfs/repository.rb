module RDFS
  ##
  # An RDFS repository.
  class Repository < RDF::Repository
    include RDFS::Semantics
  end
end
