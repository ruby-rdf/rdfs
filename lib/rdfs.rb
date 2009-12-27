require 'rdf'
require 'rdfs/version'

module RDFS
  include RDF

  autoload :Repository, 'rdfs/repository'
  autoload :Rule,       'rdfs/rule'
  autoload :Semantics,  'rdfs/semantics'
end
