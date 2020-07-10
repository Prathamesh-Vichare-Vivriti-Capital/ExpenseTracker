module Error
  class NoAccessToBillError < CustomError
    def initialize
      super(:no_access_to_bills, 400, 'Since employment status is terminated or seperated you cannot add or update bills')
    end
  end
end
