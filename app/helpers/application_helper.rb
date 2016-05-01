module ApplicationHelper
  def is_weekend?
    # TODO: Holiday
    [0, 6].include? Time.now.wday
  end
end
