class InvoiceValidator
  def initialize(bill)
    @bill = bill
  end

  def check
    url = 'https://my.api.mockaroo.com/invoices.json'
    conn = Faraday.new do |c|
      c.use FaradayMiddleware::ParseJson, content_type: "application/json"
      c.headers['X-API-Key']= 'b490bb80'
    end
    response = conn.post(url,{invoice_id: @bill.invoice_number}.to_json)
    return response.body["status"]
  end

end
