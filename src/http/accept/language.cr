module HTTP::Accept
    class Language
        alias Value = NamedTuple(language: String, locale: String, q: Float32)

        # https://tools.ietf.org/html/rfc4647#section-2.1
        LANGUAGE_RANGE = /(?<locale>[a-zA-Z]{1,8}|\*)(-([a-zA-Z0-9]{1,8}|\*))*/

        # https://tools.ietf.org/html/rfc7231#section-5.3.1
        QVALUE = /0(\.[0-9]{0,3})?|1(\.0{0,3})/

        # https://tools.ietf.org/html/rfc7231#section-5.3.1
        WEIGHT = /\s*;\s*q=(?<qvalue>#{QVALUE})/

        LANGUAGE = /(?<language>#{LANGUAGE_RANGE})(#{WEIGHT})?/

        LANGUAGE_ACCEPT = /#{LANGUAGE},?/

        def self.parse(text : String) : Array(Value)
            values = text.scan(LANGUAGE_ACCEPT).map { |md|
                qvalue : Float32
                if md["qvalue"]?
                    qvalue = md["qvalue"].to_f32
                else
                    qvalue = 1.0
                end
                value = Value.new(language: md["language"], locale: md["locale"], q: qvalue)
            }

            values.sort { |a, b| b[:q] <=> a[:q] }
        end

        def self.best_locale(locales : Array(String), wanted_languages : Array(Value)?, default_language = "en") : String
            if wanted_languages.nil?
                return default_language
            end

            current_locale = default_language
            current_q : Float32 = 0.0

            wanted_languages.as(Array(Value)).each do |l|
                if l[:q] > current_q && locales.includes?(l[:locale])
                    current_locale = l[:locale]
                    current_q = l[:q] 
                end
            end

            current_locale
        end
    end
end