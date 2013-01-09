RSpec::Matchers.define :have_all_unique_ids do 
  match do |actual|
    actual_ids = actual.map(&:id)
    actual_ids.count == actual_ids.uniq.count 
  end

  failure_message_for_should do |actual|
    "expected that #{actual_ids.count} unique ids would be #{actual_ids.uniq.count} ids "
  end

  failure_message_for_should_not do |actual|
    "expected that #{actual_ids.count} unique ids would not be #{actual_ids.uniq.count} ids "
  end

  description do
    "have #{actual_ids.count} unique ids"
  end
end