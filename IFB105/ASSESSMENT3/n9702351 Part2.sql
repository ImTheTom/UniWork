use treasurehunters;

SELECT concat(firstName, lastName) AS name, DOB, gender, email FROM Player WHERE suburb LIKE 'Sunnybank%';

SELECT pl.username, COALESCE(sum(pu.cost),0) AS total from Purchase pu right JOIN player pl on pu.username = pl.username group by username order by total desc;

SELECT username, phoneNumber FROM phonenumber WHERE username = (SELECT username FROM player ORDER BY dob ASC LIMIT 1);

SELECT badge.badgeName, player.firstName, player.lastName, player.email FROM purchase RIGHT JOIN badge ON purchase.badgeID = badge.badgeID LEFT JOIN player ON purchase.username = player.username ORDER BY badgeName ASC, firstName ASC, lastName ASC;

SELECT DISTINCT questName From quest INNER JOIN treasure ON treasure.questID = quest.questID INNER JOIN playerprogress ON playerprogress.questID = quest.questID WHERE playerprogress.progress='complete' AND treasure.type = 'common';

INSERT INTO badge(badgeName, badgeDescription) VALUES ('Fools Gold', 'Trickiest trickster in all the seas');

DELETE FROM playerprogress where progress = 'inactive';

UPDATE player SET streetNumber = '72', streetName = 'Evergreen Terrace', suburb = 'Springfield' WHERE lastName='Smith' AND streetNumber = '180' AND streetName = 'Zelda Street' AND suburb = 'Linkburb';

CREATE INDEX TreasureWebpage ON treasure(webpage);

CREATE VIEW accountDetails AS SELECT firstName, lastName, creationDateTime FROM player WHERE NOT EXISTS(Select username from playerprogress where playerprogress.username = player.username and playerprogress.progress='complete');

GRANT INSERT, DELETE ON player TO nikki;

REVOKE INSERT, DELETE ON player FROM phil;