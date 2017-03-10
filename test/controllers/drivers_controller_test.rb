require 'test_helper'
require 'json'

class DriversControllerTest < ActionController::TestCase
  test 'Should delete drivers and its metrics' do
    dcount = Driver.count - 1
    mcount = Metric.count - 99
    delete :destroy, params: { id: drivers('driver_0').id }
    assert_response 204
    assert_equal dcount, Driver.count
    assert_equal mcount, Metric.count
  end

  test 'Should get driver' do
    driver = drivers('driver_1')
    get :show, params: { id: driver.id }
    assert_response 200
    jdata = JSON.parse response.body
    assert_equal driver.id.to_s, jdata['data']['id']
    assert_equal driver.name, jdata['data']['attributes']['name']
    assert_equal driver.license_number, jdata['data']['attributes']['license-number']
  end

  test 'Should return 406 on post without headers' do
    post_driver = { 'data'=>{'type'=>'drivers', 'attributes'=>{'name'=>'Ivan Ivanov', 'license-number'=>'12-345-67' }}}
    post :create, body: post_driver.to_json
    assert_response 406
  end

  test 'Should create driver' do
    post_driver = { 'data'=>{'type'=>'drivers', 'attributes'=>{'name'=>'Ivan Ivanov', 'license-number'=>'12-345-67' }}}
    @request.headers["Content-Type"] = 'application/vnd.api+json'
    post :create, body: post_driver.to_json
    assert_response 201
    jdata = JSON.parse response.body
    assert jdata['data'].has_key?('id')
    assert_equal post_driver['data']['attributes']['name'], jdata['data']['attributes']['name']
    assert_equal post_driver['data']['attributes']['license-number'], jdata['data']['attributes']['license-number']
  end

  test 'Should return 406 on put without headers' do
    driver = drivers('driver_1')
    post_driver = { 'data'=>{'type'=>'drivers', 'attributes'=>{'name'=>'Ivan Ivanov', 'license-number'=>'12-345-67' }}}
    put :update, params: { id: driver.id }, body: post_driver.to_json
    assert_response 406
  end

  test 'Should update driver' do
    driver = drivers('driver_2')
    post_driver = { 'data'=>{'type'=>'drivers', 'attributes'=>{'name'=>'Ivan Ivanov', 'license-number'=>'12-345-67' }}}
    @request.headers["Content-Type"] = 'application/vnd.api+json'
    put :update, params: { id: driver.id }, body: post_driver.to_json
    assert_response 200
    jdata = JSON.parse response.body
    assert_equal driver.id.to_s, jdata['data']['id']
    assert_equal post_driver['data']['attributes']['name'], jdata['data']['attributes']['name']
    assert_equal post_driver['data']['attributes']['license-number'], jdata['data']['attributes']['license-number']
  end

  test 'Should not create invald driver' do
    post_driver = { 'data'=>{'type'=>'drivers', 'attributes'=>{}}}
    @request.headers["Content-Type"] = 'application/vnd.api+json'
    post :create, body: post_driver.to_json
    assert_response 400
    jdata = JSON.parse response.body
    assert_equal jdata['errors'].count, 2
  end
end
