require 'rest-client'
require 'json'

class PersonController < ApplicationController
  
  def index
    @page_title = 'People'
  end
  
  def show
    person = params[:person]
    person_response = get_person_details( person )
    unless person_response.nil?
      parsed_person_response = JSON.parse( person_response )
    
      # set up subject person stuff
      @subject_person = Person.new
      @subject_person.name = parsed_person_response["label"]
      @subject_person.description = parsed_person_response["description"]
      @subject_person.dbpedia_uri = parsed_person_response["uri"]
      
      @page_title = @subject_person.name
      
      # sets up news articles
      @articles = []
      parsed_person_response["articles"].each do |article_json|
        article = Article.new
        article.cps_id = article_json["cps_id"]
        article.headline = article_json["title"]
        article.uri = article_json["url"]
        article.published_at = article_json["published"]
        @articles << article unless @articles.size >= 20 # do this cos can't limit articles returned from api
      end
      
      # sets up cooccurent people
      @people = []
      cooccurrence_response = get_cooccurrence_details( person, 'Person' )
      parsed_cooccurrence_response = JSON.parse( cooccurrence_response )
      parsed_cooccurrence_response["co-occurrences"].each do |cooccurrent_person_json|
      	cooccurrent_person = Person.new
      	cooccurrent_person.name = cooccurrent_person_json["label"]
      	cooccurrent_person.cooccurence_count = cooccurrent_person_json["occurrence"]
      	cooccurrent_person.dbpedia_uri = cooccurrent_person_json["thing"]
      	cooccurrent_person.image_uri = cooccurrent_person_json["img"]
      	@people << cooccurrent_person
      end
      
      # sets up cooccurent organisations
      @organisations = []
      cooccurrence_response = get_cooccurrence_details( person, 'Organisation' )
      parsed_cooccurrence_response = JSON.parse( cooccurrence_response )
      parsed_cooccurrence_response["co-occurrences"].each do |cooccurrent_organisation_json|
      	cooccurrent_organisation = Organisation.new
      	cooccurrent_organisation.name = cooccurrent_organisation_json["label"]
      	cooccurrent_organisation.cooccurence_count = cooccurrent_organisation_json["occurrence"]
      	cooccurrent_organisation.dbpedia_uri = cooccurrent_organisation_json["thing"]
      	cooccurrent_organisation.image_uri = cooccurrent_organisation_json["img"]
      	@organisations << cooccurrent_organisation
      end
      unless @organisations.empty?
        @min_organisation_count = @organisations.last.cooccurence_count
        @max_organisation_count = @organisations.first.cooccurence_count
        @organisations = @organisations.sort_by { |t| t.name }
      end
      
    else
      render :template => 'oops/no_juicer'
    end

    # sets up programmes (from /programmes)
    @tv_programmes = []
    @radio_programmes = []
    programmes_response = get_programme_details( person )
    unless programmes_response.nil?
      parsed_programmes_response = JSON.parse( programmes_response )
      parsed_programmes_response["category_page"]["available_programmes"].each do |programme_json|
        programme = Programme.new
        programme.pid = programme_json["pid"]
        programme.title = programme_json["display_titles"]["title"]
        programme.subtitle = programme_json["display_titles"]["subtitle"]
        programme.synopsis = programme_json["short_synopsis"]
        if programme_json["media_type"] == 'audio'
          @radio_programmes << programme
        else
          @tv_programmes << programme
        end
      end
    end
    
#    # checks if they're a politician
#    @politician = Politician.find_by_xpedia_slug( person )
  end
  
  
  
private

  def get_programme_details( person )
    programmes_uri = "http://www.bbc.co.uk/programmes/topics/#{person}.json"
    
    r = RestClient::Request.new :url => programmes_uri, :method => :get
    begin
      r.execute
    rescue
    end
  end

  def get_person_details( person )
    juicer_uri = "http://juicer.responsivenews.co.uk/concepts/#{person}.json?basic=true"
  
    r = RestClient::Request.new :url => juicer_uri, :method => :get
    begin
      r.execute
    rescue
    end
  end
  
  def get_cooccurrence_details( person, type )
    juicer_uri = "http://juicer.responsivenews.co.uk/api/tags/co-occurrences?concept=http://dbpedia.org/resource/#{person}&type=http://dbpedia.org/ontology/#{type}&limit=9"
  
    r = RestClient::Request.new :url => juicer_uri, :method => :get
    begin
      r.execute
    rescue
    end
  end
end
