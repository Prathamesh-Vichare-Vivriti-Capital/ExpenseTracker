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
    if response.body["status"]
      @bill.manage.valid
    else
      @bill.manage.invalid
    end
    @bill
  end

end
