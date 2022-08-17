module Downloader

    protected def fetch(filename, destination)

        begin

            response = Request.execute(
                method: 'POST',
                url: (PineappleMK7::System::Authentication::API_URL + 'download'),
                timeout: 30,
                payload: {"filename" => filename}.to_json,
                headers: { 
                    content_type: :json, 
                    'Authorization' => ("Bearer " + PineappleMK7::System::Authentication::BEARER_TOKEN)
                },
                raw_response: true
            )

            file = response.file()

        rescue Exception => exception

            abort("Helpers::Downloader => #{filename} - #{exception.message}")

        else

            if (file.size > 0)

                FileUtils.mkdir_p(destination)
                FileUtils.mv(file.path, destination + File.basename(filename), force: true)
                return(destination + File.basename(filename))

            else

                return(false)
                
            end

        end

    end

end