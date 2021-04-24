require "../../spec_helper"

describe HTTP::Accept::Language do
    it "parse wanted languages" do
        wanted_languages = HTTP::Accept::Language.parse("da, en-gb;q=0.8, en;q=0.7")

        wanted_languages.size.should eq 3
        wanted_languages[0].should eq HTTP::Accept::Language::Value.new(language: "da", locale: "da", q: 1.0f32)
        wanted_languages[1].should eq HTTP::Accept::Language::Value.new(language: "en-gb", locale: "en", q: 0.8f32)
        wanted_languages[2].should eq HTTP::Accept::Language::Value.new(language: "en", locale: "en", q: 0.7f32)
    end

    it "get best locale" do
        HTTP::Accept::Language.best_locale(["en", "fr"], nil).should eq "en"

        wanted_languages = HTTP::Accept::Language.parse("da, en-gb;q=0.8, en;q=0.7")

        HTTP::Accept::Language.best_locale(["en", "fr"], wanted_languages).should eq "en"
        HTTP::Accept::Language.best_locale(["en", "da"], wanted_languages).should eq "da"
        HTTP::Accept::Language.best_locale(["fr", "nl"], wanted_languages).should eq "en"
        HTTP::Accept::Language.best_locale(["fr", "nl"], wanted_languages, "fr").should eq "fr"
    end
end
