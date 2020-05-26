class SuggestsController < ApplicationController
  require 'httpclient'
  def suggest
    @search = params[:keyword]
    base_url = "http://webservice.recruit.co.jp/carsensor/catalog/v1/"
    client = HTTPClient.new
    client.debug_dev = $stderr
    key = "ce4ccd92e2d7897e"
    car_name_search = @search
    query = { 'key' => key, 'model' => car_name_search, 'count' => 30, 'format' => "json" }
    res = JSON.parse(client.get_content(base_url, query))
    list = res["results"]["catalog"]
    @car_list = list.to_a.map { |car| car["model"] }.uniq!
    respond_to do |format|
      format.html
      format.json { render suggest_path, json: @car_list }
    end
  end
end
