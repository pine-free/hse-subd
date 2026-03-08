
CREATE TABLE Bar_supplies
(
	quantity             integer NULL ,
	drink_ID             integer NOT NULL 
)
go



ALTER TABLE Bar_supplies
	ADD CONSTRAINT  XPKBar_supplies PRIMARY KEY (drink_ID)
go



CREATE TABLE Bartenders
(
	performance_rating   varbinary NULL ,
	staff_ID             integer NOT NULL 
)
go



ALTER TABLE Bartenders
	ADD CONSTRAINT  XPKBartenders PRIMARY KEY (staff_ID)
go



CREATE TABLE Card
(
	card_ID              char(18) NOT NULL ,
	user_ID              integer NULL ,
	balance              integer NULL 
)
go



ALTER TABLE Card
	ADD CONSTRAINT  XPKCard PRIMARY KEY (card_ID)
go



CREATE TABLE Card_Bid_within_Session
(
	session_ID           integer NOT NULL ,
	card_ID              char(18) NOT NULL ,
	bid_amount           integer NULL ,
	money_gain           integer NULL ,
	bid_ID               integer NOT NULL 
)
go



ALTER TABLE Card_Bid_within_Session
	ADD CONSTRAINT  XPKCard_Bid_within_Session PRIMARY KEY (bid_ID)
go



CREATE TABLE Cards_to_Clients_dispenser
(
	user_ID              integer NOT NULL ,
	card_ID              char(18) NOT NULL ,
	dispenser_ID         char(18) NOT NULL ,
	entry_time           datetime NULL ,
	abandon_time         datetime NULL 
)
go



ALTER TABLE Cards_to_Clients_dispenser
	ADD CONSTRAINT  XPKCards_to_Clients_dispenser PRIMARY KEY (dispenser_ID)
go



CREATE TABLE Clients
(
	user_ID              integer NOT NULL ,
	name                 varchar(20) NULL ,
	surname              varchar(20) NULL ,
	deposit              integer NULL ,
	address              varchar(20) NULL ,
	credit               integer NULL ,
	notes                varchar(20) NULL ,
	age                  integer NULL 
)
go



ALTER TABLE Clients
	ADD CONSTRAINT  XPKClients PRIMARY KEY (user_ID)
go



CREATE TABLE Dealers
(
	staff_ID             integer NOT NULL ,
	qualification        integer NULL 
)
go



ALTER TABLE Dealers
	ADD CONSTRAINT  XPKDealers PRIMARY KEY (staff_ID)
go



CREATE TABLE Drinks
(
	drink_ID             integer NOT NULL ,
	name                 varchar(20) NULL ,
	price                integer NULL ,
	volume               integer NULL ,
	category             varchar(20) NULL 
)
go



ALTER TABLE Drinks
	ADD CONSTRAINT  XPKDrinks PRIMARY KEY (drink_ID)
go



CREATE TABLE Game_types
(
	type_ID              char(18) NOT NULL ,
	game_type            varchar(20) NOT NULL ,
	isSupervised         integer NOT NULL 
)
go



ALTER TABLE Game_types
	ADD CONSTRAINT  XPKGame_types PRIMARY KEY (type_ID)
go



CREATE TABLE Orders
(
	order_ID             char(18) NOT NULL ,
	total                integer NULL ,
	order_time           datetime NULL ,
	staff_ID             integer NOT NULL 
)
go



ALTER TABLE Orders
	ADD CONSTRAINT  XPKOrders PRIMARY KEY (order_ID)
go



CREATE TABLE Security
(
	staff_ID             integer NOT NULL ,
	zone                 integer NULL 
)
go



ALTER TABLE Security
	ADD CONSTRAINT  XPKSecurity PRIMARY KEY (staff_ID)
go



CREATE TABLE Session
(
	session_ID           integer NOT NULL ,
	start_time           datetime NULL ,
	end_time             datetime NULL 
)
go



ALTER TABLE Session
	ADD CONSTRAINT  XPKSession PRIMARY KEY (session_ID)
go



CREATE TABLE Session_Tables
(
	session_ID           integer NOT NULL ,
	table_ID             integer NOT NULL ,
	staff_ID             integer NULL ,
	session_to_table_ID  char(18) NOT NULL 
)
go



ALTER TABLE Session_Tables
	ADD CONSTRAINT  XPKSession_Tables PRIMARY KEY (session_to_table_ID)
go



CREATE TABLE Split_Order_by_Card
(
	card_ID              char(18) NOT NULL ,
	split_order_ID       char(18) NOT NULL ,
	order_ID             char(18) NOT NULL ,
	drink_ID             integer NOT NULL ,
	quantity             integer NULL 
)
go



ALTER TABLE Split_Order_by_Card
	ADD CONSTRAINT  XPKCard_OrderItems_within_Order PRIMARY KEY (split_order_ID)
go



CREATE TABLE Staff
(
	staff_ID             integer NOT NULL ,
	name                 varchar(20) NULL ,
	surname              varchar(20) NULL ,
	address              varchar(20) NULL ,
	age                  integer NULL 
)
go



ALTER TABLE Staff
	ADD CONSTRAINT  XPKStaff PRIMARY KEY (staff_ID)
go



CREATE TABLE Tables
(
	table_ID             integer NOT NULL ,
	balance              integer NULL ,
	opening_time        datetime NULL ,
	closing_time         char(18) NULL ,
	type_ID              char(18) NOT NULL 
)
go



ALTER TABLE Tables
	ADD CONSTRAINT  XPKTables PRIMARY KEY (table_ID)
go



ALTER TABLE Bar_supplies
	ADD (CONSTRAINT R_77 FOREIGN KEY (drink_ID) REFERENCES Drinks (drink_ID))
go



ALTER TABLE Bartenders
	ADD (FOREIGN KEY (staff_ID) REFERENCES Staff(staff_ID) ON DELETE CASCADE)
go



ALTER TABLE Card_Bid_within_Session
	ADD (CONSTRAINT R_43 FOREIGN KEY (session_ID) REFERENCES Session (session_ID))
go



ALTER TABLE Card_Bid_within_Session
	ADD (CONSTRAINT R_45 FOREIGN KEY (card_ID) REFERENCES Card (card_ID))
go



ALTER TABLE Cards_to_Clients_dispenser
	ADD (CONSTRAINT R_52 FOREIGN KEY (user_ID) REFERENCES Clients (user_ID))
go



ALTER TABLE Cards_to_Clients_dispenser
	ADD (CONSTRAINT R_54 FOREIGN KEY (card_ID) REFERENCES Card (card_ID))
go



ALTER TABLE Dealers
	ADD (FOREIGN KEY (staff_ID) REFERENCES Staff(staff_ID) ON DELETE CASCADE)
go



ALTER TABLE Orders
	ADD (CONSTRAINT R_69 FOREIGN KEY (staff_ID) REFERENCES Bartenders (staff_ID))
go



ALTER TABLE Security
	ADD (FOREIGN KEY (staff_ID) REFERENCES Staff(staff_ID) ON DELETE CASCADE)
go



ALTER TABLE Session_Tables
	ADD (CONSTRAINT R_47 FOREIGN KEY (session_ID) REFERENCES Session (session_ID))
go



ALTER TABLE Session_Tables
	ADD (CONSTRAINT R_49 FOREIGN KEY (table_ID) REFERENCES Tables (table_ID))
go



ALTER TABLE Session_Tables
	ADD (CONSTRAINT R_62 FOREIGN KEY (staff_ID) REFERENCES Dealers (staff_ID))
go



ALTER TABLE Split_Order_by_Card
	ADD (CONSTRAINT R_64 FOREIGN KEY (card_ID) REFERENCES Card (card_ID))
go



ALTER TABLE Split_Order_by_Card
	ADD (CONSTRAINT R_65 FOREIGN KEY (order_ID) REFERENCES Orders (order_ID))
go



ALTER TABLE Split_Order_by_Card
	ADD (CONSTRAINT R_68 FOREIGN KEY (drink_ID) REFERENCES Drinks (drink_ID))
go



ALTER TABLE Tables
	ADD (CONSTRAINT R_60 FOREIGN KEY (type_ID) REFERENCES Game_types (type_ID))
go



CREATE TRIGGER tD_Bar_supplies ON Bar_supplies FOR DELETE AS
/* ERwin Builtin Trigger */
/* DELETE trigger on Bar_supplies */
BEGIN
  DECLARE  @errno   int,
           @errmsg  varchar(255)
    /* ERwin Builtin Trigger */
    /* Drinks  Bar_supplies on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00013a7a", PARENT_OWNER="", PARENT_TABLE="Drinks"
    CHILD_OWNER="", CHILD_TABLE="Bar_supplies"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_77", FK_COLUMNS="drink_ID" */
    IF EXISTS (SELECT * FROM deleted,Drinks
      WHERE
        /* %JoinFKPK(deleted,Drinks," = "," AND") */
        deleted.drink_ID = Drinks.drink_ID AND
        NOT EXISTS (
          SELECT * FROM Bar_supplies
          WHERE
            /* %JoinFKPK(Bar_supplies,Drinks," = "," AND") */
            Bar_supplies.drink_ID = Drinks.drink_ID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Bar_supplies because Drinks exists.'
      GOTO ERROR
    END


    /* ERwin Builtin Trigger */
    RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go


CREATE TRIGGER tU_Bar_supplies ON Bar_supplies FOR UPDATE AS
/* ERwin Builtin Trigger */
/* UPDATE trigger on Bar_supplies */
BEGIN
  DECLARE  @NUMROWS int,
           @nullcnt int,
           @validcnt int,
           @insdrink_ID integer,
           @errno   int,
           @errmsg  varchar(255)

  SELECT @NUMROWS = @@rowcount
  /* ERwin Builtin Trigger */
  /* Drinks  Bar_supplies on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00014692", PARENT_OWNER="", PARENT_TABLE="Drinks"
    CHILD_OWNER="", CHILD_TABLE="Bar_supplies"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_77", FK_COLUMNS="drink_ID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(drink_ID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Drinks
        WHERE
          /* %JoinFKPK(inserted,Drinks) */
          inserted.drink_ID = Drinks.drink_ID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @NUMROWS
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Bar_supplies because Drinks does not exist.'
      GOTO ERROR
    END
  END


  /* ERwin Builtin Trigger */
  RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go



CREATE TRIGGER tD_Bartenders ON Bartenders FOR DELETE AS
/* ERwin Builtin Trigger */
/* DELETE trigger on Bartenders */
BEGIN
  DECLARE  @errno   int,
           @errmsg  varchar(255)
    /* ERwin Builtin Trigger */
    /* Bartenders  Orders on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="0002019c", PARENT_OWNER="", PARENT_TABLE="Bartenders"
    CHILD_OWNER="", CHILD_TABLE="Orders"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_69", FK_COLUMNS="staff_ID" */
    IF EXISTS (
      SELECT * FROM deleted,Orders
      WHERE
        /*  %JoinFKPK(Orders,deleted," = "," AND") */
        Orders.staff_ID = deleted.staff_ID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Bartenders because Orders exists.'
      GOTO ERROR
    END

    /* ERwin Builtin Trigger */
    /* Staff  Bartenders on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Staff"
    CHILD_OWNER="", CHILD_TABLE="Bartenders"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="is_a", FK_COLUMNS="staff_ID" */
    IF EXISTS (SELECT * FROM deleted,Staff
      WHERE
        /* %JoinFKPK(deleted,Staff," = "," AND") */
        deleted.staff_ID = Staff.staff_ID AND
        NOT EXISTS (
          SELECT * FROM Bartenders
          WHERE
            /* %JoinFKPK(Bartenders,Staff," = "," AND") */
            Bartenders.staff_ID = Staff.staff_ID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Bartenders because Staff exists.'
      GOTO ERROR
    END


    /* ERwin Builtin Trigger */
    RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go


CREATE TRIGGER tU_Bartenders ON Bartenders FOR UPDATE AS
/* ERwin Builtin Trigger */
/* UPDATE trigger on Bartenders */
BEGIN
  DECLARE  @NUMROWS int,
           @nullcnt int,
           @validcnt int,
           @insstaff_ID integer,
           @errno   int,
           @errmsg  varchar(255)

  SELECT @NUMROWS = @@rowcount
  /* ERwin Builtin Trigger */
  /* Bartenders  Orders on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00022eb6", PARENT_OWNER="", PARENT_TABLE="Bartenders"
    CHILD_OWNER="", CHILD_TABLE="Orders"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_69", FK_COLUMNS="staff_ID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(staff_ID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Orders
      WHERE
        /*  %JoinFKPK(Orders,deleted," = "," AND") */
        Orders.staff_ID = deleted.staff_ID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Bartenders because Orders exists.'
      GOTO ERROR
    END
  END

  /* ERwin Builtin Trigger */
  /* Staff  Bartenders on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Staff"
    CHILD_OWNER="", CHILD_TABLE="Bartenders"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="is_a", FK_COLUMNS="staff_ID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(staff_ID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Staff
        WHERE
          /* %JoinFKPK(inserted,Staff) */
          inserted.staff_ID = Staff.staff_ID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @NUMROWS
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Bartenders because Staff does not exist.'
      GOTO ERROR
    END
  END


  /* ERwin Builtin Trigger */
  RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go



CREATE TRIGGER tD_Card ON Card FOR DELETE AS
/* ERwin Builtin Trigger */
/* DELETE trigger on Card */
BEGIN
  DECLARE  @errno   int,
           @errmsg  varchar(255)
    /* ERwin Builtin Trigger */
    /* Card  Split_Order_by_Card on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00032032", PARENT_OWNER="", PARENT_TABLE="Card"
    CHILD_OWNER="", CHILD_TABLE="Split_Order_by_Card"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_64", FK_COLUMNS="card_ID" */
    IF EXISTS (
      SELECT * FROM deleted,Split_Order_by_Card
      WHERE
        /*  %JoinFKPK(Split_Order_by_Card,deleted," = "," AND") */
        Split_Order_by_Card.card_ID = deleted.card_ID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Card because Split_Order_by_Card exists.'
      GOTO ERROR
    END

    /* ERwin Builtin Trigger */
    /* Card  Cards_to_Clients_dispenser on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Card"
    CHILD_OWNER="", CHILD_TABLE="Cards_to_Clients_dispenser"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_54", FK_COLUMNS="card_ID" */
    IF EXISTS (
      SELECT * FROM deleted,Cards_to_Clients_dispenser
      WHERE
        /*  %JoinFKPK(Cards_to_Clients_dispenser,deleted," = "," AND") */
        Cards_to_Clients_dispenser.card_ID = deleted.card_ID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Card because Cards_to_Clients_dispenser exists.'
      GOTO ERROR
    END

    /* ERwin Builtin Trigger */
    /* Card  Card_Bid_within_Session on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Card"
    CHILD_OWNER="", CHILD_TABLE="Card_Bid_within_Session"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_45", FK_COLUMNS="card_ID" */
    IF EXISTS (
      SELECT * FROM deleted,Card_Bid_within_Session
      WHERE
        /*  %JoinFKPK(Card_Bid_within_Session,deleted," = "," AND") */
        Card_Bid_within_Session.card_ID = deleted.card_ID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Card because Card_Bid_within_Session exists.'
      GOTO ERROR
    END


    /* ERwin Builtin Trigger */
    RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go


CREATE TRIGGER tU_Card ON Card FOR UPDATE AS
/* ERwin Builtin Trigger */
/* UPDATE trigger on Card */
BEGIN
  DECLARE  @NUMROWS int,
           @nullcnt int,
           @validcnt int,
           @inscard_ID char(18),
           @errno   int,
           @errmsg  varchar(255)

  SELECT @NUMROWS = @@rowcount
  /* ERwin Builtin Trigger */
  /* Card  Split_Order_by_Card on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00039227", PARENT_OWNER="", PARENT_TABLE="Card"
    CHILD_OWNER="", CHILD_TABLE="Split_Order_by_Card"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_64", FK_COLUMNS="card_ID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(card_ID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Split_Order_by_Card
      WHERE
        /*  %JoinFKPK(Split_Order_by_Card,deleted," = "," AND") */
        Split_Order_by_Card.card_ID = deleted.card_ID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Card because Split_Order_by_Card exists.'
      GOTO ERROR
    END
  END

  /* ERwin Builtin Trigger */
  /* Card  Cards_to_Clients_dispenser on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Card"
    CHILD_OWNER="", CHILD_TABLE="Cards_to_Clients_dispenser"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_54", FK_COLUMNS="card_ID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(card_ID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Cards_to_Clients_dispenser
      WHERE
        /*  %JoinFKPK(Cards_to_Clients_dispenser,deleted," = "," AND") */
        Cards_to_Clients_dispenser.card_ID = deleted.card_ID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Card because Cards_to_Clients_dispenser exists.'
      GOTO ERROR
    END
  END

  /* ERwin Builtin Trigger */
  /* Card  Card_Bid_within_Session on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Card"
    CHILD_OWNER="", CHILD_TABLE="Card_Bid_within_Session"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_45", FK_COLUMNS="card_ID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(card_ID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Card_Bid_within_Session
      WHERE
        /*  %JoinFKPK(Card_Bid_within_Session,deleted," = "," AND") */
        Card_Bid_within_Session.card_ID = deleted.card_ID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Card because Card_Bid_within_Session exists.'
      GOTO ERROR
    END
  END


  /* ERwin Builtin Trigger */
  RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go



CREATE TRIGGER tD_Card_Bid_within_Session ON Card_Bid_within_Session FOR DELETE AS
/* ERwin Builtin Trigger */
/* DELETE trigger on Card_Bid_within_Session */
BEGIN
  DECLARE  @errno   int,
           @errmsg  varchar(255)
    /* ERwin Builtin Trigger */
    /* Card  Card_Bid_within_Session on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00029038", PARENT_OWNER="", PARENT_TABLE="Card"
    CHILD_OWNER="", CHILD_TABLE="Card_Bid_within_Session"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_45", FK_COLUMNS="card_ID" */
    IF EXISTS (SELECT * FROM deleted,Card
      WHERE
        /* %JoinFKPK(deleted,Card," = "," AND") */
        deleted.card_ID = Card.card_ID AND
        NOT EXISTS (
          SELECT * FROM Card_Bid_within_Session
          WHERE
            /* %JoinFKPK(Card_Bid_within_Session,Card," = "," AND") */
            Card_Bid_within_Session.card_ID = Card.card_ID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Card_Bid_within_Session because Card exists.'
      GOTO ERROR
    END

    /* ERwin Builtin Trigger */
    /* Session  Card_Bid_within_Session on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Session"
    CHILD_OWNER="", CHILD_TABLE="Card_Bid_within_Session"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_43", FK_COLUMNS="session_ID" */
    IF EXISTS (SELECT * FROM deleted,Session
      WHERE
        /* %JoinFKPK(deleted,Session," = "," AND") */
        deleted.session_ID = Session.session_ID AND
        NOT EXISTS (
          SELECT * FROM Card_Bid_within_Session
          WHERE
            /* %JoinFKPK(Card_Bid_within_Session,Session," = "," AND") */
            Card_Bid_within_Session.session_ID = Session.session_ID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Card_Bid_within_Session because Session exists.'
      GOTO ERROR
    END


    /* ERwin Builtin Trigger */
    RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go


CREATE TRIGGER tU_Card_Bid_within_Session ON Card_Bid_within_Session FOR UPDATE AS
/* ERwin Builtin Trigger */
/* UPDATE trigger on Card_Bid_within_Session */
BEGIN
  DECLARE  @NUMROWS int,
           @nullcnt int,
           @validcnt int,
           @insbid_ID integer,
           @errno   int,
           @errmsg  varchar(255)

  SELECT @NUMROWS = @@rowcount
  /* ERwin Builtin Trigger */
  /* Card  Card_Bid_within_Session on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00029c98", PARENT_OWNER="", PARENT_TABLE="Card"
    CHILD_OWNER="", CHILD_TABLE="Card_Bid_within_Session"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_45", FK_COLUMNS="card_ID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(card_ID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Card
        WHERE
          /* %JoinFKPK(inserted,Card) */
          inserted.card_ID = Card.card_ID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @NUMROWS
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Card_Bid_within_Session because Card does not exist.'
      GOTO ERROR
    END
  END

  /* ERwin Builtin Trigger */
  /* Session  Card_Bid_within_Session on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Session"
    CHILD_OWNER="", CHILD_TABLE="Card_Bid_within_Session"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_43", FK_COLUMNS="session_ID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(session_ID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Session
        WHERE
          /* %JoinFKPK(inserted,Session) */
          inserted.session_ID = Session.session_ID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @NUMROWS
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Card_Bid_within_Session because Session does not exist.'
      GOTO ERROR
    END
  END


  /* ERwin Builtin Trigger */
  RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go



CREATE TRIGGER tD_Cards_to_Clients_dispenser ON Cards_to_Clients_dispenser FOR DELETE AS
/* ERwin Builtin Trigger */
/* DELETE trigger on Cards_to_Clients_dispenser */
BEGIN
  DECLARE  @errno   int,
           @errmsg  varchar(255)
    /* ERwin Builtin Trigger */
    /* Card  Cards_to_Clients_dispenser on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="0002948d", PARENT_OWNER="", PARENT_TABLE="Card"
    CHILD_OWNER="", CHILD_TABLE="Cards_to_Clients_dispenser"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_54", FK_COLUMNS="card_ID" */
    IF EXISTS (SELECT * FROM deleted,Card
      WHERE
        /* %JoinFKPK(deleted,Card," = "," AND") */
        deleted.card_ID = Card.card_ID AND
        NOT EXISTS (
          SELECT * FROM Cards_to_Clients_dispenser
          WHERE
            /* %JoinFKPK(Cards_to_Clients_dispenser,Card," = "," AND") */
            Cards_to_Clients_dispenser.card_ID = Card.card_ID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Cards_to_Clients_dispenser because Card exists.'
      GOTO ERROR
    END

    /* ERwin Builtin Trigger */
    /* Clients  Cards_to_Clients_dispenser on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Clients"
    CHILD_OWNER="", CHILD_TABLE="Cards_to_Clients_dispenser"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_52", FK_COLUMNS="user_ID" */
    IF EXISTS (SELECT * FROM deleted,Clients
      WHERE
        /* %JoinFKPK(deleted,Clients," = "," AND") */
        deleted.user_ID = Clients.user_ID AND
        NOT EXISTS (
          SELECT * FROM Cards_to_Clients_dispenser
          WHERE
            /* %JoinFKPK(Cards_to_Clients_dispenser,Clients," = "," AND") */
            Cards_to_Clients_dispenser.user_ID = Clients.user_ID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Cards_to_Clients_dispenser because Clients exists.'
      GOTO ERROR
    END


    /* ERwin Builtin Trigger */
    RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go


CREATE TRIGGER tU_Cards_to_Clients_dispenser ON Cards_to_Clients_dispenser FOR UPDATE AS
/* ERwin Builtin Trigger */
/* UPDATE trigger on Cards_to_Clients_dispenser */
BEGIN
  DECLARE  @NUMROWS int,
           @nullcnt int,
           @validcnt int,
           @insdispenser_ID char(18),
           @errno   int,
           @errmsg  varchar(255)

  SELECT @NUMROWS = @@rowcount
  /* ERwin Builtin Trigger */
  /* Card  Cards_to_Clients_dispenser on child update no action */
  /* ERWIN_RELATION:CHECKSUM="0002b519", PARENT_OWNER="", PARENT_TABLE="Card"
    CHILD_OWNER="", CHILD_TABLE="Cards_to_Clients_dispenser"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_54", FK_COLUMNS="card_ID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(card_ID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Card
        WHERE
          /* %JoinFKPK(inserted,Card) */
          inserted.card_ID = Card.card_ID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @NUMROWS
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Cards_to_Clients_dispenser because Card does not exist.'
      GOTO ERROR
    END
  END

  /* ERwin Builtin Trigger */
  /* Clients  Cards_to_Clients_dispenser on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Clients"
    CHILD_OWNER="", CHILD_TABLE="Cards_to_Clients_dispenser"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_52", FK_COLUMNS="user_ID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(user_ID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Clients
        WHERE
          /* %JoinFKPK(inserted,Clients) */
          inserted.user_ID = Clients.user_ID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @NUMROWS
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Cards_to_Clients_dispenser because Clients does not exist.'
      GOTO ERROR
    END
  END


  /* ERwin Builtin Trigger */
  RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go



CREATE TRIGGER tD_Clients ON Clients FOR DELETE AS
/* ERwin Builtin Trigger */
/* DELETE trigger on Clients */
BEGIN
  DECLARE  @errno   int,
           @errmsg  varchar(255)
    /* ERwin Builtin Trigger */
    /* Clients  Cards_to_Clients_dispenser on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00012251", PARENT_OWNER="", PARENT_TABLE="Clients"
    CHILD_OWNER="", CHILD_TABLE="Cards_to_Clients_dispenser"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_52", FK_COLUMNS="user_ID" */
    IF EXISTS (
      SELECT * FROM deleted,Cards_to_Clients_dispenser
      WHERE
        /*  %JoinFKPK(Cards_to_Clients_dispenser,deleted," = "," AND") */
        Cards_to_Clients_dispenser.user_ID = deleted.user_ID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Clients because Cards_to_Clients_dispenser exists.'
      GOTO ERROR
    END


    /* ERwin Builtin Trigger */
    RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go


CREATE TRIGGER tU_Clients ON Clients FOR UPDATE AS
/* ERwin Builtin Trigger */
/* UPDATE trigger on Clients */
BEGIN
  DECLARE  @NUMROWS int,
           @nullcnt int,
           @validcnt int,
           @insuser_ID integer,
           @errno   int,
           @errmsg  varchar(255)

  SELECT @NUMROWS = @@rowcount
  /* ERwin Builtin Trigger */
  /* Clients  Cards_to_Clients_dispenser on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00013169", PARENT_OWNER="", PARENT_TABLE="Clients"
    CHILD_OWNER="", CHILD_TABLE="Cards_to_Clients_dispenser"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_52", FK_COLUMNS="user_ID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(user_ID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Cards_to_Clients_dispenser
      WHERE
        /*  %JoinFKPK(Cards_to_Clients_dispenser,deleted," = "," AND") */
        Cards_to_Clients_dispenser.user_ID = deleted.user_ID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Clients because Cards_to_Clients_dispenser exists.'
      GOTO ERROR
    END
  END


  /* ERwin Builtin Trigger */
  RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go



CREATE TRIGGER tD_Dealers ON Dealers FOR DELETE AS
/* ERwin Builtin Trigger */
/* DELETE trigger on Dealers */
BEGIN
  DECLARE  @errno   int,
           @errmsg  varchar(255)
    /* ERwin Builtin Trigger */
    /* Dealers  Session_Tables on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00020082", PARENT_OWNER="", PARENT_TABLE="Dealers"
    CHILD_OWNER="", CHILD_TABLE="Session_Tables"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_62", FK_COLUMNS="staff_ID" */
    IF EXISTS (
      SELECT * FROM deleted,Session_Tables
      WHERE
        /*  %JoinFKPK(Session_Tables,deleted," = "," AND") */
        Session_Tables.staff_ID = deleted.staff_ID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Dealers because Session_Tables exists.'
      GOTO ERROR
    END

    /* ERwin Builtin Trigger */
    /* Staff  Dealers on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Staff"
    CHILD_OWNER="", CHILD_TABLE="Dealers"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="is_a", FK_COLUMNS="staff_ID" */
    IF EXISTS (SELECT * FROM deleted,Staff
      WHERE
        /* %JoinFKPK(deleted,Staff," = "," AND") */
        deleted.staff_ID = Staff.staff_ID AND
        NOT EXISTS (
          SELECT * FROM Dealers
          WHERE
            /* %JoinFKPK(Dealers,Staff," = "," AND") */
            Dealers.staff_ID = Staff.staff_ID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Dealers because Staff exists.'
      GOTO ERROR
    END


    /* ERwin Builtin Trigger */
    RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go


CREATE TRIGGER tU_Dealers ON Dealers FOR UPDATE AS
/* ERwin Builtin Trigger */
/* UPDATE trigger on Dealers */
BEGIN
  DECLARE  @NUMROWS int,
           @nullcnt int,
           @validcnt int,
           @insstaff_ID integer,
           @errno   int,
           @errmsg  varchar(255)

  SELECT @NUMROWS = @@rowcount
  /* ERwin Builtin Trigger */
  /* Dealers  Session_Tables on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00025a4a", PARENT_OWNER="", PARENT_TABLE="Dealers"
    CHILD_OWNER="", CHILD_TABLE="Session_Tables"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_62", FK_COLUMNS="staff_ID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(staff_ID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Session_Tables
      WHERE
        /*  %JoinFKPK(Session_Tables,deleted," = "," AND") */
        Session_Tables.staff_ID = deleted.staff_ID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Dealers because Session_Tables exists.'
      GOTO ERROR
    END
  END

  /* ERwin Builtin Trigger */
  /* Staff  Dealers on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Staff"
    CHILD_OWNER="", CHILD_TABLE="Dealers"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="is_a", FK_COLUMNS="staff_ID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(staff_ID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Staff
        WHERE
          /* %JoinFKPK(inserted,Staff) */
          inserted.staff_ID = Staff.staff_ID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @NUMROWS
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Dealers because Staff does not exist.'
      GOTO ERROR
    END
  END


  /* ERwin Builtin Trigger */
  RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go



CREATE TRIGGER tD_Drinks ON Drinks FOR DELETE AS
/* ERwin Builtin Trigger */
/* DELETE trigger on Drinks */
BEGIN
  DECLARE  @errno   int,
           @errmsg  varchar(255)
    /* ERwin Builtin Trigger */
    /* Drinks  Bar_supplies on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="0002103d", PARENT_OWNER="", PARENT_TABLE="Drinks"
    CHILD_OWNER="", CHILD_TABLE="Bar_supplies"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_77", FK_COLUMNS="drink_ID" */
    IF EXISTS (
      SELECT * FROM deleted,Bar_supplies
      WHERE
        /*  %JoinFKPK(Bar_supplies,deleted," = "," AND") */
        Bar_supplies.drink_ID = deleted.drink_ID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Drinks because Bar_supplies exists.'
      GOTO ERROR
    END

    /* ERwin Builtin Trigger */
    /* Drinks  Split_Order_by_Card on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Drinks"
    CHILD_OWNER="", CHILD_TABLE="Split_Order_by_Card"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_68", FK_COLUMNS="drink_ID" */
    IF EXISTS (
      SELECT * FROM deleted,Split_Order_by_Card
      WHERE
        /*  %JoinFKPK(Split_Order_by_Card,deleted," = "," AND") */
        Split_Order_by_Card.drink_ID = deleted.drink_ID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Drinks because Split_Order_by_Card exists.'
      GOTO ERROR
    END


    /* ERwin Builtin Trigger */
    RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go


CREATE TRIGGER tU_Drinks ON Drinks FOR UPDATE AS
/* ERwin Builtin Trigger */
/* UPDATE trigger on Drinks */
BEGIN
  DECLARE  @NUMROWS int,
           @nullcnt int,
           @validcnt int,
           @insdrink_ID integer,
           @errno   int,
           @errmsg  varchar(255)

  SELECT @NUMROWS = @@rowcount
  /* ERwin Builtin Trigger */
  /* Drinks  Bar_supplies on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00022fb5", PARENT_OWNER="", PARENT_TABLE="Drinks"
    CHILD_OWNER="", CHILD_TABLE="Bar_supplies"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_77", FK_COLUMNS="drink_ID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(drink_ID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Bar_supplies
      WHERE
        /*  %JoinFKPK(Bar_supplies,deleted," = "," AND") */
        Bar_supplies.drink_ID = deleted.drink_ID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Drinks because Bar_supplies exists.'
      GOTO ERROR
    END
  END

  /* ERwin Builtin Trigger */
  /* Drinks  Split_Order_by_Card on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Drinks"
    CHILD_OWNER="", CHILD_TABLE="Split_Order_by_Card"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_68", FK_COLUMNS="drink_ID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(drink_ID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Split_Order_by_Card
      WHERE
        /*  %JoinFKPK(Split_Order_by_Card,deleted," = "," AND") */
        Split_Order_by_Card.drink_ID = deleted.drink_ID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Drinks because Split_Order_by_Card exists.'
      GOTO ERROR
    END
  END


  /* ERwin Builtin Trigger */
  RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go



CREATE TRIGGER tD_Game_types ON Game_types FOR DELETE AS
/* ERwin Builtin Trigger */
/* DELETE trigger on Game_types */
BEGIN
  DECLARE  @errno   int,
           @errmsg  varchar(255)
    /* ERwin Builtin Trigger */
    /* Game_types  Tables on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="0000eff5", PARENT_OWNER="", PARENT_TABLE="Game_types"
    CHILD_OWNER="", CHILD_TABLE="Tables"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_60", FK_COLUMNS="type_ID" */
    IF EXISTS (
      SELECT * FROM deleted,Tables
      WHERE
        /*  %JoinFKPK(Tables,deleted," = "," AND") */
        Tables.type_ID = deleted.type_ID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Game_types because Tables exists.'
      GOTO ERROR
    END


    /* ERwin Builtin Trigger */
    RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go


CREATE TRIGGER tU_Game_types ON Game_types FOR UPDATE AS
/* ERwin Builtin Trigger */
/* UPDATE trigger on Game_types */
BEGIN
  DECLARE  @NUMROWS int,
           @nullcnt int,
           @validcnt int,
           @instype_ID char(18),
           @errno   int,
           @errmsg  varchar(255)

  SELECT @NUMROWS = @@rowcount
  /* ERwin Builtin Trigger */
  /* Game_types  Tables on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="0000ff83", PARENT_OWNER="", PARENT_TABLE="Game_types"
    CHILD_OWNER="", CHILD_TABLE="Tables"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_60", FK_COLUMNS="type_ID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(type_ID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Tables
      WHERE
        /*  %JoinFKPK(Tables,deleted," = "," AND") */
        Tables.type_ID = deleted.type_ID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Game_types because Tables exists.'
      GOTO ERROR
    END
  END


  /* ERwin Builtin Trigger */
  RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go



CREATE TRIGGER tD_Orders ON Orders FOR DELETE AS
/* ERwin Builtin Trigger */
/* DELETE trigger on Orders */
BEGIN
  DECLARE  @errno   int,
           @errmsg  varchar(255)
    /* ERwin Builtin Trigger */
    /* Orders  Split_Order_by_Card on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00022456", PARENT_OWNER="", PARENT_TABLE="Orders"
    CHILD_OWNER="", CHILD_TABLE="Split_Order_by_Card"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_65", FK_COLUMNS="order_ID" */
    IF EXISTS (
      SELECT * FROM deleted,Split_Order_by_Card
      WHERE
        /*  %JoinFKPK(Split_Order_by_Card,deleted," = "," AND") */
        Split_Order_by_Card.order_ID = deleted.order_ID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Orders because Split_Order_by_Card exists.'
      GOTO ERROR
    END

    /* ERwin Builtin Trigger */
    /* Bartenders  Orders on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Bartenders"
    CHILD_OWNER="", CHILD_TABLE="Orders"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_69", FK_COLUMNS="staff_ID" */
    IF EXISTS (SELECT * FROM deleted,Bartenders
      WHERE
        /* %JoinFKPK(deleted,Bartenders," = "," AND") */
        deleted.staff_ID = Bartenders.staff_ID AND
        NOT EXISTS (
          SELECT * FROM Orders
          WHERE
            /* %JoinFKPK(Orders,Bartenders," = "," AND") */
            Orders.staff_ID = Bartenders.staff_ID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Orders because Bartenders exists.'
      GOTO ERROR
    END


    /* ERwin Builtin Trigger */
    RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go


CREATE TRIGGER tU_Orders ON Orders FOR UPDATE AS
/* ERwin Builtin Trigger */
/* UPDATE trigger on Orders */
BEGIN
  DECLARE  @NUMROWS int,
           @nullcnt int,
           @validcnt int,
           @insorder_ID char(18),
           @errno   int,
           @errmsg  varchar(255)

  SELECT @NUMROWS = @@rowcount
  /* ERwin Builtin Trigger */
  /* Orders  Split_Order_by_Card on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="0002666d", PARENT_OWNER="", PARENT_TABLE="Orders"
    CHILD_OWNER="", CHILD_TABLE="Split_Order_by_Card"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_65", FK_COLUMNS="order_ID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(order_ID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Split_Order_by_Card
      WHERE
        /*  %JoinFKPK(Split_Order_by_Card,deleted," = "," AND") */
        Split_Order_by_Card.order_ID = deleted.order_ID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Orders because Split_Order_by_Card exists.'
      GOTO ERROR
    END
  END

  /* ERwin Builtin Trigger */
  /* Bartenders  Orders on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Bartenders"
    CHILD_OWNER="", CHILD_TABLE="Orders"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_69", FK_COLUMNS="staff_ID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(staff_ID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Bartenders
        WHERE
          /* %JoinFKPK(inserted,Bartenders) */
          inserted.staff_ID = Bartenders.staff_ID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @NUMROWS
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Orders because Bartenders does not exist.'
      GOTO ERROR
    END
  END


  /* ERwin Builtin Trigger */
  RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go



CREATE TRIGGER tD_Security ON Security FOR DELETE AS
/* ERwin Builtin Trigger */
/* DELETE trigger on Security */
BEGIN
  DECLARE  @errno   int,
           @errmsg  varchar(255)
    /* ERwin Builtin Trigger */
    /* Staff  Security on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00011a12", PARENT_OWNER="", PARENT_TABLE="Staff"
    CHILD_OWNER="", CHILD_TABLE="Security"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="is_a", FK_COLUMNS="staff_ID" */
    IF EXISTS (SELECT * FROM deleted,Staff
      WHERE
        /* %JoinFKPK(deleted,Staff," = "," AND") */
        deleted.staff_ID = Staff.staff_ID AND
        NOT EXISTS (
          SELECT * FROM Security
          WHERE
            /* %JoinFKPK(Security,Staff," = "," AND") */
            Security.staff_ID = Staff.staff_ID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Security because Staff exists.'
      GOTO ERROR
    END


    /* ERwin Builtin Trigger */
    RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go


CREATE TRIGGER tU_Security ON Security FOR UPDATE AS
/* ERwin Builtin Trigger */
/* UPDATE trigger on Security */
BEGIN
  DECLARE  @NUMROWS int,
           @nullcnt int,
           @validcnt int,
           @insstaff_ID integer,
           @errno   int,
           @errmsg  varchar(255)

  SELECT @NUMROWS = @@rowcount
  /* ERwin Builtin Trigger */
  /* Staff  Security on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00013265", PARENT_OWNER="", PARENT_TABLE="Staff"
    CHILD_OWNER="", CHILD_TABLE="Security"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="is_a", FK_COLUMNS="staff_ID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(staff_ID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Staff
        WHERE
          /* %JoinFKPK(inserted,Staff) */
          inserted.staff_ID = Staff.staff_ID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @NUMROWS
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Security because Staff does not exist.'
      GOTO ERROR
    END
  END


  /* ERwin Builtin Trigger */
  RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go



CREATE TRIGGER tD_Session ON Session FOR DELETE AS
/* ERwin Builtin Trigger */
/* DELETE trigger on Session */
BEGIN
  DECLARE  @errno   int,
           @errmsg  varchar(255)
    /* ERwin Builtin Trigger */
    /* Session  Session_Tables on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00021945", PARENT_OWNER="", PARENT_TABLE="Session"
    CHILD_OWNER="", CHILD_TABLE="Session_Tables"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_47", FK_COLUMNS="session_ID" */
    IF EXISTS (
      SELECT * FROM deleted,Session_Tables
      WHERE
        /*  %JoinFKPK(Session_Tables,deleted," = "," AND") */
        Session_Tables.session_ID = deleted.session_ID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Session because Session_Tables exists.'
      GOTO ERROR
    END

    /* ERwin Builtin Trigger */
    /* Session  Card_Bid_within_Session on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Session"
    CHILD_OWNER="", CHILD_TABLE="Card_Bid_within_Session"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_43", FK_COLUMNS="session_ID" */
    IF EXISTS (
      SELECT * FROM deleted,Card_Bid_within_Session
      WHERE
        /*  %JoinFKPK(Card_Bid_within_Session,deleted," = "," AND") */
        Card_Bid_within_Session.session_ID = deleted.session_ID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Session because Card_Bid_within_Session exists.'
      GOTO ERROR
    END


    /* ERwin Builtin Trigger */
    RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go


CREATE TRIGGER tU_Session ON Session FOR UPDATE AS
/* ERwin Builtin Trigger */
/* UPDATE trigger on Session */
BEGIN
  DECLARE  @NUMROWS int,
           @nullcnt int,
           @validcnt int,
           @inssession_ID integer,
           @errno   int,
           @errmsg  varchar(255)

  SELECT @NUMROWS = @@rowcount
  /* ERwin Builtin Trigger */
  /* Session  Session_Tables on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="0002497d", PARENT_OWNER="", PARENT_TABLE="Session"
    CHILD_OWNER="", CHILD_TABLE="Session_Tables"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_47", FK_COLUMNS="session_ID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(session_ID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Session_Tables
      WHERE
        /*  %JoinFKPK(Session_Tables,deleted," = "," AND") */
        Session_Tables.session_ID = deleted.session_ID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Session because Session_Tables exists.'
      GOTO ERROR
    END
  END

  /* ERwin Builtin Trigger */
  /* Session  Card_Bid_within_Session on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Session"
    CHILD_OWNER="", CHILD_TABLE="Card_Bid_within_Session"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_43", FK_COLUMNS="session_ID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(session_ID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Card_Bid_within_Session
      WHERE
        /*  %JoinFKPK(Card_Bid_within_Session,deleted," = "," AND") */
        Card_Bid_within_Session.session_ID = deleted.session_ID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Session because Card_Bid_within_Session exists.'
      GOTO ERROR
    END
  END


  /* ERwin Builtin Trigger */
  RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go



CREATE TRIGGER tD_Session_Tables ON Session_Tables FOR DELETE AS
/* ERwin Builtin Trigger */
/* DELETE trigger on Session_Tables */
BEGIN
  DECLARE  @errno   int,
           @errmsg  varchar(255)
    /* ERwin Builtin Trigger */
    /* Dealers  Session_Tables on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00038e66", PARENT_OWNER="", PARENT_TABLE="Dealers"
    CHILD_OWNER="", CHILD_TABLE="Session_Tables"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_62", FK_COLUMNS="staff_ID" */
    IF EXISTS (SELECT * FROM deleted,Dealers
      WHERE
        /* %JoinFKPK(deleted,Dealers," = "," AND") */
        deleted.staff_ID = Dealers.staff_ID AND
        NOT EXISTS (
          SELECT * FROM Session_Tables
          WHERE
            /* %JoinFKPK(Session_Tables,Dealers," = "," AND") */
            Session_Tables.staff_ID = Dealers.staff_ID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Session_Tables because Dealers exists.'
      GOTO ERROR
    END

    /* ERwin Builtin Trigger */
    /* Tables  Session_Tables on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Tables"
    CHILD_OWNER="", CHILD_TABLE="Session_Tables"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_49", FK_COLUMNS="table_ID" */
    IF EXISTS (SELECT * FROM deleted,Tables
      WHERE
        /* %JoinFKPK(deleted,Tables," = "," AND") */
        deleted.table_ID = Tables.table_ID AND
        NOT EXISTS (
          SELECT * FROM Session_Tables
          WHERE
            /* %JoinFKPK(Session_Tables,Tables," = "," AND") */
            Session_Tables.table_ID = Tables.table_ID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Session_Tables because Tables exists.'
      GOTO ERROR
    END

    /* ERwin Builtin Trigger */
    /* Session  Session_Tables on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Session"
    CHILD_OWNER="", CHILD_TABLE="Session_Tables"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_47", FK_COLUMNS="session_ID" */
    IF EXISTS (SELECT * FROM deleted,Session
      WHERE
        /* %JoinFKPK(deleted,Session," = "," AND") */
        deleted.session_ID = Session.session_ID AND
        NOT EXISTS (
          SELECT * FROM Session_Tables
          WHERE
            /* %JoinFKPK(Session_Tables,Session," = "," AND") */
            Session_Tables.session_ID = Session.session_ID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Session_Tables because Session exists.'
      GOTO ERROR
    END


    /* ERwin Builtin Trigger */
    RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go


CREATE TRIGGER tU_Session_Tables ON Session_Tables FOR UPDATE AS
/* ERwin Builtin Trigger */
/* UPDATE trigger on Session_Tables */
BEGIN
  DECLARE  @NUMROWS int,
           @nullcnt int,
           @validcnt int,
           @inssession_to_table_ID char(18),
           @errno   int,
           @errmsg  varchar(255)

  SELECT @NUMROWS = @@rowcount
  /* ERwin Builtin Trigger */
  /* Dealers  Session_Tables on child update no action */
  /* ERWIN_RELATION:CHECKSUM="0003f9d9", PARENT_OWNER="", PARENT_TABLE="Dealers"
    CHILD_OWNER="", CHILD_TABLE="Session_Tables"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_62", FK_COLUMNS="staff_ID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(staff_ID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Dealers
        WHERE
          /* %JoinFKPK(inserted,Dealers) */
          inserted.staff_ID = Dealers.staff_ID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    select @nullcnt = count(*) from inserted where
      inserted.staff_ID IS NULL
    IF @validcnt + @nullcnt != @NUMROWS
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Session_Tables because Dealers does not exist.'
      GOTO ERROR
    END
  END

  /* ERwin Builtin Trigger */
  /* Tables  Session_Tables on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Tables"
    CHILD_OWNER="", CHILD_TABLE="Session_Tables"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_49", FK_COLUMNS="table_ID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(table_ID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Tables
        WHERE
          /* %JoinFKPK(inserted,Tables) */
          inserted.table_ID = Tables.table_ID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @NUMROWS
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Session_Tables because Tables does not exist.'
      GOTO ERROR
    END
  END

  /* ERwin Builtin Trigger */
  /* Session  Session_Tables on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Session"
    CHILD_OWNER="", CHILD_TABLE="Session_Tables"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_47", FK_COLUMNS="session_ID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(session_ID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Session
        WHERE
          /* %JoinFKPK(inserted,Session) */
          inserted.session_ID = Session.session_ID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @NUMROWS
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Session_Tables because Session does not exist.'
      GOTO ERROR
    END
  END


  /* ERwin Builtin Trigger */
  RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go



CREATE TRIGGER tD_Split_Order_by_Card ON Split_Order_by_Card FOR DELETE AS
/* ERwin Builtin Trigger */
/* DELETE trigger on Split_Order_by_Card */
BEGIN
  DECLARE  @errno   int,
           @errmsg  varchar(255)
    /* ERwin Builtin Trigger */
    /* Drinks  Split_Order_by_Card on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="0003b591", PARENT_OWNER="", PARENT_TABLE="Drinks"
    CHILD_OWNER="", CHILD_TABLE="Split_Order_by_Card"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_68", FK_COLUMNS="drink_ID" */
    IF EXISTS (SELECT * FROM deleted,Drinks
      WHERE
        /* %JoinFKPK(deleted,Drinks," = "," AND") */
        deleted.drink_ID = Drinks.drink_ID AND
        NOT EXISTS (
          SELECT * FROM Split_Order_by_Card
          WHERE
            /* %JoinFKPK(Split_Order_by_Card,Drinks," = "," AND") */
            Split_Order_by_Card.drink_ID = Drinks.drink_ID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Split_Order_by_Card because Drinks exists.'
      GOTO ERROR
    END

    /* ERwin Builtin Trigger */
    /* Orders  Split_Order_by_Card on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Orders"
    CHILD_OWNER="", CHILD_TABLE="Split_Order_by_Card"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_65", FK_COLUMNS="order_ID" */
    IF EXISTS (SELECT * FROM deleted,Orders
      WHERE
        /* %JoinFKPK(deleted,Orders," = "," AND") */
        deleted.order_ID = Orders.order_ID AND
        NOT EXISTS (
          SELECT * FROM Split_Order_by_Card
          WHERE
            /* %JoinFKPK(Split_Order_by_Card,Orders," = "," AND") */
            Split_Order_by_Card.order_ID = Orders.order_ID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Split_Order_by_Card because Orders exists.'
      GOTO ERROR
    END

    /* ERwin Builtin Trigger */
    /* Card  Split_Order_by_Card on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Card"
    CHILD_OWNER="", CHILD_TABLE="Split_Order_by_Card"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_64", FK_COLUMNS="card_ID" */
    IF EXISTS (SELECT * FROM deleted,Card
      WHERE
        /* %JoinFKPK(deleted,Card," = "," AND") */
        deleted.card_ID = Card.card_ID AND
        NOT EXISTS (
          SELECT * FROM Split_Order_by_Card
          WHERE
            /* %JoinFKPK(Split_Order_by_Card,Card," = "," AND") */
            Split_Order_by_Card.card_ID = Card.card_ID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Split_Order_by_Card because Card exists.'
      GOTO ERROR
    END


    /* ERwin Builtin Trigger */
    RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go


CREATE TRIGGER tU_Split_Order_by_Card ON Split_Order_by_Card FOR UPDATE AS
/* ERwin Builtin Trigger */
/* UPDATE trigger on Split_Order_by_Card */
BEGIN
  DECLARE  @NUMROWS int,
           @nullcnt int,
           @validcnt int,
           @inssplit_order_ID char(18),
           @errno   int,
           @errmsg  varchar(255)

  SELECT @NUMROWS = @@rowcount
  /* ERwin Builtin Trigger */
  /* Drinks  Split_Order_by_Card on child update no action */
  /* ERWIN_RELATION:CHECKSUM="0003d43b", PARENT_OWNER="", PARENT_TABLE="Drinks"
    CHILD_OWNER="", CHILD_TABLE="Split_Order_by_Card"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_68", FK_COLUMNS="drink_ID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(drink_ID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Drinks
        WHERE
          /* %JoinFKPK(inserted,Drinks) */
          inserted.drink_ID = Drinks.drink_ID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @NUMROWS
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Split_Order_by_Card because Drinks does not exist.'
      GOTO ERROR
    END
  END

  /* ERwin Builtin Trigger */
  /* Orders  Split_Order_by_Card on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Orders"
    CHILD_OWNER="", CHILD_TABLE="Split_Order_by_Card"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_65", FK_COLUMNS="order_ID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(order_ID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Orders
        WHERE
          /* %JoinFKPK(inserted,Orders) */
          inserted.order_ID = Orders.order_ID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @NUMROWS
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Split_Order_by_Card because Orders does not exist.'
      GOTO ERROR
    END
  END

  /* ERwin Builtin Trigger */
  /* Card  Split_Order_by_Card on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Card"
    CHILD_OWNER="", CHILD_TABLE="Split_Order_by_Card"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_64", FK_COLUMNS="card_ID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(card_ID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Card
        WHERE
          /* %JoinFKPK(inserted,Card) */
          inserted.card_ID = Card.card_ID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @NUMROWS
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Split_Order_by_Card because Card does not exist.'
      GOTO ERROR
    END
  END


  /* ERwin Builtin Trigger */
  RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go



CREATE TRIGGER tD_Staff ON Staff FOR DELETE AS
/* ERwin Builtin Trigger */
/* DELETE trigger on Staff */
BEGIN
  DECLARE  @errno   int,
           @errmsg  varchar(255)
    /* ERwin Builtin Trigger */
    /* Staff  Bartenders on parent delete cascade */
    /* ERWIN_RELATION:CHECKSUM="000234cd", PARENT_OWNER="", PARENT_TABLE="Staff"
    CHILD_OWNER="", CHILD_TABLE="Bartenders"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="is_a", FK_COLUMNS="staff_ID" */
    DELETE Bartenders
      FROM Bartenders,deleted
      WHERE
        /*  %JoinFKPK(Bartenders,deleted," = "," AND") */
        Bartenders.staff_ID = deleted.staff_ID

    /* ERwin Builtin Trigger */
    /* Staff  Security on parent delete cascade */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Staff"
    CHILD_OWNER="", CHILD_TABLE="Security"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="is_a", FK_COLUMNS="staff_ID" */
    DELETE Security
      FROM Security,deleted
      WHERE
        /*  %JoinFKPK(Security,deleted," = "," AND") */
        Security.staff_ID = deleted.staff_ID

    /* ERwin Builtin Trigger */
    /* Staff  Dealers on parent delete cascade */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Staff"
    CHILD_OWNER="", CHILD_TABLE="Dealers"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="is_a", FK_COLUMNS="staff_ID" */
    DELETE Dealers
      FROM Dealers,deleted
      WHERE
        /*  %JoinFKPK(Dealers,deleted," = "," AND") */
        Dealers.staff_ID = deleted.staff_ID


    /* ERwin Builtin Trigger */
    RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go


CREATE TRIGGER tU_Staff ON Staff FOR UPDATE AS
/* ERwin Builtin Trigger */
/* UPDATE trigger on Staff */
BEGIN
  DECLARE  @NUMROWS int,
           @nullcnt int,
           @validcnt int,
           @insstaff_ID integer,
           @errno   int,
           @errmsg  varchar(255)

  SELECT @NUMROWS = @@rowcount
  /* ERwin Builtin Trigger */
  /* Staff  Bartenders on parent update cascade */
  /* ERWIN_RELATION:CHECKSUM="0003fd25", PARENT_OWNER="", PARENT_TABLE="Staff"
    CHILD_OWNER="", CHILD_TABLE="Bartenders"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="is_a", FK_COLUMNS="staff_ID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(staff_ID)
  BEGIN
    IF @NUMROWS = 1
    BEGIN
      SELECT @insstaff_ID = inserted.staff_ID
        FROM inserted
      UPDATE Bartenders
      SET
        /*  %JoinFKPK(Bartenders,@ins," = ",",") */
        Bartenders.staff_ID = @insstaff_ID
      FROM Bartenders,inserted,deleted
      WHERE
        /*  %JoinFKPK(Bartenders,deleted," = "," AND") */
        Bartenders.staff_ID = deleted.staff_ID
    END
    ELSE
    BEGIN
      SELECT @errno = 30006,
             @errmsg = 'Cannot cascade Staff update because more than one row has been affected.'
      GOTO ERROR
    END
  END

  /* ERwin Builtin Trigger */
  /* Staff  Security on parent update cascade */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Staff"
    CHILD_OWNER="", CHILD_TABLE="Security"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="is_a", FK_COLUMNS="staff_ID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(staff_ID)
  BEGIN
    IF @NUMROWS = 1
    BEGIN
      SELECT @insstaff_ID = inserted.staff_ID
        FROM inserted
      UPDATE Security
      SET
        /*  %JoinFKPK(Security,@ins," = ",",") */
        Security.staff_ID = @insstaff_ID
      FROM Security,inserted,deleted
      WHERE
        /*  %JoinFKPK(Security,deleted," = "," AND") */
        Security.staff_ID = deleted.staff_ID
    END
    ELSE
    BEGIN
      SELECT @errno = 30006,
             @errmsg = 'Cannot cascade Staff update because more than one row has been affected.'
      GOTO ERROR
    END
  END

  /* ERwin Builtin Trigger */
  /* Staff  Dealers on parent update cascade */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Staff"
    CHILD_OWNER="", CHILD_TABLE="Dealers"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="is_a", FK_COLUMNS="staff_ID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(staff_ID)
  BEGIN
    IF @NUMROWS = 1
    BEGIN
      SELECT @insstaff_ID = inserted.staff_ID
        FROM inserted
      UPDATE Dealers
      SET
        /*  %JoinFKPK(Dealers,@ins," = ",",") */
        Dealers.staff_ID = @insstaff_ID
      FROM Dealers,inserted,deleted
      WHERE
        /*  %JoinFKPK(Dealers,deleted," = "," AND") */
        Dealers.staff_ID = deleted.staff_ID
    END
    ELSE
    BEGIN
      SELECT @errno = 30006,
             @errmsg = 'Cannot cascade Staff update because more than one row has been affected.'
      GOTO ERROR
    END
  END


  /* ERwin Builtin Trigger */
  RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go



CREATE TRIGGER tD_Tables ON Tables FOR DELETE AS
/* ERwin Builtin Trigger */
/* DELETE trigger on Tables */
BEGIN
  DECLARE  @errno   int,
           @errmsg  varchar(255)
    /* ERwin Builtin Trigger */
    /* Tables  Session_Tables on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00021f5f", PARENT_OWNER="", PARENT_TABLE="Tables"
    CHILD_OWNER="", CHILD_TABLE="Session_Tables"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_49", FK_COLUMNS="table_ID" */
    IF EXISTS (
      SELECT * FROM deleted,Session_Tables
      WHERE
        /*  %JoinFKPK(Session_Tables,deleted," = "," AND") */
        Session_Tables.table_ID = deleted.table_ID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Tables because Session_Tables exists.'
      GOTO ERROR
    END

    /* ERwin Builtin Trigger */
    /* Game_types  Tables on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Game_types"
    CHILD_OWNER="", CHILD_TABLE="Tables"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_60", FK_COLUMNS="type_ID" */
    IF EXISTS (SELECT * FROM deleted,Game_types
      WHERE
        /* %JoinFKPK(deleted,Game_types," = "," AND") */
        deleted.type_ID = Game_types.type_ID AND
        NOT EXISTS (
          SELECT * FROM Tables
          WHERE
            /* %JoinFKPK(Tables,Game_types," = "," AND") */
            Tables.type_ID = Game_types.type_ID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Tables because Game_types exists.'
      GOTO ERROR
    END


    /* ERwin Builtin Trigger */
    RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go


CREATE TRIGGER tU_Tables ON Tables FOR UPDATE AS
/* ERwin Builtin Trigger */
/* UPDATE trigger on Tables */
BEGIN
  DECLARE  @NUMROWS int,
           @nullcnt int,
           @validcnt int,
           @instable_ID integer,
           @errno   int,
           @errmsg  varchar(255)

  SELECT @NUMROWS = @@rowcount
  /* ERwin Builtin Trigger */
  /* Tables  Session_Tables on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00025bd4", PARENT_OWNER="", PARENT_TABLE="Tables"
    CHILD_OWNER="", CHILD_TABLE="Session_Tables"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_49", FK_COLUMNS="table_ID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(table_ID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Session_Tables
      WHERE
        /*  %JoinFKPK(Session_Tables,deleted," = "," AND") */
        Session_Tables.table_ID = deleted.table_ID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Tables because Session_Tables exists.'
      GOTO ERROR
    END
  END

  /* ERwin Builtin Trigger */
  /* Game_types  Tables on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Game_types"
    CHILD_OWNER="", CHILD_TABLE="Tables"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_60", FK_COLUMNS="type_ID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(type_ID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Game_types
        WHERE
          /* %JoinFKPK(inserted,Game_types) */
          inserted.type_ID = Game_types.type_ID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @NUMROWS
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Tables because Game_types does not exist.'
      GOTO ERROR
    END
  END


  /* ERwin Builtin Trigger */
  RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go


