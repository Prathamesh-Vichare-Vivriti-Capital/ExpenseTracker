module Error
  class AuthenticationError < CustomError
    def initialize
      super(:invalid_credentials,401,"Check credentials")
    end
  end
end
