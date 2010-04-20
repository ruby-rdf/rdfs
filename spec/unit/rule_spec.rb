require 'spec_helper'
require 'rdf'
include RDF
#include RDFS

describe ::RDFS::Rule do
  before(:each) do
    
    class RDF1 < RDFS::Rule
      antecedent :uuu, :aaa, :yyy
      consequent :aaa, RDF.type, RDF.Property
    end
    
    @rule1 = RDF1.new
    @statement1 = Statement.new('joe:shmoe', 'rdf:jerk', 'schmuck')
    @matching_statements_1 = [@statement1]
    
    
  end
  
  context "should generate consequents from pairs of statements that match the antecedents" do
    it "without constraints" do
      @rule1[@statement1].should.eql? [Statement.new('rdf:jerk', RDF.type, RDF.property)]
    end
  end
end