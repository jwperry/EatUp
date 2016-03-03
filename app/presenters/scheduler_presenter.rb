class SchedulerPresenter < SimpleDelegator
  attr_reader :view, :model

  def initialize(model, view)
    @view = view
    @model = model
    super(@model)
  end
end
