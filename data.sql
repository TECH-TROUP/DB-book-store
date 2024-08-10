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

