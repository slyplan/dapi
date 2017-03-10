ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def assert_equal_metric_object(metric, assertion)
    assert_equal metric.id.to_s, assertion['id']
    assert_equal metric.metric_name, assertion['attributes']['metric-name']
    assert_equal metric.value, assertion['attributes']['value']
    assert_equal metric.lat.to_s, assertion['attributes']['lat']
    assert_equal metric.lon.to_s, assertion['attributes']['lon']
    assert_equal metric.timestamp, assertion['attributes']['timestamp']
    assert_equal metric.driver_id, assertion['attributes']['driver-id']
  end

  def assert_equal_metric_json(metric, assertion)
    assert_equal metric['attributes']['metric-name'],
    assertion['attributes']['metric-name']
    assert_equal metric['attributes']['value'], assertion['attributes']['value']
    assert_equal metric['attributes']['lat'], assertion['attributes']['lat']
    assert_equal metric['attributes']['lon'], assertion['attributes']['lon']
    assert_equal metric['attributes']['timestamp'], assertion['attributes']['timestamp']
    assert_equal metric['attributes']['driver-id'], assertion['attributes']['driver-id']
  end

  def valid_metric_for_driver(driver_id)
    {
      'data': {
        'type': 'metrics',
        'attributes': {
          'metric-name': 'network.api_duration.driver_message_read_accept',
          'value': '100500',
          'lat': '51.5557703',
          'lon': '-0.145981',
          'timestamp': 1489135438,
          'driver-id': driver_id
        }
      }
    }.with_indifferent_access
  end
end
