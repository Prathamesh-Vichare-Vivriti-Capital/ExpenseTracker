class Bill < ApplicationRecord

  belongs_to :user
  belongs_to :group_bill, optional: true
  has_many_attached :documents, :dependent => :destroy
  has_many :comments, as: :commentable, dependent: :destroy

  validates_presence_of :status, :amount, :description
  before_save :validate_invoice #, if: Proc.new{ |bill| (bill.status == "uploaded")}

  after_find do |bill|
    manage.restore!(status.to_sym) if status.present?
  end

  after_initialize do |bill|
    bill.status = manage.current
  end

  def manage
    @manage ||= FiniteMachine.new(self) do
      initial :uploaded

      event :valid, :uploaded => :pending
      event :invalid, :uploaded => :rejected
      event :approve, :pending => :approved
      event :reject, :pending => :rejected
      event :update_invoice, :pending => :uploaded

      on_enter do |event|
        target.status = event.to
      end

      handle FiniteMachine::InvalidStateError do |exception|
        raise ::Error::InvalidStateError
      end

    end
  end

  private
  def validate_invoice
    status = InvoiceValidator.new(self).check   #calling the service to valid invoice number if even
    if status
      self.manage.valid
    else
      self.manage.invalid
    end
  end
end
