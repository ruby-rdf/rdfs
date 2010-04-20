require 'rubygems'
require 'rdf'
require 'lib/rdfs/version'
# require 'lib/rdfs/semantics'
# require 'lib/rdfs/rule'
# require 'lib/rdfs/repository'

##
# RDF Schema (RDFS) support.
#
# @see http://www.w3.org/TR/rdf-schema/
module RDFS
  include RDF

  autoload :Reasoner,   'lib/rdfs/reasoner'
  autoload :Repository, 'lib/rdfs/repository'
  autoload :Rule,       'lib/rdfs/rule'
  autoload :Semantics,  'lib/rdfs/semantics'

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
