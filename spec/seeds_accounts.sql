TRUNCATE TABLE accounts, posts RESTART IDENTITY; -- replace with your own table name.
--TRUNCATE TABLE posts RESTART IDENTITY;
-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO accounts (username, email_address) VALUES ('am305', 'annamag@email.com');
INSERT INTO accounts (username, email_address) VALUES ('bg290', 'bethgreen@email.com');

INSERT INTO posts (title, content, views, account_id) VALUES ('Thursday', 'I am happy today', 12, (SELECT id from accounts WHERE username='am305'));
INSERT INTO posts (title, content, views, account_id) VALUES ('Thursday', 'I love coding', 24, (SELECT id from accounts WHERE username='bg290'));
INSERT INTO posts (title, content, views, account_id) VALUES ('Friday', 'I am super happy today', 14, (SELECT id from accounts WHERE username='am305'));

