module Requester

    protected def call(method, uri, payload, confirm)

        begin

            response = Request.execute(
                method: method,
                url: (PineappleMK7::System::Authentication::API_URL + uri),
                timeout: 20,
                payload: payload.to_json,
                headers: { 
                    content_type: :json, 
                    accept: :json,
                    'Authorization' => ("Bearer " + PineappleMK7::System::Authentication::BEARER_TOKEN)
                }
            )

            body = response.body

        rescue Exception => exception

            abort("Helpers::Requester => #{uri} - #{exception.message}")

        else

            if (body.include?(confirm))

                return(JSON.parse(body, object_class: OpenStruct))
            
            else

                return(body)

            end

        end

    end

end