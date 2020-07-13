module Error
  class NotAuthorizedError < CustomError
    def initialize
      super(:authorization, 401, 'Not Authorized')
    end
  end
end
