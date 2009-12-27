RDFS.rb: RDF Schema Reasoner for Ruby
=====================================

This is a pure-Ruby forward-chaining inference engine supporting RDFS
and RDFS++ entailment rules. It is intended to be used together with the
[RDF.rb](http://rdf.rubyforge.org/) library.

### About RDF Schema (RDFS)

* <http://www.w3.org/TR/rdf-schema/>
* <http://www.w3.org/TR/rdf-mt/>
* <http://en.wikipedia.org/wiki/RDF_Schema>

Examples
--------

    require 'rdfs'

### Defining an RDFS entailment rule class

    # @see http://www.w3.org/TR/rdf-mt/#RDFRules
    class RDF1 < RDFS::Rule
      antecedent :uuu, :aaa, :yyy
      consequent :aaa, RDF.type, RDF.Property
    end

### Defining an RDFS entailment rule instance

    # @see http://www.w3.org/TR/rdf-mt/#RDFRules
    rdf1 = RDFS::Rule.new do
      antecedent :uuu, :aaa, :yyy
      consequent :aaa, RDF.type, RDF.Property
    end

Documentation
-------------

* <http://rdfs.rubyforge.org/>

Download
--------

To get a local working copy of the development repository, do:

    % git clone git://github.com/bendiken/rdfs.git

Alternatively, you can download the latest development version as a tarball
as follows:

    % wget http://github.com/bendiken/rdfs/tarball/master

Dependencies
------------

* [RDF.rb](http://rdf.rubyforge.org/) (>= 0.0.5)

Installation
------------

The recommended installation method is via RubyGems. To install the latest
official release from Gemcutter, do:

    % [sudo] gem install rdfs

Resources
---------

* <http://rdfs.rubyforge.org/>
* <http://github.com/bendiken/rdfs>
* <http://gemcutter.org/gems/rdfs>
* <http://rubyforge.org/projects/rdfs/>
* <http://raa.ruby-lang.org/project/rdfs/>

Author
------

* [Arto Bendiken](mailto:arto.bendiken@gmail.com) - <http://ar.to/>

License
-------

RDFS.rb is free and unencumbered public domain software. For more
information, see <http://unlicense.org/> or the accompanying UNLICENSE file.
