create table students (
                          id          INTEGER PRIMARY KEY AUTOINCREMENT,
                          first_name   varchar(32) not null,
                          middle_name  varchar(32) not null,
                          surname varchar(32) not null,
                          phone_number       varchar(32) null,
                          telegram    varchar(32) null,
                          mail       varchar(32) null,
                          git         varchar(32) null
);