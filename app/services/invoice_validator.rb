class InvoiceValidator
  def initialize(bill)
    @bill = bill
  end

  def check
    require 'net/http'
    require 'uri'
    require 'json'

    uri = URI.parse("https://my.api.mockaroo.com/invoices.json")
    request = Net::HTTP::Post.new(uri)
    request["X-Api-Key"] = "b490bb80"
    request.body = JSON.dump({
      "invoice_id" => @bill.invoice_number
    })

    req_options = {
      use_ssl: uri.scheme == "https",
    }

    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end
    bill_status = JSON[response.body]["status"]
    if bill_status
      @bill.status = "pending"
    else
      @bill.status = "rejected"
    end
    @bill
  end


end
