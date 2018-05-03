drop database if exists cancomp;
create database cancomp;
use cancomp;

GRANT ALL PRIVILEGES ON cancomp.* TO 'canCompAdmin'@'localhost' IDENTIFIED BY 'candomble';

CREATE TABLE Spirit_Type
(
    tId varchar(45) PRIMARY KEY NOT NULL
);
CREATE UNIQUE INDEX Spirit_Type_tId_uindex ON Spirit_Type (tId);

CREATE TABLE Spirit
(
    sId int PRIMARY KEY NOT NULL AUTO_INCREMENT,
    sName varchar(45) NOT NULL,
    sInfo longtext NULL,
    sType varchar(45) NOT NULL,
    sDefaultPhoto varchar(255) DEFAULT "https://drive.google.com/uc?id=1u4vRa65sn9lY_REZh53AIy5If3Lodc4s" NULL,
    CONSTRAINT Spirit_Spirit_Type_tId_fk FOREIGN KEY (sType) REFERENCES Spirit_Type (tId) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE UNIQUE INDEX Spirit_sId_uindex ON Spirit (sId);

CREATE TABLE Pseudonym
(
    pId int PRIMARY KEY NOT NULL AUTO_INCREMENT,
    sId int NOT NULL,
    psuedonym varchar(45) NOT NULL,
    CONSTRAINT Psuedonym_Spirit_sId_fk FOREIGN KEY (sId) REFERENCES Spirit (sId) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE UNIQUE INDEX Psuedonym_pId_uindex ON Pseudonym (pId);

CREATE TABLE Significance
(
    sigId int PRIMARY KEY NOT NULL AUTO_INCREMENT,
    sId int NOT NULL,
    significance longtext NOT NULL,
    CONSTRAINT Significance_Spirit_sId_fk FOREIGN KEY (sId) REFERENCES Spirit (sId) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE UNIQUE INDEX Significance_sigId_uindex ON Significance (sigId);

CREATE TABLE Spirit_Relationship
(
    relId int PRIMARY KEY NOT NULL AUTO_INCREMENT,
    s1Id int NOT NULL,
    s2Id int NOT NULL,
    relationshipDesc longtext NOT NULL,
    CONSTRAINT Sprit_Relationship_Spirit_sId_fk FOREIGN KEY (s1Id) REFERENCES Spirit (sId) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT Sprit_Relationship_Spirit_sId_fk_2 FOREIGN KEY (s2Id) REFERENCES Spirit (sId) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE UNIQUE INDEX Sprit_Relationship_relId_uindex ON Spirit_Relationship (relId);

CREATE TABLE Photo
(
    pId int PRIMARY KEY NOT NULL AUTO_INCREMENT,
    sId int NOT NULL,
    pUrl varchar(255) NOT NULL,
    CONSTRAINT Photo_Spirit_sId_fk FOREIGN KEY (sId) REFERENCES Spirit (sId) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE UNIQUE INDEX Photo_pId_uindex ON Photo (pId);

INSERT INTO `cancomp`.`Spirit_Type` (`tId`) VALUES ('Orixa');
INSERT INTO `cancomp`.`Spirit_Type` (`tId`) VALUES ('Exu');
INSERT INTO `cancomp`.`Spirit_Type` (`tId`) VALUES ('Pomba Gira');
INSERT INTO `cancomp`.`Spirit_Type` (`tId`) VALUES ('Caboclo');
INSERT INTO `cancomp`.`Spirit_Type` (`tId`) VALUES ('Saint');

INSERT INTO `cancomp`.`Spirit` (`sName`, `sInfo`, `sType`, `sDefaultPhoto`) VALUES ('Logun Ede', 'Logun Ede is the child of Oxossi and Oxum. Known as the Prince of the Orixas, this spirit is one of great lineage. Beyond this, Logun Ede is known for life, growth, and transformation due to his specific relation with his parents. Half the year they spend their time with their father, and represent themselves as a male hunter, and the other half of the year is spent with their mother, as Princess of the Forest.</p><p>Logun Ede is also often rejoiced among the LGBTQ+ community, due to their gender-fluid nature. Their duality is often reflected with their two symbols, the mirror and the bow and arrow.', 'Orixa', 'https://drive.google.com/uc?id=1SJaApcbrFgc7K2lPvsx7ZfVT_F1kwhPk');
INSERT INTO `cancomp`.`Spirit` (`sName`, `sInfo`, `sType`, `sDefaultPhoto`) VALUES ('Oxossi', 'God of the hunt', 'Orixa', DEFAULT);
INSERT INTO `cancomp`.`Spirit` (`sName`, `sInfo`, `sType`, `sDefaultPhoto`) VALUES ('Oxum', 'Goddess of the ocean', 'Orixa', DEFAULT);

INSERT INTO `cancomp`.Pseudonym (`sId`, `psuedonym`) VALUES (1, 'Loro');
INSERT INTO `cancomp`.Pseudonym (`sId`, `psuedonym`) VALUES (1, 'Logun');

INSERT INTO `cancomp`.`Significance` (`sId`, `significance`) VALUES (1, 'growth');
INSERT INTO `cancomp`.`Significance` (`sId`, `significance`) VALUES (1, 'life');
INSERT INTO `cancomp`.`Significance` (`sId`, `significance`) VALUES (1, 'transformation');

INSERT INTO `cancomp`.Spirit_Relationship (`s1Id`, `s2Id`, `relationshipDesc`) VALUES (1, 2, 'Father');
INSERT INTO `cancomp`.Spirit_Relationship (`s1Id`, `s2Id`, `relationshipDesc`) VALUES (1, 3, 'Mother');
INSERT INTO `cancomp`.Spirit_Relationship (`s1Id`, `s2Id`, `relationshipDesc`) VALUES (2, 1, 'Child');
INSERT INTO `cancomp`.Spirit_Relationship (`s1Id`, `s2Id`, `relationshipDesc`) VALUES (3, 1, 'Child');

drop procedure if exists get_spirits;
DELIMITER //
create procedure get_spirits()
    begin
        select * from Spirit;
    end;
//
DELIMITER ;

drop procedure if exists get_spirit;
DELIMITER //
create procedure get_spirit(
    IN spirit_id int
)
    begin
        select *
        from Spirit
        where sId = spirit_id
        limit 1;
    end;
//
DELIMITER ;

drop procedure if exists get_pseudonyms;
DELIMITER //
create procedure get_pseudonyms(
    IN spirit_id int
)
    begin
        select *
        from Pseudonym
        where sId = spirit_id;
    end;
//
DELIMITER ;

drop procedure if exists get_relationships;
DELIMITER //
create procedure get_relationships(
    IN spirit_id int
)
    begin
        select sName, s2Id, relationshipDesc
        from Spirit, Spirit_Relationship
        where s1Id = spirit_id
        and Spirit.sId = Spirit_Relationship.s2Id;
    end;
//
DELIMITER ;

drop procedure if exists get_significance;
DELIMITER //
create procedure get_significance(
    IN spirit_id int
)
    begin
        select *
        from Significance
        where sId = spirit_id;
    end;
//
DELIMITER ;