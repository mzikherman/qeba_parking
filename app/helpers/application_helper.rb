module ApplicationHelper
  def is_weekend?
    # TODO: Holiday
    [0, 6].include? Time.now.wday
  end

  def within_capacity_threshhold?
    (Visit.occupied.count.to_f / QebaParking.config[:available_spaces]) > 0.6
  end
end
