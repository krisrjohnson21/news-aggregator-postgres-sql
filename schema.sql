-- If you want to run this schema repeatedly you'll need to drop
-- the table before re-creating it. Note that you'll lose any
-- data if you drop and add a table:

DROP TABLE IF EXISTS articles;

-- Define your schema here:

CREATE TABLE articles(
  id SERIAL PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  description VARCHAR(255) NOT NULL,
  url VARCHAR(255) NOT NULL
);

INSERT INTO articles(title, description, url)
  VALUES
  ('Stephon Gilmore for DPOY', 'Patriots Stephon Gilmore making case to be NFL Defensive Player of the Year', 'https://www.espn.com/blog/new-england-patriots/post/_/id/4818912/patriots-stephon-gilmore-making-case-to-be-nfl-defensive-player-of-the-year'),
  ('Scientists make advancement in certain breast cancer drugs', 'Two new drugs for advanced HER2-positive breast cancer were tested in separate studies.', 'https://www.cnn.com/2019/12/17/health/breast-cancer-drugs-her2-positive-study/index.html'),
  ('The Ringer 2020 NFL Mock Draft', 'After a historic Heisman campaign, Joe Burrow feels locked into the no. 1 slot already.', 'https://www.theringer.com/nfl/2019/12/18/21027076/nfl-mock-draft-1-0-joe-burrow-chase-young-tua-tagovailoa'),
  ('Color Hex Color Codes', 'Color-hex gives information about colors including color models (RGB,HSL,HSV and CMYK), Triadic colors.', 'https://www.color-hex.com/');
