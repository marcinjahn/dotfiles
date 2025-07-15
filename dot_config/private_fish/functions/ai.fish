function ai
    begin
        set -lx GOOGLE_CLOUD_PROJECT esky-ets-hotels-ci
        gemini $argv
    end
end
