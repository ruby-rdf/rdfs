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
    
    class RDFS2 < RDFS::Rule
      antecedent :aaa, RDFS.domain, :xxx
      antecedent :uuu, :aaa, :yyy
      consequent :uuu, RDF.type, :xxx
    end
    
    @rule1 = RDF1.new
    @statement1 = Statement.new('joe:shmoe', 'rdf:jerk', 'schmuck')
    @matching_statements_1 = [@statement1]
    
    @rule2 = RDFS2.new
    @statement2 = Statement.new('rdf:jerk', RDFS.domain, FOAF.person)
    @dummy_statement2 = Statement.new('rdf:jerk', RDF.type, 'schmuck')
    @matching_statements_2 = [@statement1, @statement2]
    @dummy_statements_2 = [@statement1, @dummy_statement2]
    
    
  end
  
  context "should generate consequents from pairs of statements that match the antecedents" do
    it "with just one antecedent" do
      @rule1[@statement1].should.eql? [Statement.new('rdf:jerk', RDF.type, RDF.property)]
    end
    
    it "with multiple antecedents" do
      @rule2[*@matching_statements_2].should.eql? [Statement.new('joe:shmoe', RDF.type, FOAF.person)]
      @rule2[*(@matching_statements_2.reverse)].should.eql? [Statement.new('joe:shmoe', RDF.type, FOAF.person)]
    end
  end
  
  context "should not generate consequents from pairs of statements that don't match the antecedents" do
    it "with multiple antecedents" do
      @rule2[*@dummy_statements_2].should.eql? nil
      @rule2[*(@dummy_statements_2.reverse)].should.eql? nil
    end
  end
end