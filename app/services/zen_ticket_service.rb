require 'zendesk_api'

class ZenTicketService
  # attr_reader client

  def initialize
    @client = ZendeskAPI::Client.new do |config|
      config.url = "https://indigosleep.zendesk.com/api/v2"
      config.username = "sawyermerchant@gmail.com"
      config.token = "2XFgHhSkyM4sQjiGDMWGCHi14RahEBWwn6AWuPT3"
      config.retry = true
      require 'logger'
      config.logger = Logger.new(STDOUT)
    end
  end

  def getTickets
    @client.tickets.all! do |resource, page_number|
      p resource
    end
  end

  def getUsers
    p @client.users
  end

  def sendBarnhardtError(params)
    return true if Rails.env.development? || Rails.env.test?
    @client.tickets.build(
      subject: "ManufacturerAPI error Order##{params[:order_number]}",
      type: "problem",
      external_id: "#{params[:order_number]}",
      priority: "urgent",
      status: "new",
      due_at: Time.now.iso8601,
      description: "#{params[:errors]}",
      recipient: "customer@test.com",
      # assignee_id: "23814189968"
      assignee_id: "18605323288"

    ).save
  end


  def sendError(message, params)
    return true if Rails.env.development? || Rails.env.test?
    @client.tickets.build(
      subject: message,
      type: "problem",
      # external_id: "#{params[:order_number]}",
      priority: "urgent",
      status: "new",
      due_at: Time.now.iso8601,
      description: "#{params.to_h}",
      recipient: "customer@test.com",
      # assignee_id: "23814189968"
      assignee_id: "18605323288"

    ).save
  end

end