/*==============================================================*/
/* DBMS name:      PostgreSQL 8                                 */
/*==============================================================*/


drop index AIRLINES_PK;

drop table AIRLINES;

drop index SUBDIM_STATE_FK;

drop index CITIES_PK;

drop table CITIES;

drop index SUBDIM_MONTH_FK;

drop index DAYS_PK;

drop table DAYS;

drop index DIM_AIRLINE_FK;

drop index DIM_ROUTE_FK;

drop index DIM_STATE_FLIGHT_FK;

drop index DIM_TYPE_DELAY_FK;

drop index DIM_CITY_FK;

drop index DIM_TIME_FK;

drop index HECHO_VUELOS_PK;

drop table HECHO_VUELOS;

drop index SUBDIM_YEAR_FK;

drop index MONTHS_PK;

drop table MONTHS;

drop index ROUTES_PK;

drop table ROUTES;

drop index STATES_PK;

drop table STATES;

drop index STATE_FLIGHTS_PK;

drop table STATE_FLIGHTS;

drop index TYPE_DELAYS_PK;

drop table TYPE_DELAYS;

drop index YEARS_PK;

drop table YEARS;

/*==============================================================*/
/* Table: AIRLINES                                              */
/*==============================================================*/
create table AIRLINES (
   CODE_AIRLINE         VARCHAR(5)           not null,
   AIRLINE              VARCHAR(50)          not null,
   CODE_DOT             INT4                 not null,
   constraint PK_AIRLINES primary key (CODE_AIRLINE)
);

/*==============================================================*/
/* Index: AIRLINES_PK                                           */
/*==============================================================*/
create unique index AIRLINES_PK on AIRLINES (
CODE_AIRLINE
);

/*==============================================================*/
/* Table: CITIES                                                */
/*==============================================================*/
create table CITIES (
   CODE_CITY            VARCHAR(5)           not null,
   CODE_STATE           VARCHAR(5)           not null,
   NAME_CITY            VARCHAR(50)          not null,
   constraint PK_CITIES primary key (CODE_CITY)
);

/*==============================================================*/
/* Index: CITIES_PK                                             */
/*==============================================================*/
create unique index CITIES_PK on CITIES (
CODE_CITY
);

/*==============================================================*/
/* Index: SUBDIM_STATE_FK                                       */
/*==============================================================*/
create  index SUBDIM_STATE_FK on CITIES (
CODE_STATE
);

/*==============================================================*/
/* Table: DAYS                                                  */
/*==============================================================*/
create table DAYS (
   ID_DAY               VARCHAR(20)          not null,
   ID_MONTH             VARCHAR(20)          not null,
   FL_DAY               INT4                 not null,
   NAME_DAY             VARCHAR(20)          not null,
   constraint PK_DAYS primary key (ID_DAY)
);

/*==============================================================*/
/* Index: DAYS_PK                                               */
/*==============================================================*/
create unique index DAYS_PK on DAYS (
ID_DAY
);

/*==============================================================*/
/* Index: SUBDIM_MONTH_FK                                       */
/*==============================================================*/
create  index SUBDIM_MONTH_FK on DAYS (
ID_MONTH
);

/*==============================================================*/
/* Table: HECHO_VUELOS                                          */
/*==============================================================*/
create table HECHO_VUELOS (
   ID_VUELO             INT4                 not null,
   ID_DAY               VARCHAR(20)          not null,
   CODE_CITY            VARCHAR(5)           not null,
   ID_TYPE_DELAY        INT4                 not null,
   ID_STATE_FLIGHTS     INT4                 not null,
   CODE_ROUTE           VARCHAR(10)          not null,
   CODE_AIRLINE         VARCHAR(5)           not null,
   CRS_DEP_TIME         INT4                 not null,
   DEP_TIME             INT4                 not null,
   DEP_DELAY            INT4                 not null,
   TAXI_OUT             INT4                 not null,
   WHEELS_OFF           INT4                 not null,
   WHEELS_ON            INT4                 not null,
   TAXI_ON              INT4                 not null,
   CRS_ARR_TIME         INT4                 not null,
   ARR_TIME             INT4                 not null,
   ARR_DELAY            INT4                 not null,
   CRS_ELAPSED_TIME     INT4                 not null,
   ELAPSED_TIME         INT4                 not null,
   AIR_TIME             INT4                 not null,
   DISTANCE             INT4                 not null,
   TIME_DELAY           INT4                 not null,
   constraint PK_HECHO_VUELOS primary key (ID_DAY, CODE_CITY, ID_TYPE_DELAY, ID_STATE_FLIGHTS, CODE_ROUTE, CODE_AIRLINE, ID_VUELO)
);

/*==============================================================*/
/* Index: HECHO_VUELOS_PK                                       */
/*==============================================================*/
create unique index HECHO_VUELOS_PK on HECHO_VUELOS (
ID_DAY,
CODE_CITY,
ID_TYPE_DELAY,
ID_STATE_FLIGHTS,
CODE_ROUTE,
CODE_AIRLINE,
ID_VUELO
);

/*==============================================================*/
/* Index: DIM_TIME_FK                                           */
/*==============================================================*/
create  index DIM_TIME_FK on HECHO_VUELOS (
ID_DAY
);

/*==============================================================*/
/* Index: DIM_CITY_FK                                           */
/*==============================================================*/
create  index DIM_CITY_FK on HECHO_VUELOS (
CODE_CITY
);

/*==============================================================*/
/* Index: DIM_TYPE_DELAY_FK                                     */
/*==============================================================*/
create  index DIM_TYPE_DELAY_FK on HECHO_VUELOS (
ID_TYPE_DELAY
);

/*==============================================================*/
/* Index: DIM_STATE_FLIGHT_FK                                   */
/*==============================================================*/
create  index DIM_STATE_FLIGHT_FK on HECHO_VUELOS (
ID_STATE_FLIGHTS
);

/*==============================================================*/
/* Index: DIM_ROUTE_FK                                          */
/*==============================================================*/
create  index DIM_ROUTE_FK on HECHO_VUELOS (
CODE_ROUTE
);

/*==============================================================*/
/* Index: DIM_AIRLINE_FK                                        */
/*==============================================================*/
create  index DIM_AIRLINE_FK on HECHO_VUELOS (
CODE_AIRLINE
);

/*==============================================================*/
/* Table: MONTHS                                                */
/*==============================================================*/
create table MONTHS (
   ID_MONTH             VARCHAR(20)          not null,
   ID_YEAR              INT4                 not null,
   FL_MONTH             INT4                 not null,
   NAME_MONTH           VARCHAR(20)          null,
   FL_SEASON            VARCHAR(20)          not null,
   constraint PK_MONTHS primary key (ID_MONTH)
);

/*==============================================================*/
/* Index: MONTHS_PK                                             */
/*==============================================================*/
create unique index MONTHS_PK on MONTHS (
ID_MONTH
);

/*==============================================================*/
/* Index: SUBDIM_YEAR_FK                                        */
/*==============================================================*/
create  index SUBDIM_YEAR_FK on MONTHS (
ID_YEAR
);

/*==============================================================*/
/* Table: ROUTES                                                */
/*==============================================================*/
create table ROUTES (
   CODE_ROUTE           VARCHAR(10)          not null,
   FL_NUMBER            INT4                 not null,
   ROUTE                VARCHAR(100)         not null,
   constraint PK_ROUTES primary key (CODE_ROUTE)
);

/*==============================================================*/
/* Index: ROUTES_PK                                             */
/*==============================================================*/
create unique index ROUTES_PK on ROUTES (
CODE_ROUTE
);

/*==============================================================*/
/* Table: STATES                                                */
/*==============================================================*/
create table STATES (
   CODE_STATE           VARCHAR(5)           not null,
   NAME_STATE           VARCHAR(100)         not null,
   constraint PK_STATES primary key (CODE_STATE)
);

/*==============================================================*/
/* Index: STATES_PK                                             */
/*==============================================================*/
create unique index STATES_PK on STATES (
CODE_STATE
);

/*==============================================================*/
/* Table: STATE_FLIGHTS                                         */
/*==============================================================*/
create table STATE_FLIGHTS (
   ID_STATE_FLIGHTS     INT4                 not null,
   TYPE_STATE_FLIGHTS   VARCHAR(30)          not null,
   constraint PK_STATE_FLIGHTS primary key (ID_STATE_FLIGHTS)
);

/*==============================================================*/
/* Index: STATE_FLIGHTS_PK                                      */
/*==============================================================*/
create unique index STATE_FLIGHTS_PK on STATE_FLIGHTS (
ID_STATE_FLIGHTS
);

/*==============================================================*/
/* Table: TYPE_DELAYS                                           */
/*==============================================================*/
create table TYPE_DELAYS (
   ID_TYPE_DELAY        INT4                 not null,
   TYPE_DELAY           VARCHAR(30)          not null,
   constraint PK_TYPE_DELAYS primary key (ID_TYPE_DELAY)
);

/*==============================================================*/
/* Index: TYPE_DELAYS_PK                                        */
/*==============================================================*/
create unique index TYPE_DELAYS_PK on TYPE_DELAYS (
ID_TYPE_DELAY
);

/*==============================================================*/
/* Table: YEARS                                                 */
/*==============================================================*/
create table YEARS (
   ID_YEAR              INT4                 not null,
   FL_YEAR              INT4                 not null,
   constraint PK_YEARS primary key (ID_YEAR)
);

/*==============================================================*/
/* Index: YEARS_PK                                              */
/*==============================================================*/
create unique index YEARS_PK on YEARS (
ID_YEAR
);

alter table CITIES
   add constraint FK_CITIES_SUBDIM_ST_STATES foreign key (CODE_STATE)
      references STATES (CODE_STATE)
      on delete restrict on update restrict;

alter table DAYS
   add constraint FK_DAYS_SUBDIM_MO_MONTHS foreign key (ID_MONTH)
      references MONTHS (ID_MONTH)
      on delete restrict on update restrict;

alter table HECHO_VUELOS
   add constraint FK_HECHO_VU_DIM_AIRLI_AIRLINES foreign key (CODE_AIRLINE)
      references AIRLINES (CODE_AIRLINE)
      on delete restrict on update restrict;

alter table HECHO_VUELOS
   add constraint FK_HECHO_VU_DIM_CITY_CITIES foreign key (CODE_CITY)
      references CITIES (CODE_CITY)
      on delete restrict on update restrict;

alter table HECHO_VUELOS
   add constraint FK_HECHO_VU_DIM_ROUTE_ROUTES foreign key (CODE_ROUTE)
      references ROUTES (CODE_ROUTE)
      on delete restrict on update restrict;

alter table HECHO_VUELOS
   add constraint FK_HECHO_VU_DIM_STATE_STATE_FL foreign key (ID_STATE_FLIGHTS)
      references STATE_FLIGHTS (ID_STATE_FLIGHTS)
      on delete restrict on update restrict;

alter table HECHO_VUELOS
   add constraint FK_HECHO_VU_DIM_TIME_DAYS foreign key (ID_DAY)
      references DAYS (ID_DAY)
      on delete restrict on update restrict;

alter table HECHO_VUELOS
   add constraint FK_HECHO_VU_DIM_TYPE__TYPE_DEL foreign key (ID_TYPE_DELAY)
      references TYPE_DELAYS (ID_TYPE_DELAY)
      on delete restrict on update restrict;

alter table MONTHS
   add constraint FK_MONTHS_SUBDIM_YE_YEARS foreign key (ID_YEAR)
      references YEARS (ID_YEAR)
      on delete restrict on update restrict;

