-- To add statuses to statuses table
INSERT INTO statuses (id, label) VALUES
(1, 'pending_approval'),
(2, 'approved'),
(3, 'rejected'),
(4, 'available_sale'),
(5, 'available_rent'),
(6, 'checked_out'),
(7, 'rented'),
(8, 'returned'),
(9, 'lost'),
(10, 'damaged'),
(11, 'in_repair'),
(12, 'sold'),
(13, 'out_of_stock');

-- To add roles into roles table
INSERT INTO roles (id, role_name) VALUES
(1, 'Admin'),
(2, 'Customer'),
(3, 'Vendor');

-- To add statuses to order_statuses table
INSERT INTO order_statuses (id, label, description) VALUES
(1, 'pending', 'The order is awaiting processing.'),
(2, 'processing', 'The order is being processed or packed.'),
(3, 'shipped', 'The order is in transit to the customer.'),
(4, 'delivered', 'The order has been delivered.'),
(5, 'completed', 'The order has been completed.'),
(6, 'cancelled', 'The order has been cancelled.'),
(7, 'returned', 'The order has been returned.'),
(8, 'refunded', 'The payment has been refunded.'),
(9, 'failed', 'The order processing failed.');


