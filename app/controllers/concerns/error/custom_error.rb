module Error
  class CustomError < StandardError
    attr_reader :status, :error, :message

    def initialize(_error = nil, _status = nil, _message = nil)
      @error = _error || :cannot_change_status
      @status =  _status || 406
      @message = _message || 'Bill\'s status has been changed to approved/rejected'
    end
  end
end
