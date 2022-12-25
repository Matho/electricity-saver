module RulesHelper
  def cron_description(cron_rule)
    begin
      Cronex::ExpressionDescriptor.new(cron_rule).description
    rescue
      'Invalid format'
    end
  end
end
