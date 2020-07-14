module Error
  class BillStatusChangedError < CustomError
    def initialize
      super(:cannot_update_bill, 400, 'The bill status is either changed to approved or rejected')
    end
  end
end
