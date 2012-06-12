/* Create sender */
CREATE DISKSTORE DEMOSTORE;


/* Create sender */
CREATE GATEWAYSENDER DEMOSENDER (
  REMOTEDSID 2
  ENABLEPERSISTENCE true
  DISKSTORENAME DEMOSTORE 
) SERVER GROUPS (DEMOGOUP);


/* Create receiver */
CREATE GATEWAYRECEIVER DEMORECEIVER (
  STARTPORT 7775
  ENDPORT 7780
) SERVER GROUPS (DEMOGOUP);


/* Create tables */
CREATE TABLE CALL_LOG (
  CALL_ID VARCHAR(50) NOT NULL, 
  CALL_CENTER VARCHAR(10) NOT NULL,
  CALLER_NAME VARCHAR(50) NOT NULL,
  CALL_DETAIL VARCHAR(500) NOT NULL,
  CALLED_AT TIMESTAMP NOT NULL,
  CALL_STATUS VARCHAR(10) NOT NULL,
  PRIMARY KEY (CALL_ID)
) SERVER GROUPS (DEMOGOUP) 
  GATEWAYSENDER (DEMOSENDER);

CALL SYS.START_GATEWAYSENDER ('DEMOSENDER');