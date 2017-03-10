require 'test_helper'
require 'json'

class MetricsControllerTest < ActionController::TestCase
  test 'Should get metric' do
    metric = metrics('metric_1_1')
    get :show, params: { id: metric.id }
    assert_response 200
    jdata = JSON.parse response.body
    assert_equal_metric_object(metric, jdata['data'])
  end

  test 'Should get drivers metric' do
    metric = metrics('metric_1_1')
    get :show, params: { driver_id: metric.driver_id, id: metric.id }
    assert_response 200
    jdata = JSON.parse response.body
    assert_equal_metric_object(metric, jdata['data'])
  end

  test 'Should not get another driver metric' do
    metric = metrics('metric_1_1')
    assert_raises(ActiveRecord::RecordNotFound) do
      get :show, params: { driver_id: 2, id: metric.id }
    end
  end

  test 'Should create metric' do
    metric_post = valid_metric_for_driver(1)
    @request.headers["Content-Type"] = 'application/vnd.api+json'
    post :create, body: metric_post.to_json
    jdata = JSON.parse response.body
    assert_response 201
    assert jdata['data'].has_key?('id')
    assert_equal_metric_json(jdata['data'], metric_post['data'])
  end

  test 'Should create metric for specifyed driver' do
    metric_post = valid_metric_for_driver(2)
    @request.headers["Content-Type"] = 'application/vnd.api+json'
    post :create, params: { driver_id: 1 }, body: metric_post.to_json
    jdata = JSON.parse response.body
    assert_response 201
    assert jdata['data'].has_key?('id')
    metric_post['data']['attributes']['driver-id'] = 1
    assert_equal_metric_json(jdata['data'], metric_post['data'])
  end

  test 'Should return 406 on post without headers' do
    metric_post = valid_metric_for_driver(1)
    post :create, body: metric_post.to_json
    assert_response 406
  end

  test 'Should get paginable metrics list' do
    get :index
    assert_response 200
    jdata = JSON.parse response.body
    assert_equal jdata['data'].count, 50
    get :index, params: { page: { number: 2 } }
    jdata = JSON.parse response.body
    assert_equal jdata['data'].count, 50
  end

  test 'Should get paginable drivers metrics list' do
    driver = drivers('driver_2')
    get :index, params: { driver_id: driver.id }
    assert_response 200
    jdata = JSON.parse response.body
    assert_equal jdata['data'].count, 50
    get :index, params: { driver_id: driver.id, page: { number: 2 } }
    jdata = JSON.parse response.body
    assert_equal jdata['data'].count, 49
  end

  test 'Should return 406 on put without headers' do
    metric = metrics('metric_1_1')
    metric_post = valid_metric_for_driver(1)
    put :update, params: { id: metric.id }, body: metric_post.to_json
    assert_response 406
  end

  test 'Should update metric' do
    metric_post = valid_metric_for_driver(2)
    metric = metrics('metric_2_1')
    @request.headers["Content-Type"] = 'application/vnd.api+json'
    put :update, params: { id: metric.id }, body: metric_post.to_json
    assert_response 200
    jdata = JSON.parse response.body
    assert_equal metric.id.to_s, jdata['data']['id']
    assert_equal_metric_json(jdata['data'], metric_post['data'])
  end

  test 'Should update drivers metric' do
    metric_post = valid_metric_for_driver(2)
    metric = metrics('metric_2_1')
    @request.headers["Content-Type"] = 'application/vnd.api+json'
    put :update, params: { driver_id: 2, id: metric.id }, body: metric_post.to_json
    assert_response 200
    jdata = JSON.parse response.body
    assert_equal metric.id.to_s, jdata['data']['id']
    assert_equal_metric_json(jdata['data'], metric_post['data'])
  end

  test 'Should not update another drivers metric' do
    metric_post = valid_metric_for_driver(2)
    metric = metrics('metric_2_1')
    @request.headers["Content-Type"] = 'application/vnd.api+json'
    assert_raises(ActiveRecord::RecordNotFound) do
      put :update, params: { driver_id: 0, id: metric.id }, body: metric_post.to_json
    end
  end

  test 'Should delete metrics' do
    mcount = Metric.count - 1
    delete :destroy, params: { id: metrics('metric_0_1').id }
    assert_response 204
    assert_equal mcount, Metric.count
  end

  test 'Should delete drivers metrics' do
    mcount = Metric.count - 1
    delete :destroy, params: { driver_id: 0, id: metrics('metric_0_1').id }
    assert_response 204
    assert_equal mcount, Metric.count
  end

  test 'Should not delete another drivers metrics' do
    mcount = Metric.count - 1
    assert_raises(ActiveRecord::RecordNotFound) do
      delete :destroy, params: { driver_id: 1, id: metrics('metric_0_1').id }
    end
  end
end
