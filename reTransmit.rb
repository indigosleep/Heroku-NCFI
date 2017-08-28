require_relative './BarnhardtMessageShopify'

orderID = 2508

order = Order.find(orderID)

ack = order.acknowledgements.build()
ack.save
ackNum = ack.id

ship_notice = order.shipnotices.build()
ship_notice.save
sNoteNum = ship_notice.id

BarnhardtMessage.new(order, ackNum, sNoteNum)
