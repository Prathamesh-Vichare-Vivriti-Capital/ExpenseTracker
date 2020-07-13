module Error
  module ErrorHandler
    extend ActiveSupport::Concern
    included do

      rescue_from ActiveRecord::RecordNotFound do |e|
        respond(e.to_s, "Validation errors", :not_found)
      end

      rescue_from ActiveRecord::RecordInvalid do |e|
        respond(e.to_s, "Validation errors", 400)
      end

      rescue_from Pundit::NotAuthorizedError do |e|
        respond(:not_permitted,"You are not permitted", 401)
      end

      rescue_from CustomError do |e|
        respond(e.error,e.message,e.status)
      end

    end

    private
      def respond(error, message, status)
        render json: {error => message}.to_json, status: status
      end

  end
end
