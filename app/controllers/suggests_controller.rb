class SuggestsController < ApplicationController
  require 'httpclient'
  def suggest

    # ajaxで変数を受け取る処理
    @search = params[:search]
    respond_to do |format|
      format.html
      format.js
    end
    # ここまで

    base_url = "http://webservice.recruit.co.jp/carsensor/catalog/v1/"
    client = HTTPClient.new
    client.debug_dev = $stderr
    key = "ce4ccd92e2d7897e"
    car_name_search = @search
    query = { 'key' => key, 'model' => car_name_search, 'count' => 30, 'format' => "json" }
    res = client.get_content(base_url, query)
    hash = JSON.parse(res)
    list = hash["results"]["catalog"]
    @car_list = map_test(list.to_a).uniq!
  end

  def map_test(array)
    array.map do |car|
      car["model"]
    end
  end

end
