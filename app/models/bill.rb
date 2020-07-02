class Bill < ApplicationRecord
  belongs_to :user
  has_many_attached :documents, :dependent => :destroy
  has_many :comments, as: :commentable, dependent: :destroy

  validates :status, presence: true

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

      on_enter do |event|
        target.status = event.to
      end

      handle FiniteMachine::InvalidStateError do |exception|
        target.errors.add(:base, :invalid_state_change, message: "invalid state change")
        raise exception
      end

    end
  end
end
