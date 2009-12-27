require 'rdf'
require 'rdfs/version'

##
# RDF Schema (RDFS) support.
#
# @see http://www.w3.org/TR/rdf-schema/
module RDFS
  include RDF

  autoload :Repository, 'rdfs/repository'
  autoload :Rule,       'rdfs/rule'
  autoload :Semantics,  'rdfs/semantics'

  ##
  # @return [#to_s] property
  # @return [URI]
  def self.[](property)
    ::RDF::RDFS[property]
  end

  ##
  # @param  [Symbol] property
  # @return [URI]
  # @raise  [NoMethodError]
  def self.method_missing(property, *args, &block)
    if args.empty?
      ::RDF::RDFS[property]
    else
      super
    end
  end
end
