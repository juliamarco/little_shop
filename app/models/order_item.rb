class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :item

  #
  #the following section is for the merchant index page
  #
  def self.biggest_orders
    select('order_id, sum(order_quantity)as total_quantity')
    .group(:order_id)
    .order('sum(order_quantity) DESC')
    .limit(3)
  end

  def self.fast_merch
    OrderItem.joins(item: :user)
    .select('users.username, sum(order_items.updated_at - order_items.created_at)as fulfillment_time')
    .group('users.username')
    .order('sum(order_items.updated_at - order_items.created_at) ASC')
    .limit(3)
  end

  def self.slow_merch
    OrderItem.joins(item: :user)
    .select('users.username, sum(order_items.updated_at - order_items.created_at)as fulfillment_time')
    .group('users.username')
    .order('sum(order_items.updated_at - order_items.created_at) DESC')
    .limit(3)
  end

  def self.subtotal(item_id, order)
    OrderItem.select("sum(order_price * order_quantity) as subtotal").where("order_items.item_id = #{item_id} and order_items.order_id = #{order}")[0].subtotal
  end

  def self.order_quantity(item_id, order)
    OrderItem.select("sum(order_quantity) as quantity").where("order_items.item_id = #{item_id} and order_items.order_id = #{order}")[0].quantity
  end

end
