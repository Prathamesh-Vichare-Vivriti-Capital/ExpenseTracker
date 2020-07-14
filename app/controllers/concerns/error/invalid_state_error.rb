module Error
  class InvalidStateError < CustomError
    def initialize
      super(:invalid_state_error, 406, 'The state change of the bill is invalid')
    end
  end
end
