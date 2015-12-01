module Elmas
  class Parser
    attr_accessor :parsed_json

    def initialize(json)
      @parsed_json = JSON.parse(json)
    rescue JSON::ParserError => e
      Elmas.error 'There was an error parsing the response'
      Elmas.error "#{e.class}: #{e.message}"
      @error_message = "#{e.class}: #{e.message}"
    end

    def results
      result['results'] if result && result['results']
    end

    def metadata
      result['__metadata'] if result && result['__metadata']
    end

    def result
      parsed_json['d']
    end

    def error_message
      @error_message ||= begin
        if parsed_json['error']
          parsed_json['error']['message']['value']
        end
      end
    end

    def first_result
      results[0]
    end
  end
end
