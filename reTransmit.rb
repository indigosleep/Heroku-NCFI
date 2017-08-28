require_relative './BarnhardtMessageShopify'

orderID = 2507

order = Order.find(orderID)

ack = order.acknowledgements.build()
ack.save
ackNum = ack.id

ship_notice = order.shipnotices.build()
ship_notice.save
sNoteNum = ship_notice.id

BarnhardtMessageShopify.new(order, ackNum, sNoteNum)
