
/*                                                                                            */
/* rad3-tables.sql                                                                            */
/*                                                                                            */
/* This file was generated automatically by dumpSchema.pl on Wed Feb 12 03:59:43 EST 2003     */
/*                                                                                            */

SET ECHO ON
SPOOL rad3-tables.log

CREATE TABLE @oracle_rad3@.ACQUISITION (
    ACQUISITION_ID                     NUMBER(8)                                     NOT NULL,
    ASSAY_ID                           NUMBER(8)                                     NOT NULL,
    PROTOCOL_ID                        NUMBER(10)                                    NULL,
    CHANNEL_ID                         NUMBER(4)                                     NULL,
    ACQUISITION_DATE                   DATE                                          NULL,
    NAME                               VARCHAR2(100)                                 NULL,
    URI                                VARCHAR2(255)                                 NULL,
    MODIFICATION_DATE                  DATE                                          NOT NULL,
    USER_READ                          NUMBER(1)                                     NOT NULL,
    USER_WRITE                         NUMBER(1)                                     NOT NULL,
    GROUP_READ                         NUMBER(1)                                     NOT NULL,
    GROUP_WRITE                        NUMBER(1)                                     NOT NULL,
    OTHER_READ                         NUMBER(1)                                     NOT NULL,
    OTHER_WRITE                        NUMBER(1)                                     NOT NULL,
    ROW_USER_ID                        NUMBER(12)                                    NOT NULL,
    ROW_GROUP_ID                       NUMBER(12)                                    NOT NULL,
    ROW_PROJECT_ID                     NUMBER(12)                                    NOT NULL,
    ROW_ALG_INVOCATION_ID              NUMBER(12)                                    NOT NULL)
 TABLESPACE @oracle_rad3Tablespace@
 STORAGE (MAXEXTENTS UNLIMITED );

CREATE TABLE @oracle_rad3@.ACQUISITIONPARAM (
    ACQUISITION_PARAM_ID               NUMBER(5)                                     NOT NULL,
    ACQUISITION_ID                     NUMBER(8)                                     NOT NULL,
    NAME                               VARCHAR2(100)                                 NOT NULL,
    VALUE                              VARCHAR2(50)                                  NOT NULL,
    MODIFICATION_DATE                  DATE                                          NOT NULL,
    USER_READ                          NUMBER(1)                                     NOT NULL,
    USER_WRITE                         NUMBER(1)                                     NOT NULL,
    GROUP_READ                         NUMBER(1)                                     NOT NULL,
    GROUP_WRITE                        NUMBER(1)                                     NOT NULL,
    OTHER_READ                         NUMBER(1)                                     NOT NULL,
    OTHER_WRITE                        NUMBER(1)                                     NOT NULL,
    ROW_USER_ID                        NUMBER(12)                                    NOT NULL,
    ROW_GROUP_ID                       NUMBER(12)                                    NOT NULL,
    ROW_PROJECT_ID                     NUMBER(12)                                    NOT NULL,
    ROW_ALG_INVOCATION_ID              NUMBER(12)                                    NOT NULL)
 TABLESPACE @oracle_rad3Tablespace@
 STORAGE (MAXEXTENTS UNLIMITED );

CREATE TABLE @oracle_rad3@.ANALYSIS (
    ANALYSIS_ID                        NUMBER(5)                                     NOT NULL,
    NAME                               VARCHAR2(100)                                 NOT NULL,
    DESCRIPTION                        VARCHAR2(500)                                 NULL,
    MODIFICATION_DATE                  DATE                                          NOT NULL,
    USER_READ                          NUMBER(1)                                     NOT NULL,
    USER_WRITE                         NUMBER(1)                                     NOT NULL,
    GROUP_READ                         NUMBER(1)                                     NOT NULL,
    GROUP_WRITE                        NUMBER(1)                                     NOT NULL,
    OTHER_READ                         NUMBER(1)                                     NOT NULL,
    OTHER_WRITE                        NUMBER(1)                                     NOT NULL,
    ROW_USER_ID                        NUMBER(12)                                    NOT NULL,
    ROW_GROUP_ID                       NUMBER(12)                                    NOT NULL,
    ROW_PROJECT_ID                     NUMBER(12)                                    NOT NULL,
    ROW_ALG_INVOCATION_ID              NUMBER(12)                                    NOT NULL)
 TABLESPACE @oracle_rad3Tablespace@
 STORAGE (MAXEXTENTS UNLIMITED );

CREATE TABLE @oracle_rad3@.ANALYSISIMPLEMENTATION (
    ANALYSIS_IMPLEMENTATION_ID         NUMBER(5)                                     NOT NULL,
    ANALYSIS_ID                        NUMBER(5)                                     NOT NULL,
    NAME                               VARCHAR2(100)                                 NOT NULL,
    DESCRIPTION                        VARCHAR2(500)                                 NULL,
    MODIFICATION_DATE                  DATE                                          NOT NULL,
    USER_READ                          NUMBER(1)                                     NOT NULL,
    USER_WRITE                         NUMBER(1)                                     NOT NULL,
    GROUP_READ                         NUMBER(1)                                     NOT NULL,
    GROUP_WRITE                        NUMBER(1)                                     NOT NULL,
    OTHER_READ                         NUMBER(1)                                     NOT NULL,
    OTHER_WRITE                        NUMBER(1)                                     NOT NULL,
    ROW_USER_ID                        NUMBER(12)                                    NOT NULL,
    ROW_GROUP_ID                       NUMBER(12)                                    NOT NULL,
    ROW_PROJECT_ID                     NUMBER(12)                                    NOT NULL,
    ROW_ALG_INVOCATION_ID              NUMBER(12)                                    NOT NULL)
 TABLESPACE @oracle_rad3Tablespace@
 STORAGE (MAXEXTENTS UNLIMITED );

CREATE TABLE @oracle_rad3@.ANALYSISIMPLEMENTATIONPARAM (
    ANALYSIS_IMP_PARAM_ID              NUMBER(5)                                     NOT NULL,
    ANALYSIS_IMPLEMENTATION_ID         NUMBER(5)                                     NOT NULL,
    NAME                               VARCHAR2(100)                                 NOT NULL,
    VALUE                              VARCHAR2(100)                                 NOT NULL,
    MODIFICATION_DATE                  DATE                                          NOT NULL,
    USER_READ                          NUMBER(1)                                     NOT NULL,
    USER_WRITE                         NUMBER(1)                                     NOT NULL,
    GROUP_READ                         NUMBER(1)                                     NOT NULL,
    GROUP_WRITE                        NUMBER(1)                                     NOT NULL,
    OTHER_READ                         NUMBER(1)                                     NOT NULL,
    OTHER_WRITE                        NUMBER(1)                                     NOT NULL,
    ROW_USER_ID                        NUMBER(12)                                    NOT NULL,
    ROW_GROUP_ID                       NUMBER(12)                                    NOT NULL,
    ROW_PROJECT_ID                     NUMBER(12)                                    NOT NULL,
    ROW_ALG_INVOCATION_ID              NUMBER(12)                                    NOT NULL)
 TABLESPACE @oracle_rad3Tablespace@
 STORAGE (MAXEXTENTS UNLIMITED );

CREATE TABLE @oracle_rad3@.ANALYSISINPUT (
    ANALYSIS_INPUT_ID                  NUMBER(5)                                     NOT NULL,
    ANALYSIS_INVOCATION_ID             NUMBER(5)                                     NOT NULL,
    TABLE_ID                           NUMBER(5)                                     NULL,
    INPUT_ROW_ID                       NUMBER(10)                                    NULL,
    INPUT_VALUE                        VARCHAR2(50)                                  NULL,
    MODIFICATION_DATE                  DATE                                          NOT NULL,
    USER_READ                          NUMBER(1)                                     NOT NULL,
    USER_WRITE                         NUMBER(1)                                     NOT NULL,
    GROUP_READ                         NUMBER(1)                                     NOT NULL,
    GROUP_WRITE                        NUMBER(1)                                     NOT NULL,
    OTHER_READ                         NUMBER(1)                                     NOT NULL,
    OTHER_WRITE                        NUMBER(1)                                     NOT NULL,
    ROW_USER_ID                        NUMBER(12)                                    NOT NULL,
    ROW_GROUP_ID                       NUMBER(12)                                    NOT NULL,
    ROW_PROJECT_ID                     NUMBER(12)                                    NOT NULL,
    ROW_ALG_INVOCATION_ID              NUMBER(12)                                    NOT NULL)
 TABLESPACE @oracle_rad3Tablespace@
 STORAGE (MAXEXTENTS UNLIMITED );

CREATE TABLE @oracle_rad3@.ANALYSISINVOCATION (
    ANALYSIS_INVOCATION_ID             NUMBER(5)                                     NOT NULL,
    ANALYSIS_IMPLEMENTATION_ID         NUMBER(5)                                     NOT NULL,
    NAME                               VARCHAR2(100)                                 NOT NULL,
    DESCRIPTION                        VARCHAR2(500)                                 NULL,
    MODIFICATION_DATE                  DATE                                          NOT NULL,
    USER_READ                          NUMBER(1)                                     NOT NULL,
    USER_WRITE                         NUMBER(1)                                     NOT NULL,
    GROUP_READ                         NUMBER(1)                                     NOT NULL,
    GROUP_WRITE                        NUMBER(1)                                     NOT NULL,
    OTHER_READ                         NUMBER(1)                                     NOT NULL,
    OTHER_WRITE                        NUMBER(1)                                     NOT NULL,
    ROW_USER_ID                        NUMBER(12)                                    NOT NULL,
    ROW_GROUP_ID                       NUMBER(12)                                    NOT NULL,
    ROW_PROJECT_ID                     NUMBER(12)                                    NOT NULL,
    ROW_ALG_INVOCATION_ID              NUMBER(12)                                    NOT NULL)
 TABLESPACE @oracle_rad3Tablespace@
 STORAGE (MAXEXTENTS UNLIMITED );

CREATE TABLE @oracle_rad3@.ANALYSISINVOCATIONPARAM (
    ANALYSIS_INVOCATION_PARAM_ID       NUMBER(5)                                     NOT NULL,
    ANALYSIS_INVOCATION_ID             NUMBER(5)                                     NOT NULL,
    NAME                               VARCHAR2(100)                                 NOT NULL,
    VALUE                              VARCHAR2(100)                                 NOT NULL,
    MODIFICATION_DATE                  DATE                                          NOT NULL,
    USER_READ                          NUMBER(1)                                     NOT NULL,
    USER_WRITE                         NUMBER(1)                                     NOT NULL,
    GROUP_READ                         NUMBER(1)                                     NOT NULL,
    GROUP_WRITE                        NUMBER(1)                                     NOT NULL,
    OTHER_READ                         NUMBER(1)                                     NOT NULL,
    OTHER_WRITE                        NUMBER(1)                                     NOT NULL,
    ROW_USER_ID                        NUMBER(12)                                    NOT NULL,
    ROW_GROUP_ID                       NUMBER(12)                                    NOT NULL,
    ROW_PROJECT_ID                     NUMBER(12)                                    NOT NULL,
    ROW_ALG_INVOCATION_ID              NUMBER(12)                                    NOT NULL)
 TABLESPACE @oracle_rad3Tablespace@
 STORAGE (MAXEXTENTS UNLIMITED );

CREATE TABLE @oracle_rad3@.ANALYSISOUTPUT (
    ANALYSIS_OUTPUT_ID                 NUMBER(10)                                    NOT NULL,
    ANALYSIS_INVOCATION_ID             NUMBER(5)                                     NOT NULL,
    NAME                               VARCHAR2(100)                                 NOT NULL,
    TYPE                               VARCHAR2(50)                                  NOT NULL,
    VALUE                              NUMBER(5)                                     NOT NULL,
    MODIFICATION_DATE                  DATE                                          NOT NULL,
    USER_READ                          NUMBER(1)                                     NOT NULL,
    USER_WRITE                         NUMBER(1)                                     NOT NULL,
    GROUP_READ                         NUMBER(1)                                     NOT NULL,
    GROUP_WRITE                        NUMBER(1)                                     NOT NULL,
    OTHER_READ                         NUMBER(1)                                     NOT NULL,
    OTHER_WRITE                        NUMBER(1)                                     NOT NULL,
    ROW_USER_ID                        NUMBER(12)                                    NOT NULL,
    ROW_GROUP_ID                       NUMBER(12)                                    NOT NULL,
    ROW_PROJECT_ID                     NUMBER(12)                                    NOT NULL,
    ROW_ALG_INVOCATION_ID              NUMBER(12)                                    NOT NULL)
 TABLESPACE @oracle_rad3Tablespace@
 STORAGE (MAXEXTENTS UNLIMITED );

CREATE TABLE @oracle_rad3@.ARRAY (
    ARRAY_ID                           NUMBER(4)                                     NOT NULL,
    MANUFACTURER_ID                    NUMBER(12)                                    NOT NULL,
    PLATFORM_TYPE_ID                   NUMBER(8)                                     NOT NULL,
    SUBSTRATE_TYPE_ID                  NUMBER(8)                                     NULL,
    PROTOCOL_ID                        NUMBER(12)                                    NULL,
    EXTERNAL_DATABASE_RELEASE_ID       NUMBER(4)                                     NULL,
    SOURCE_ID                          VARCHAR2(100)                                 NULL,
    NAME                               VARCHAR2(100)                                 NOT NULL,
    VERSION                            VARCHAR2(50)                                  NULL,
    DESCRIPTION                        VARCHAR2(500)                                 NULL,
    ARRAY_DIMENSIONS                   VARCHAR2(50)                                  NULL,
    ELEMENT_DIMENSIONS                 VARCHAR2(50)                                  NULL,
    NUMBER_OF_ELEMENTS                 NUMBER(10)                                    NULL,
    NUM_ARRAY_COLUMNS                  NUMBER(3)                                     NULL,
    NUM_ARRAY_ROWS                     NUMBER(3)                                     NULL,
    NUM_GRID_COLUMNS                   NUMBER(3)                                     NULL,
    NUM_GRID_ROWS                      NUMBER(3)                                     NULL,
    NUM_SUB_COLUMNS                    NUMBER(6)                                     NULL,
    NUM_SUB_ROWS                       NUMBER(6)                                     NULL,
    MODIFICATION_DATE                  DATE                                          NOT NULL,
    USER_READ                          NUMBER(1)                                     NOT NULL,
    USER_WRITE                         NUMBER(1)                                     NOT NULL,
    GROUP_READ                         NUMBER(1)                                     NOT NULL,
    GROUP_WRITE                        NUMBER(1)                                     NOT NULL,
    OTHER_READ                         NUMBER(1)                                     NOT NULL,
    OTHER_WRITE                        NUMBER(1)                                     NOT NULL,
    ROW_USER_ID                        NUMBER(12)                                    NOT NULL,
    ROW_GROUP_ID                       NUMBER(12)                                    NOT NULL,
    ROW_PROJECT_ID                     NUMBER(12)                                    NOT NULL,
    ROW_ALG_INVOCATION_ID              NUMBER(12)                                    NOT NULL)
 TABLESPACE @oracle_rad3Tablespace@
 STORAGE (MAXEXTENTS UNLIMITED );

CREATE TABLE @oracle_rad3@.ARRAYANNOTATION (
    ARRAY_ANNOTATION_ID                NUMBER(5)                                     NOT NULL,
    ARRAY_ID                           NUMBER(4)                                     NOT NULL,
    NAME                               VARCHAR2(500)                                 NOT NULL,
    VALUE                              VARCHAR2(100)                                 NOT NULL,
    MODIFICATION_DATE                  DATE                                          NOT NULL,
    USER_READ                          NUMBER(1)                                     NOT NULL,
    USER_WRITE                         NUMBER(1)                                     NOT NULL,
    GROUP_READ                         NUMBER(1)                                     NOT NULL,
    GROUP_WRITE                        NUMBER(1)                                     NOT NULL,
    OTHER_READ                         NUMBER(1)                                     NOT NULL,
    OTHER_WRITE                        NUMBER(1)                                     NOT NULL,
    ROW_USER_ID                        NUMBER(12)                                    NOT NULL,
    ROW_GROUP_ID                       NUMBER(12)                                    NOT NULL,
    ROW_PROJECT_ID                     NUMBER(12)                                    NOT NULL,
    ROW_ALG_INVOCATION_ID              NUMBER(12)                                    NOT NULL)
 TABLESPACE @oracle_rad3Tablespace@
 STORAGE (MAXEXTENTS UNLIMITED );

CREATE TABLE @oracle_rad3@.ASSAY (
    ASSAY_ID                           NUMBER(8)                                     NOT NULL,
    ARRAY_ID                           NUMBER(4)                                     NOT NULL,
    PROTOCOL_ID                        NUMBER(10)                                    NULL,
    ASSAY_DATE                         DATE                                          NULL,
    ARRAY_IDENTIFIER                   VARCHAR2(100)                                 NULL,
    ARRAY_BATCH_IDENTIFIER             VARCHAR2(100)                                 NULL,
    OPERATOR_ID                        NUMBER(10)                                    NOT NULL,
    EXTERNAL_DATABASE_RELEASE_ID       NUMBER(5)                                     NULL,
    SOURCE_ID                          VARCHAR2(50)                                  NULL,
    NAME                               VARCHAR2(100)                                 NULL,
    DESCRIPTION                        VARCHAR2(500)                                 NULL,
    MODIFICATION_DATE                  DATE                                          NOT NULL,
    USER_READ                          NUMBER(1)                                     NOT NULL,
    USER_WRITE                         NUMBER(1)                                     NOT NULL,
    GROUP_READ                         NUMBER(1)                                     NOT NULL,
    GROUP_WRITE                        NUMBER(1)                                     NOT NULL,
    OTHER_READ                         NUMBER(1)                                     NOT NULL,
    OTHER_WRITE                        NUMBER(1)                                     NOT NULL,
    ROW_USER_ID                        NUMBER(12)                                    NOT NULL,
    ROW_GROUP_ID                       NUMBER(3)                                     NOT NULL,
    ROW_PROJECT_ID                     NUMBER(3)                                     NOT NULL,
    ROW_ALG_INVOCATION_ID              NUMBER(12)                                    NOT NULL)
 TABLESPACE @oracle_rad3Tablespace@
 STORAGE (MAXEXTENTS UNLIMITED );

CREATE TABLE @oracle_rad3@.ASSAYBIOMATERIAL (
    ASSAY_BIO_MATERIAL_ID              NUMBER(5)                                     NOT NULL,
    ASSAY_ID                           NUMBER(8)                                     NOT NULL,
    BIO_MATERIAL_ID                    NUMBER(5)                                     NOT NULL,
    MODIFICATION_DATE                  DATE                                          NOT NULL,
    USER_READ                          NUMBER(1)                                     NOT NULL,
    USER_WRITE                         NUMBER(1)                                     NOT NULL,
    GROUP_READ                         NUMBER(1)                                     NOT NULL,
    GROUP_WRITE                        NUMBER(1)                                     NOT NULL,
    OTHER_READ                         NUMBER(1)                                     NOT NULL,
    OTHER_WRITE                        NUMBER(1)                                     NOT NULL,
    ROW_USER_ID                        NUMBER(12)                                    NOT NULL,
    ROW_GROUP_ID                       NUMBER(12)                                    NOT NULL,
    ROW_PROJECT_ID                     NUMBER(12)                                    NOT NULL,
    ROW_ALG_INVOCATION_ID              NUMBER(12)                                    NOT NULL)
 TABLESPACE @oracle_rad3Tablespace@
 STORAGE (MAXEXTENTS UNLIMITED );

CREATE TABLE @oracle_rad3@.ASSAYLABELEDEXTRACT (
    ASSAY_LABELED_EXTRACT_ID           NUMBER(8)                                     NOT NULL,
    ASSAY_ID                           NUMBER(8)                                     NOT NULL,
    LABELED_EXTRACT_ID                 NUMBER(8)                                     NOT NULL,
    CHANNEL_ID                         NUMBER(4)                                     NOT NULL,
    MODIFICATION_DATE                  DATE                                          NOT NULL,
    USER_READ                          NUMBER(1)                                     NOT NULL,
    USER_WRITE                         NUMBER(1)                                     NOT NULL,
    GROUP_READ                         NUMBER(1)                                     NOT NULL,
    GROUP_WRITE                        NUMBER(1)                                     NOT NULL,
    OTHER_READ                         NUMBER(1)                                     NOT NULL,
    OTHER_WRITE                        NUMBER(1)                                     NOT NULL,
    ROW_USER_ID                        NUMBER(12)                                    NOT NULL,
    ROW_GROUP_ID                       NUMBER(12)                                    NOT NULL,
    ROW_PROJECT_ID                     NUMBER(12)                                    NOT NULL,
    ROW_ALG_INVOCATION_ID              NUMBER(12)                                    NOT NULL)
 TABLESPACE @oracle_rad3Tablespace@
 STORAGE (MAXEXTENTS UNLIMITED );

CREATE TABLE @oracle_rad3@.ASSAYPARAM (
    ASSAY_PARAM_ID                     NUMBER(10)                                    NOT NULL,
    ASSAY_ID                           NUMBER(8)                                     NOT NULL,
    PROTOCOL_PARAM_ID                  NUMBER(5)                                     NOT NULL,
    VALUE                              VARCHAR2(100)                                 NOT NULL,
    MODIFICATION_DATE                  DATE                                          NOT NULL,
    USER_READ                          NUMBER(1)                                     NOT NULL,
    USER_WRITE                         NUMBER(1)                                     NOT NULL,
    GROUP_READ                         NUMBER(1)                                     NOT NULL,
    GROUP_WRITE                        NUMBER(1)                                     NOT NULL,
    OTHER_READ                         NUMBER(1)                                     NOT NULL,
    OTHER_WRITE                        NUMBER(1)                                     NOT NULL,
    ROW_USER_ID                        NUMBER(12)                                    NOT NULL,
    ROW_GROUP_ID                       NUMBER(3)                                     NOT NULL,
    ROW_PROJECT_ID                     NUMBER(3)                                     NOT NULL,
    ROW_ALG_INVOCATION_ID              NUMBER(12)                                    NOT NULL)
 TABLESPACE @oracle_rad3Tablespace@
 STORAGE (MAXEXTENTS UNLIMITED );

CREATE TABLE @oracle_rad3@.BIOMATERIALCHARACTERISTIC (
    BIO_MATERIAL_CHARACTERISTIC_ID     NUMBER(5)                                     NOT NULL,
    BIO_MATERIAL_ID                    NUMBER(5)                                     NOT NULL,
    ONTOLOGY_ENTRY_ID                  NUMBER(5)                                     NOT NULL,
    VALUE                              VARCHAR2(100)                                 NULL,
    MODIFICATION_DATE                  DATE                                          NOT NULL,
    USER_READ                          NUMBER(1)                                     NOT NULL,
    USER_WRITE                         NUMBER(1)                                     NOT NULL,
    GROUP_READ                         NUMBER(1)                                     NOT NULL,
    GROUP_WRITE                        NUMBER(1)                                     NOT NULL,
    OTHER_READ                         NUMBER(1)                                     NOT NULL,
    OTHER_WRITE                        NUMBER(1)                                     NOT NULL,
    ROW_USER_ID                        NUMBER(12)                                    NOT NULL,
    ROW_GROUP_ID                       NUMBER(12)                                    NOT NULL,
    ROW_PROJECT_ID                     NUMBER(12)                                    NOT NULL,
    ROW_ALG_INVOCATION_ID              NUMBER(12)                                    NOT NULL)
 TABLESPACE @oracle_rad3Tablespace@
 STORAGE (MAXEXTENTS UNLIMITED );

CREATE TABLE @oracle_rad3@.BIOMATERIALIMP (
    BIO_MATERIAL_ID                    NUMBER(8)                                     NOT NULL,
    LABEL_METHOD_ID                    NUMBER(4)                                     NULL,
    TAXON_ID                           NUMBER(10)                                    NULL,
    BIO_SOURCE_PROVIDER_ID             NUMBER(12)                                    NULL,
    BIO_MATERIAL_TYPE_ID               NUMBER(10)                                    NULL,
    SUBCLASS_VIEW                      VARCHAR2(27)                                  NOT NULL,
    EXTERNAL_DATABASE_RELEASE_ID       NUMBER(5)                                     NULL,
    SOURCE_ID                          VARCHAR2(50)                                  NULL,
    STRING1                            VARCHAR2(100)                                 NULL,
    STRING2                            VARCHAR2(500)                                 NULL,
    MODIFICATION_DATE                  DATE                                          NOT NULL,
    USER_READ                          NUMBER(1)                                     NOT NULL,
    USER_WRITE                         NUMBER(1)                                     NOT NULL,
    GROUP_READ                         NUMBER(1)                                     NOT NULL,
    GROUP_WRITE                        NUMBER(1)                                     NOT NULL,
    OTHER_READ                         NUMBER(1)                                     NOT NULL,
    OTHER_WRITE                        NUMBER(1)                                     NOT NULL,
    ROW_USER_ID                        NUMBER(12)                                    NOT NULL,
    ROW_GROUP_ID                       NUMBER(3)                                     NOT NULL,
    ROW_PROJECT_ID                     NUMBER(3)                                     NOT NULL,
    ROW_ALG_INVOCATION_ID              NUMBER(12)                                    NOT NULL)
 TABLESPACE @oracle_rad3Tablespace@
 STORAGE (MAXEXTENTS UNLIMITED );

CREATE TABLE @oracle_rad3@.BIOMATERIALMEASUREMENT (
    BIO_MATERIAL_MEASUREMENT_ID        NUMBER(10)                                    NOT NULL,
    TREATMENT_ID                       NUMBER(10)                                    NOT NULL,
    BIO_MATERIAL_ID                    NUMBER(5)                                     NOT NULL,
    VALUE                              FLOAT(126)                                    NULL,
    UNIT_TYPE_ID                       NUMBER(5)                                     NULL,
    MODIFICATION_DATE                  DATE                                          NOT NULL,
    USER_READ                          NUMBER(1)                                     NOT NULL,
    USER_WRITE                         NUMBER(1)                                     NOT NULL,
    GROUP_READ                         NUMBER(1)                                     NOT NULL,
    GROUP_WRITE                        NUMBER(1)                                     NOT NULL,
    OTHER_READ                         NUMBER(1)                                     NOT NULL,
    OTHER_WRITE                        NUMBER(1)                                     NOT NULL,
    ROW_USER_ID                        NUMBER(12)                                    NOT NULL,
    ROW_GROUP_ID                       NUMBER(12)                                    NOT NULL,
    ROW_PROJECT_ID                     NUMBER(12)                                    NOT NULL,
    ROW_ALG_INVOCATION_ID              NUMBER(12)                                    NOT NULL)
 TABLESPACE @oracle_rad3Tablespace@
 STORAGE (MAXEXTENTS UNLIMITED );

CREATE TABLE @oracle_rad3@.CHANNEL (
    CHANNEL_ID                         NUMBER(4)                                     NOT NULL,
    NAME                               VARCHAR2(100)                                 NOT NULL,
    DEFINITION                         VARCHAR2(500)                                 NOT NULL,
    MODIFICATION_DATE                  DATE                                          NOT NULL,
    USER_READ                          NUMBER(1)                                     NOT NULL,
    USER_WRITE                         NUMBER(1)                                     NOT NULL,
    GROUP_READ                         NUMBER(1)                                     NOT NULL,
    GROUP_WRITE                        NUMBER(1)                                     NOT NULL,
    OTHER_READ                         NUMBER(1)                                     NOT NULL,
    OTHER_WRITE                        NUMBER(1)                                     NOT NULL,
    ROW_USER_ID                        NUMBER(12)                                    NOT NULL,
    ROW_GROUP_ID                       NUMBER(12)                                    NOT NULL,
    ROW_PROJECT_ID                     NUMBER(12)                                    NOT NULL,
    ROW_ALG_INVOCATION_ID              NUMBER(12)                                    NOT NULL)
 TABLESPACE @oracle_rad3Tablespace@
 STORAGE (MAXEXTENTS UNLIMITED );

CREATE TABLE @oracle_rad3@.COMPOSITEELEMENTANNOTATION (
    COMPOSITE_ELEMENT_ANNOT_ID         NUMBER(12)                                    NOT NULL,
    COMPOSITE_ELEMENT_ID               NUMBER(10)                                    NOT NULL,
    NAME                               VARCHAR2(500)                                 NOT NULL,
    VALUE                              VARCHAR2(255)                                 NOT NULL,
    MODIFICATION_DATE                  DATE                                          NOT NULL,
    USER_READ                          NUMBER(1)                                     NOT NULL,
    USER_WRITE                         NUMBER(1)                                     NOT NULL,
    GROUP_READ                         NUMBER(1)                                     NOT NULL,
    GROUP_WRITE                        NUMBER(1)                                     NOT NULL,
    OTHER_READ                         NUMBER(1)                                     NOT NULL,
    OTHER_WRITE                        NUMBER(1)                                     NOT NULL,
    ROW_USER_ID                        NUMBER(12)                                    NOT NULL,
    ROW_GROUP_ID                       NUMBER(12)                                    NOT NULL,
    ROW_PROJECT_ID                     NUMBER(12)                                    NOT NULL,
    ROW_ALG_INVOCATION_ID              NUMBER(12)                                    NOT NULL)
 TABLESPACE @oracle_rad3Tablespace@
 STORAGE (MAXEXTENTS UNLIMITED );

CREATE TABLE @oracle_rad3@.COMPOSITEELEMENTGUS (
    COMPOSITE_ELEMENT_GUS_ID           NUMBER(12)                                    NOT NULL,
    COMPOSITE_ELEMENT_ID               NUMBER(12)                                    NULL,
    TABLE_ID                           NUMBER(5)                                     NOT NULL,
    ROW_ID                             NUMBER(12)                                    NOT NULL,
    MODIFICATION_DATE                  DATE                                          NOT NULL,
    USER_READ                          NUMBER(1)                                     NOT NULL,
    USER_WRITE                         NUMBER(1)                                     NOT NULL,
    GROUP_READ                         NUMBER(1)                                     NOT NULL,
    GROUP_WRITE                        NUMBER(1)                                     NOT NULL,
    OTHER_READ                         NUMBER(1)                                     NOT NULL,
    OTHER_WRITE                        NUMBER(1)                                     NOT NULL,
    ROW_USER_ID                        NUMBER(12)                                    NOT NULL,
    ROW_GROUP_ID                       NUMBER(12)                                    NOT NULL,
    ROW_PROJECT_ID                     NUMBER(12)                                    NOT NULL,
    ROW_ALG_INVOCATION_ID              NUMBER(12)                                    NOT NULL)
 TABLESPACE @oracle_rad3Tablespace@
 STORAGE (MAXEXTENTS UNLIMITED );

CREATE TABLE @oracle_rad3@.COMPOSITEELEMENTIMP (
    COMPOSITE_ELEMENT_ID               NUMBER(10)                                    NOT NULL,
    PARENT_ID                          NUMBER(10)                                    NULL,
    ARRAY_ID                           NUMBER(4)                                     NOT NULL,
    SUBCLASS_VIEW                      VARCHAR2(27)                                  NOT NULL,
    EXTERNAL_DATABASE_RELEASE_ID       NUMBER(4)                                     NULL,
    SOURCE_ID                          VARCHAR2(50)                                  NULL,
    TINYINT1                           NUMBER(3)                                     NULL,
    SMALLINT1                          NUMBER(5)                                     NULL,
    SMALLINT2                          NUMBER(5)                                     NULL,
    CHAR1                              VARCHAR2(5)                                   NULL,
    CHAR2                              VARCHAR2(5)                                   NULL,
    TINYSTRING1                        VARCHAR2(50)                                  NULL,
    TINYSTRING2                        VARCHAR2(50)                                  NULL,
    SMALLSTRING1                       VARCHAR2(100)                                 NULL,
    SMALLSTRING2                       VARCHAR2(100)                                 NULL,
    STRING1                            VARCHAR2(500)                                 NULL,
    STRING2                            VARCHAR2(500)                                 NULL,
    MODIFICATION_DATE                  DATE                                          NOT NULL,
    USER_READ                          NUMBER(1)                                     NOT NULL,
    USER_WRITE                         NUMBER(1)                                     NOT NULL,
    GROUP_READ                         NUMBER(1)                                     NOT NULL,
    GROUP_WRITE                        NUMBER(1)                                     NOT NULL,
    OTHER_READ                         NUMBER(1)                                     NOT NULL,
    OTHER_WRITE                        NUMBER(1)                                     NOT NULL,
    ROW_USER_ID                        NUMBER(12)                                    NOT NULL,
    ROW_GROUP_ID                       NUMBER(12)                                    NOT NULL,
    ROW_PROJECT_ID                     NUMBER(12)                                    NOT NULL,
    ROW_ALG_INVOCATION_ID              NUMBER(12)                                    NOT NULL)
 TABLESPACE @oracle_rad3Tablespace@
 STORAGE (MAXEXTENTS UNLIMITED );

CREATE TABLE @oracle_rad3@.COMPOSITEELEMENTRESULTIMP (
    COMPOSITE_ELEMENT_RESULT_ID        NUMBER(10)                                    NOT NULL,
    COMPOSITE_ELEMENT_ID               NUMBER(10)                                    NOT NULL,
    QUANTIFICATION_ID                  NUMBER(8)                                     NOT NULL,
    SUBCLASS_VIEW                      VARCHAR2(27)                                  NOT NULL,
    FLOAT1                             FLOAT(126)                                    NULL,
    FLOAT2                             FLOAT(126)                                    NULL,
    FLOAT3                             FLOAT(126)                                    NULL,
    FLOAT4                             FLOAT(126)                                    NULL,
    INT1                               NUMBER(12)                                    NULL,
    SMALLINT1                          NUMBER(5)                                     NULL,
    SMALLINT2                          NUMBER(5)                                     NULL,
    SMALLINT3                          NUMBER(5)                                     NULL,
    TINYINT1                           NUMBER(3)                                     NULL,
    TINYINT2                           NUMBER(3)                                     NULL,
    TINYINT3                           NUMBER(3)                                     NULL,
    CHAR1                              VARCHAR2(5)                                   NULL,
    CHAR2                              VARCHAR2(5)                                   NULL,
    CHAR3                              VARCHAR2(5)                                   NULL,
    STRING1                            VARCHAR2(500)                                 NULL,
    STRING2                            VARCHAR2(500)                                 NULL,
    MODIFICATION_DATE                  DATE                                          NOT NULL,
    USER_READ                          NUMBER(1)                                     NOT NULL,
    USER_WRITE                         NUMBER(1)                                     NOT NULL,
    GROUP_READ                         NUMBER(1)                                     NOT NULL,
    GROUP_WRITE                        NUMBER(1)                                     NOT NULL,
    OTHER_READ                         NUMBER(1)                                     NOT NULL,
    OTHER_WRITE                        NUMBER(1)                                     NOT NULL,
    ROW_USER_ID                        NUMBER(12)                                    NOT NULL,
    ROW_GROUP_ID                       NUMBER(3)                                     NOT NULL,
    ROW_PROJECT_ID                     NUMBER(3)                                     NOT NULL,
    ROW_ALG_INVOCATION_ID              NUMBER(12)                                    NOT NULL)
 TABLESPACE @oracle_rad3Tablespace@
 STORAGE (MAXEXTENTS UNLIMITED );

CREATE TABLE @oracle_rad3@.CONTROL (
    CONTROL_ID                         NUMBER(5)                                     NOT NULL,
    CONTROL_TYPE_ID                    NUMBER(5)                                     NOT NULL,
    ASSAY_ID                           NUMBER(8)                                     NOT NULL,
    TABLE_ID                           NUMBER(10)                                    NOT NULL,
    ROW_ID                             NUMBER(12)                                    NOT NULL,
    NAME                               VARCHAR2(100)                                 NULL,
    VALUE                              VARCHAR2(255)                                 NULL,
    MODIFICATION_DATE                  DATE                                          NOT NULL,
    USER_READ                          NUMBER(1)                                     NOT NULL,
    USER_WRITE                         NUMBER(1)                                     NOT NULL,
    GROUP_READ                         NUMBER(1)                                     NOT NULL,
    GROUP_WRITE                        NUMBER(1)                                     NOT NULL,
    OTHER_READ                         NUMBER(1)                                     NOT NULL,
    OTHER_WRITE                        NUMBER(1)                                     NOT NULL,
    ROW_USER_ID                        NUMBER(12)                                    NOT NULL,
    ROW_GROUP_ID                       NUMBER(12)                                    NOT NULL,
    ROW_PROJECT_ID                     NUMBER(12)                                    NOT NULL,
    ROW_ALG_INVOCATION_ID              NUMBER(12)                                    NOT NULL)
 TABLESPACE @oracle_rad3Tablespace@
 STORAGE (MAXEXTENTS UNLIMITED );

CREATE TABLE @oracle_rad3@.ELEMENTANNOTATION (
    ELEMENT_ANNOTATION_ID              NUMBER(10)                                    NOT NULL,
    ELEMENT_ID                         NUMBER(10)                                    NOT NULL,
    NAME                               VARCHAR2(100)                                 NOT NULL,
    VALUE                              VARCHAR2(500)                                 NOT NULL,
    MODIFICATION_DATE                  DATE                                          NOT NULL,
    USER_READ                          NUMBER(1)                                     NOT NULL,
    USER_WRITE                         NUMBER(1)                                     NOT NULL,
    GROUP_READ                         NUMBER(1)                                     NOT NULL,
    GROUP_WRITE                        NUMBER(1)                                     NOT NULL,
    OTHER_READ                         NUMBER(1)                                     NOT NULL,
    OTHER_WRITE                        NUMBER(1)                                     NOT NULL,
    ROW_USER_ID                        NUMBER(12)                                    NOT NULL,
    ROW_GROUP_ID                       NUMBER(12)                                    NOT NULL,
    ROW_PROJECT_ID                     NUMBER(12)                                    NOT NULL,
    ROW_ALG_INVOCATION_ID              NUMBER(12)                                    NOT NULL)
 TABLESPACE @oracle_rad3Tablespace@
 STORAGE (MAXEXTENTS UNLIMITED );

CREATE TABLE @oracle_rad3@.ELEMENTIMP (
    ELEMENT_ID                         NUMBER(10)                                    NOT NULL,
    COMPOSITE_ELEMENT_ID               NUMBER(10)                                    NULL,
    ARRAY_ID                           NUMBER(4)                                     NOT NULL,
    ELEMENT_TYPE_ID                    NUMBER(8)                                     NULL,
    EXTERNAL_DATABASE_RELEASE_ID       NUMBER(5)                                     NULL,
    SOURCE_ID                          VARCHAR2(50)                                  NULL,
    SUBCLASS_VIEW                      VARCHAR2(27)                                  NOT NULL,
    TINYINT1                           NUMBER(3)                                     NULL,
    SMALLINT1                          NUMBER(5)                                     NULL,
    CHAR1                              VARCHAR2(5)                                   NULL,
    CHAR2                              VARCHAR2(5)                                   NULL,
    CHAR3                              VARCHAR2(5)                                   NULL,
    CHAR4                              VARCHAR2(5)                                   NULL,
    CHAR5                              VARCHAR2(5)                                   NULL,
    CHAR6                              VARCHAR2(5)                                   NULL,
    CHAR7                              VARCHAR2(5)                                   NULL,
    TINYSTRING1                        VARCHAR2(50)                                  NULL,
    TINYSTRING2                        VARCHAR2(50)                                  NULL,
    SMALLSTRING1                       VARCHAR2(100)                                 NULL,
    SMALLSTRING2                       VARCHAR2(100)                                 NULL,
    STRING1                            VARCHAR2(500)                                 NULL,
    STRING2                            VARCHAR2(500)                                 NULL,
    MODIFICATION_DATE                  DATE                                          NOT NULL,
    USER_READ                          NUMBER(1)                                     NOT NULL,
    USER_WRITE                         NUMBER(1)                                     NOT NULL,
    GROUP_READ                         NUMBER(1)                                     NOT NULL,
    GROUP_WRITE                        NUMBER(1)                                     NOT NULL,
    OTHER_READ                         NUMBER(1)                                     NOT NULL,
    OTHER_WRITE                        NUMBER(1)                                     NOT NULL,
    ROW_GROUP_ID                       NUMBER(12)                                    NOT NULL,
    ROW_USER_ID                        NUMBER(12)                                    NOT NULL,
    ROW_PROJECT_ID                     NUMBER(12)                                    NOT NULL,
    ROW_ALG_INVOCATION_ID              NUMBER(12)                                    NOT NULL)
 TABLESPACE @oracle_rad3Tablespace@
 STORAGE (MAXEXTENTS UNLIMITED );

CREATE TABLE @oracle_rad3@.ELEMENTRESULTIMP (
    ELEMENT_RESULT_ID                  NUMBER(10)                                    NOT NULL,
    ELEMENT_ID                         NUMBER(10)                                    NOT NULL,
    COMPOSITE_ELEMENT_RESULT_ID        NUMBER(10)                                    NULL,
    QUANTIFICATION_ID                  NUMBER(8)                                     NOT NULL,
    SUBCLASS_VIEW                      VARCHAR2(27)                                  NOT NULL,
    FOREGROUND                         FLOAT(126)                                    NULL,
    BACKGROUND                         FLOAT(126)                                    NULL,
    FOREGROUND_SD                      FLOAT(126)                                    NULL,
    BACKGROUND_SD                      FLOAT(126)                                    NULL,
    FLOAT1                             FLOAT(126)                                    NULL,
    FLOAT2                             FLOAT(126)                                    NULL,
    FLOAT3                             FLOAT(126)                                    NULL,
    FLOAT4                             FLOAT(126)                                    NULL,
    FLOAT5                             FLOAT(126)                                    NULL,
    FLOAT6                             FLOAT(126)                                    NULL,
    FLOAT7                             FLOAT(126)                                    NULL,
    FLOAT8                             FLOAT(126)                                    NULL,
    FLOAT9                             FLOAT(126)                                    NULL,
    FLOAT10                            FLOAT(126)                                    NULL,
    FLOAT11                            FLOAT(126)                                    NULL,
    FLOAT12                            FLOAT(126)                                    NULL,
    FLOAT13                            FLOAT(126)                                    NULL,
    FLOAT14                            FLOAT(126)                                    NULL,
    INT1                               NUMBER(12)                                    NULL,
    INT2                               NUMBER(12)                                    NULL,
    INT3                               NUMBER(12)                                    NULL,
    INT4                               NUMBER(12)                                    NULL,
    INT5                               NUMBER(12)                                    NULL,
    INT6                               NUMBER(12)                                    NULL,
    INT7                               NUMBER(12)                                    NULL,
    INT8                               NUMBER(12)                                    NULL,
    INT9                               NUMBER(12)                                    NULL,
    INT10                              NUMBER(12)                                    NULL,
    INT11                              NUMBER(12)                                    NULL,
    INT12                              NUMBER(12)                                    NULL,
    INT13                              NUMBER(12)                                    NULL,
    INT14                              NUMBER(12)                                    NULL,
    INT15                              NUMBER(12)                                    NULL,
    TINYINT1                           NUMBER(3)                                     NULL,
    TINYINT2                           NUMBER(3)                                     NULL,
    TINYINT3                           NUMBER(3)                                     NULL,
    SMALLINT1                          NUMBER(5)                                     NULL,
    SMALLINT2                          NUMBER(5)                                     NULL,
    SMALLINT3                          NUMBER(5)                                     NULL,
    CHAR1                              VARCHAR2(5)                                   NULL,
    CHAR2                              VARCHAR2(5)                                   NULL,
    CHAR3                              VARCHAR2(5)                                   NULL,
    CHAR4                              VARCHAR2(5)                                   NULL,
    TINYSTRING1                        VARCHAR2(50)                                  NULL,
    TINYSTRING2                        VARCHAR2(50)                                  NULL,
    TINYSTRING3                        VARCHAR2(50)                                  NULL,
    SMALLSTRING1                       VARCHAR2(100)                                 NULL,
    SMALLSTRING2                       VARCHAR2(100)                                 NULL,
    STRING1                            VARCHAR2(500)                                 NULL,
    STRING2                            VARCHAR2(500)                                 NULL,
    MODIFICATION_DATE                  DATE                                          NOT NULL,
    USER_READ                          NUMBER(1)                                     NOT NULL,
    USER_WRITE                         NUMBER(1)                                     NOT NULL,
    GROUP_READ                         NUMBER(1)                                     NOT NULL,
    GROUP_WRITE                        NUMBER(1)                                     NOT NULL,
    OTHER_READ                         NUMBER(1)                                     NOT NULL,
    OTHER_WRITE                        NUMBER(1)                                     NOT NULL,
    ROW_USER_ID                        NUMBER(12)                                    NOT NULL,
    ROW_GROUP_ID                       NUMBER(12)                                    NOT NULL,
    ROW_PROJECT_ID                     NUMBER(12)                                    NOT NULL,
    ROW_ALG_INVOCATION_ID              NUMBER(12)                                    NOT NULL)
 TABLESPACE @oracle_rad3Tablespace@
 STORAGE (MAXEXTENTS UNLIMITED );

CREATE TABLE @oracle_rad3@.LABELMETHOD (
    LABEL_METHOD_ID                    NUMBER(4)                                     NOT NULL,
    PROTOCOL_ID                        NUMBER(10)                                    NOT NULL,
    CHANNEL_ID                         NUMBER(4)                                     NOT NULL,
    LABEL_USED                         VARCHAR2(50)                                  NULL,
    LABEL_METHOD                       VARCHAR2(1000)                                NULL,
    MODIFICATION_DATE                  DATE                                          NOT NULL,
    USER_READ                          NUMBER(1)                                     NOT NULL,
    USER_WRITE                         NUMBER(1)                                     NOT NULL,
    GROUP_READ                         NUMBER(1)                                     NOT NULL,
    GROUP_WRITE                        NUMBER(1)                                     NOT NULL,
    OTHER_READ                         NUMBER(1)                                     NOT NULL,
    OTHER_WRITE                        NUMBER(1)                                     NOT NULL,
    ROW_USER_ID                        NUMBER(12)                                    NOT NULL,
    ROW_GROUP_ID                       NUMBER(3)                                     NOT NULL,
    ROW_PROJECT_ID                     NUMBER(3)                                     NOT NULL,
    ROW_ALG_INVOCATION_ID              NUMBER(12)                                    NOT NULL)
 TABLESPACE @oracle_rad3Tablespace@
 STORAGE (MAXEXTENTS UNLIMITED );

CREATE TABLE @oracle_rad3@.MAGEDOCUMENTATION (
    MAGE_DOCUMENTATION_ID              NUMBER(5)                                     NOT NULL,
    MAGE_ML_ID                         NUMBER(8)                                     NOT NULL,
    TABLE_ID                           NUMBER(10)                                    NOT NULL,
    ROW_ID                             NUMBER(12)                                    NOT NULL,
    MAGE_IDENTIFIER                    VARCHAR2(100)                                 NOT NULL,
    MODIFICATION_DATE                  DATE                                          NOT NULL,
    USER_READ                          NUMBER(1)                                     NOT NULL,
    USER_WRITE                         NUMBER(1)                                     NOT NULL,
    GROUP_READ                         NUMBER(1)                                     NOT NULL,
    GROUP_WRITE                        NUMBER(1)                                     NOT NULL,
    OTHER_READ                         NUMBER(1)                                     NOT NULL,
    OTHER_WRITE                        NUMBER(1)                                     NOT NULL,
    ROW_USER_ID                        NUMBER(12)                                    NOT NULL,
    ROW_GROUP_ID                       NUMBER(12)                                    NOT NULL,
    ROW_PROJECT_ID                     NUMBER(12)                                    NOT NULL,
    ROW_ALG_INVOCATION_ID              NUMBER(12)                                    NOT NULL)
 TABLESPACE @oracle_rad3Tablespace@
 STORAGE (MAXEXTENTS UNLIMITED );

CREATE TABLE @oracle_rad3@.MAGE_ML (
    MAGE_ML_ID                         NUMBER(8)                                     NOT NULL,
    MAGE_PACKAGE                       VARCHAR2(100)                                 NOT NULL,
    MAGE_ML                            CLOB                                          NOT NULL,
    MODIFICATION_DATE                  DATE                                          NOT NULL,
    USER_READ                          NUMBER(1)                                     NOT NULL,
    USER_WRITE                         NUMBER(1)                                     NOT NULL,
    GROUP_READ                         NUMBER(1)                                     NOT NULL,
    GROUP_WRITE                        NUMBER(1)                                     NOT NULL,
    OTHER_READ                         NUMBER(1)                                     NOT NULL,
    OTHER_WRITE                        NUMBER(1)                                     NOT NULL,
    ROW_USER_ID                        NUMBER(12)                                    NOT NULL,
    ROW_GROUP_ID                       NUMBER(12)                                    NOT NULL,
    ROW_PROJECT_ID                     NUMBER(12)                                    NOT NULL,
    ROW_ALG_INVOCATION_ID              NUMBER(12)                                    NOT NULL)
 TABLESPACE @oracle_rad3Tablespace@
 STORAGE (MAXEXTENTS UNLIMITED );

CREATE TABLE @oracle_rad3@.ONTOLOGYENTRY (
    ONTOLOGY_ENTRY_ID                  NUMBER(10)                                    NOT NULL,
    PARENT_ID                          NUMBER(10)                                    NULL,
    TABLE_ID                           NUMBER(8)                                     NULL,
    ROW_ID                             NUMBER(12)                                    NULL,
    EXTERNAL_DATABASE_RELEASE_ID       NUMBER(10)                                    NULL,
    SOURCE_ID                          VARCHAR2(100)                                 NULL,
    URI                                VARCHAR2(500)                                 NULL,
    NAME                               VARCHAR2(100)                                 NULL,
    CATEGORY                           VARCHAR2(100)                                 NOT NULL,
    VALUE                              VARCHAR2(100)                                 NOT NULL,
    DEFINITION                         VARCHAR2(500)                                 NULL,
    MODIFICATION_DATE                  DATE                                          NOT NULL,
    USER_READ                          NUMBER(1)                                     NOT NULL,
    USER_WRITE                         NUMBER(1)                                     NOT NULL,
    GROUP_READ                         NUMBER(1)                                     NOT NULL,
    GROUP_WRITE                        NUMBER(1)                                     NOT NULL,
    OTHER_READ                         NUMBER(1)                                     NOT NULL,
    OTHER_WRITE                        NUMBER(1)                                     NOT NULL,
    ROW_USER_ID                        NUMBER(12)                                    NOT NULL,
    ROW_GROUP_ID                       NUMBER(3)                                     NOT NULL,
    ROW_PROJECT_ID                     NUMBER(3)                                     NOT NULL,
    ROW_ALG_INVOCATION_ID              NUMBER(12)                                    NOT NULL)
 TABLESPACE @oracle_rad3Tablespace@
 STORAGE (MAXEXTENTS UNLIMITED );

CREATE TABLE @oracle_rad3@.PROCESSIMPLEMENTATION (
    PROCESS_IMPLEMENTATION_ID          NUMBER(5)                                     NOT NULL,
    PROCESS_TYPE_ID                    NUMBER(5)                                     NOT NULL,
    NAME                               VARCHAR2(100)                                 NULL,
    MODIFICATION_DATE                  DATE                                          NOT NULL,
    USER_READ                          NUMBER(1)                                     NOT NULL,
    USER_WRITE                         NUMBER(1)                                     NOT NULL,
    GROUP_READ                         NUMBER(1)                                     NOT NULL,
    GROUP_WRITE                        NUMBER(1)                                     NOT NULL,
    OTHER_READ                         NUMBER(1)                                     NOT NULL,
    OTHER_WRITE                        NUMBER(1)                                     NOT NULL,
    ROW_USER_ID                        NUMBER(12)                                    NOT NULL,
    ROW_GROUP_ID                       NUMBER(12)                                    NOT NULL,
    ROW_PROJECT_ID                     NUMBER(12)                                    NOT NULL,
    ROW_ALG_INVOCATION_ID              NUMBER(12)                                    NOT NULL)
 TABLESPACE @oracle_rad3Tablespace@
 STORAGE (MAXEXTENTS UNLIMITED );

CREATE TABLE @oracle_rad3@.PROCESSIMPLEMENTATIONPARAM (
    PROCESS_IMPLEMETATION_PARAM_ID     NUMBER(5)                                     NOT NULL,
    PROCESS_IMPLEMENTATION_ID          NUMBER(5)                                     NOT NULL,
    NAME                               VARCHAR2(100)                                 NOT NULL,
    VALUE                              VARCHAR2(100)                                 NOT NULL,
    MODIFICATION_DATE                  DATE                                          NOT NULL,
    USER_READ                          NUMBER(1)                                     NOT NULL,
    USER_WRITE                         NUMBER(1)                                     NOT NULL,
    GROUP_READ                         NUMBER(1)                                     NOT NULL,
    GROUP_WRITE                        NUMBER(1)                                     NOT NULL,
    OTHER_READ                         NUMBER(1)                                     NOT NULL,
    OTHER_WRITE                        NUMBER(1)                                     NOT NULL,
    ROW_USER_ID                        NUMBER(12)                                    NOT NULL,
    ROW_GROUP_ID                       NUMBER(12)                                    NOT NULL,
    ROW_PROJECT_ID                     NUMBER(12)                                    NOT NULL,
    ROW_ALG_INVOCATION_ID              NUMBER(12)                                    NOT NULL)
 TABLESPACE @oracle_rad3Tablespace@
 STORAGE (MAXEXTENTS UNLIMITED );

CREATE TABLE @oracle_rad3@.PROCESSINVOCATION (
    PROCESS_INVOCATION_ID              NUMBER(5)                                     NOT NULL,
    PROCESS_IMPLEMENTATION_ID          NUMBER(5)                                     NOT NULL,
    PROCESS_INVOCATION_DATE            DATE                                          NOT NULL,
    DESCRIPTION                        VARCHAR2(500)                                 NULL,
    MODIFICATION_DATE                  DATE                                          NOT NULL,
    USER_READ                          NUMBER(1)                                     NOT NULL,
    USER_WRITE                         NUMBER(1)                                     NOT NULL,
    GROUP_READ                         NUMBER(1)                                     NOT NULL,
    GROUP_WRITE                        NUMBER(1)                                     NOT NULL,
    OTHER_READ                         NUMBER(1)                                     NOT NULL,
    OTHER_WRITE                        NUMBER(1)                                     NOT NULL,
    ROW_USER_ID                        NUMBER(12)                                    NOT NULL,
    ROW_GROUP_ID                       NUMBER(3)                                     NOT NULL,
    ROW_PROJECT_ID                     NUMBER(3)                                     NOT NULL,
    ROW_ALG_INVOCATION_ID              NUMBER(12)                                    NOT NULL)
 TABLESPACE @oracle_rad3Tablespace@
 STORAGE (MAXEXTENTS UNLIMITED );

CREATE TABLE @oracle_rad3@.PROCESSINVOCATIONPARAM (
    PROCESS_INVOCATION_PARAM_ID        NUMBER(8)                                     NOT NULL,
    PROCESS_INVOCATION_ID              NUMBER(5)                                     NOT NULL,
    NAME                               VARCHAR2(100)                                 NOT NULL,
    VALUE                              VARCHAR2(100)                                 NOT NULL,
    MODIFICATION_DATE                  DATE                                          NOT NULL,
    USER_READ                          NUMBER(1)                                     NOT NULL,
    USER_WRITE                         NUMBER(1)                                     NOT NULL,
    GROUP_READ                         NUMBER(1)                                     NOT NULL,
    GROUP_WRITE                        NUMBER(1)                                     NOT NULL,
    OTHER_READ                         NUMBER(1)                                     NOT NULL,
    OTHER_WRITE                        NUMBER(1)                                     NOT NULL,
    ROW_USER_ID                        NUMBER(12)                                    NOT NULL,
    ROW_GROUP_ID                       NUMBER(12)                                    NOT NULL,
    ROW_PROJECT_ID                     NUMBER(12)                                    NOT NULL,
    ROW_ALG_INVOCATION_ID              NUMBER(12)                                    NOT NULL)
 TABLESPACE @oracle_rad3Tablespace@
 STORAGE (MAXEXTENTS UNLIMITED );

CREATE TABLE @oracle_rad3@.PROCESSINVQUANTIFICATION (
    PROCESS_INV_QUANTIFICATION_ID      NUMBER(8)                                     NOT NULL,
    PROCESS_INVOCATION_ID              NUMBER(5)                                     NOT NULL,
    QUANTIFICATION_ID                  NUMBER(5)                                     NOT NULL,
    MODIFICATION_DATE                  DATE                                          NOT NULL,
    USER_READ                          NUMBER(1)                                     NOT NULL,
    USER_WRITE                         NUMBER(1)                                     NOT NULL,
    GROUP_READ                         NUMBER(1)                                     NOT NULL,
    GROUP_WRITE                        NUMBER(1)                                     NOT NULL,
    OTHER_READ                         NUMBER(1)                                     NOT NULL,
    OTHER_WRITE                        NUMBER(1)                                     NOT NULL,
    ROW_USER_ID                        NUMBER(12)                                    NOT NULL,
    ROW_GROUP_ID                       NUMBER(3)                                     NOT NULL,
    ROW_PROJECT_ID                     NUMBER(3)                                     NOT NULL,
    ROW_ALG_INVOCATION_ID              NUMBER(12)                                    NOT NULL)
 TABLESPACE @oracle_rad3Tablespace@
 STORAGE (MAXEXTENTS UNLIMITED );

CREATE TABLE @oracle_rad3@.PROCESSIO (
    PROCESS_IO_ID                      NUMBER(12)                                    NOT NULL,
    PROCESS_INVOCATION_ID              NUMBER(5)                                     NOT NULL,
    TABLE_ID                           NUMBER(5)                                     NOT NULL,
    INPUT_RESULT_ID                    NUMBER(12)                                    NOT NULL,
    INPUT_ROLE                         VARCHAR2(50)                                  NULL,
    OUTPUT_RESULT_ID                   NUMBER(12)                                    NOT NULL,
    MODIFICATION_DATE                  DATE                                          NOT NULL,
    USER_READ                          NUMBER(1)                                     NOT NULL,
    USER_WRITE                         NUMBER(1)                                     NOT NULL,
    GROUP_READ                         NUMBER(1)                                     NOT NULL,
    GROUP_WRITE                        NUMBER(1)                                     NOT NULL,
    OTHER_READ                         NUMBER(1)                                     NOT NULL,
    OTHER_WRITE                        NUMBER(1)                                     NOT NULL,
    ROW_USER_ID                        NUMBER(12)                                    NOT NULL,
    ROW_GROUP_ID                       NUMBER(12)                                    NOT NULL,
    ROW_PROJECT_ID                     NUMBER(12)                                    NOT NULL,
    ROW_ALG_INVOCATION_ID              NUMBER(12)                                    NOT NULL)
 TABLESPACE @oracle_rad3Tablespace@
 STORAGE (MAXEXTENTS UNLIMITED );

CREATE TABLE @oracle_rad3@.PROCESSIOELEMENT (
    PROCESS_IO_ELEMENT_ID              NUMBER(10)                                    NOT NULL,
    PROCESS_IO_ID                      NUMBER(10)                                    NOT NULL,
    ELEMENT_ID                         NUMBER(8)                                     NOT NULL,
    MODIFICATION_DATE                  DATE                                          NOT NULL,
    USER_READ                          NUMBER(1)                                     NOT NULL,
    USER_WRITE                         NUMBER(1)                                     NOT NULL,
    GROUP_READ                         NUMBER(1)                                     NOT NULL,
    GROUP_WRITE                        NUMBER(1)                                     NOT NULL,
    OTHER_READ                         NUMBER(1)                                     NOT NULL,
    OTHER_WRITE                        NUMBER(1)                                     NOT NULL,
    ROW_USER_ID                        NUMBER(12)                                    NOT NULL,
    ROW_GROUP_ID                       NUMBER(3)                                     NOT NULL,
    ROW_PROJECT_ID                     NUMBER(3)                                     NOT NULL,
    ROW_ALG_INVOCATION_ID              NUMBER(12)                                    NOT NULL)
 TABLESPACE @oracle_rad3Tablespace@
 STORAGE (MAXEXTENTS UNLIMITED );

CREATE TABLE @oracle_rad3@.PROCESSRESULT (
    PROCESS_RESULT_ID                  NUMBER(12)                                    NOT NULL,
    VALUE                              FLOAT(126)                                    NOT NULL,
    UNIT_TYPE_ID                       NUMBER(5)                                     NULL,
    MODIFICATION_DATE                  DATE                                          NOT NULL,
    USER_READ                          NUMBER(1)                                     NOT NULL,
    USER_WRITE                         NUMBER(1)                                     NOT NULL,
    GROUP_READ                         NUMBER(1)                                     NOT NULL,
    GROUP_WRITE                        NUMBER(1)                                     NOT NULL,
    OTHER_READ                         NUMBER(1)                                     NOT NULL,
    OTHER_WRITE                        NUMBER(1)                                     NOT NULL,
    ROW_USER_ID                        NUMBER(12)                                    NOT NULL,
    ROW_GROUP_ID                       NUMBER(12)                                    NOT NULL,
    ROW_PROJECT_ID                     NUMBER(12)                                    NOT NULL,
    ROW_ALG_INVOCATION_ID              NUMBER(12)                                    NOT NULL)
 TABLESPACE @oracle_rad3Tablespace@
 STORAGE (MAXEXTENTS UNLIMITED );

CREATE TABLE @oracle_rad3@.PROJECTLINK (
    PROJECT_LINK_ID                    NUMBER(10)                                    NOT NULL,
    PROJECT_ID                         NUMBER(3)                                     NOT NULL,
    TABLE_ID                           NUMBER(5)                                     NOT NULL,
    ID                                 NUMBER(10)                                    NOT NULL,
    CURRENT_VERSION                    VARCHAR2(4)                                   NULL,
    MODIFICATION_DATE                  DATE                                          NOT NULL,
    USER_READ                          NUMBER(1)                                     NOT NULL,
    USER_WRITE                         NUMBER(1)                                     NOT NULL,
    GROUP_READ                         NUMBER(1)                                     NOT NULL,
    GROUP_WRITE                        NUMBER(1)                                     NOT NULL,
    OTHER_READ                         NUMBER(1)                                     NOT NULL,
    OTHER_WRITE                        NUMBER(1)                                     NOT NULL,
    ROW_USER_ID                        NUMBER(12)                                    NOT NULL,
    ROW_GROUP_ID                       NUMBER(3)                                     NOT NULL,
    ROW_PROJECT_ID                     NUMBER(3)                                     NOT NULL,
    ROW_ALG_INVOCATION_ID              NUMBER(12)                                    NOT NULL)
 TABLESPACE @oracle_rad3Tablespace@
 STORAGE (MAXEXTENTS UNLIMITED );

CREATE TABLE @oracle_rad3@.PROTOCOL (
    PROTOCOL_ID                        NUMBER(10)                                    NOT NULL,
    PROTOCOL_TYPE_ID                   NUMBER(5)                                     NOT NULL,
    BIBLIOGRAPHIC_REFERENCE_ID         NUMBER(10)                                    NULL,
    EXTERNAL_DATABASE_RELEASE_ID       NUMBER(4)                                     NULL,
    SOURCE_ID                          VARCHAR2(100)                                 NULL,
    NAME                               VARCHAR2(100)                                 NOT NULL,
    URI                                VARCHAR2(100)                                 NULL,
    PROTOCOL_DESCRIPTION               VARCHAR2(4000)                                NULL,
    HARDWARE_DESCRIPTION               VARCHAR2(500)                                 NULL,
    SOFTWARE_DESCRIPTION               VARCHAR2(500)                                 NULL,
    MODIFICATION_DATE                  DATE                                          NOT NULL,
    USER_READ                          NUMBER(1)                                     NOT NULL,
    USER_WRITE                         NUMBER(1)                                     NOT NULL,
    GROUP_READ                         NUMBER(1)                                     NOT NULL,
    GROUP_WRITE                        NUMBER(1)                                     NOT NULL,
    OTHER_READ                         NUMBER(1)                                     NOT NULL,
    OTHER_WRITE                        NUMBER(1)                                     NOT NULL,
    ROW_USER_ID                        NUMBER(12)                                    NOT NULL,
    ROW_GROUP_ID                       NUMBER(12)                                    NOT NULL,
    ROW_PROJECT_ID                     NUMBER(12)                                    NOT NULL,
    ROW_ALG_INVOCATION_ID              NUMBER(12)                                    NOT NULL)
 TABLESPACE @oracle_rad3Tablespace@
 STORAGE (MAXEXTENTS UNLIMITED );

CREATE TABLE @oracle_rad3@.PROTOCOLPARAM (
    PROTOCOL_PARAM_ID                  NUMBER(5)                                     NOT NULL,
    PROTOCOL_ID                        NUMBER(10)                                    NOT NULL,
    NAME                               VARCHAR2(100)                                 NOT NULL,
    DATA_TYPE_ID                       NUMBER(5)                                     NULL,
    UNIT_TYPE_ID                       NUMBER(5)                                     NULL,
    VALUE                              VARCHAR2(100)                                 NULL,
    MODIFICATION_DATE                  DATE                                          NOT NULL,
    USER_READ                          NUMBER(1)                                     NOT NULL,
    USER_WRITE                         NUMBER(1)                                     NOT NULL,
    GROUP_READ                         NUMBER(1)                                     NOT NULL,
    GROUP_WRITE                        NUMBER(1)                                     NOT NULL,
    OTHER_READ                         NUMBER(1)                                     NOT NULL,
    OTHER_WRITE                        NUMBER(1)                                     NOT NULL,
    ROW_USER_ID                        NUMBER(12)                                    NOT NULL,
    ROW_GROUP_ID                       NUMBER(3)                                     NOT NULL,
    ROW_PROJECT_ID                     NUMBER(3)                                     NOT NULL,
    ROW_ALG_INVOCATION_ID              NUMBER(12)                                    NOT NULL)
 TABLESPACE @oracle_rad3Tablespace@
 STORAGE (MAXEXTENTS UNLIMITED );

CREATE TABLE @oracle_rad3@.QUANTIFICATION (
    QUANTIFICATION_ID                  NUMBER(8)                                     NOT NULL,
    ACQUISITION_ID                     NUMBER(8)                                     NOT NULL,
    OPERATOR_ID                        NUMBER(10)                                    NULL,
    PROTOCOL_ID                        NUMBER(10)                                    NULL,
    RESULT_TABLE_ID                    NUMBER(5)                                     NULL,
    QUANTIFICATION_DATE                DATE                                          NULL,
    NAME                               VARCHAR2(100)                                 NULL,
    URI                                VARCHAR2(500)                                 NULL,
    MODIFICATION_DATE                  DATE                                          NOT NULL,
    USER_READ                          NUMBER(1)                                     NOT NULL,
    USER_WRITE                         NUMBER(1)                                     NOT NULL,
    GROUP_READ                         NUMBER(1)                                     NOT NULL,
    GROUP_WRITE                        NUMBER(1)                                     NOT NULL,
    OTHER_READ                         NUMBER(1)                                     NOT NULL,
    OTHER_WRITE                        NUMBER(1)                                     NOT NULL,
    ROW_USER_ID                        NUMBER(12)                                    NOT NULL,
    ROW_GROUP_ID                       NUMBER(3)                                     NOT NULL,
    ROW_PROJECT_ID                     NUMBER(3)                                     NOT NULL,
    ROW_ALG_INVOCATION_ID              NUMBER(12)                                    NOT NULL)
 TABLESPACE @oracle_rad3Tablespace@
 STORAGE (MAXEXTENTS UNLIMITED );

CREATE TABLE @oracle_rad3@.QUANTIFICATIONPARAM (
    QUANTIFICATION_PARAM_ID            NUMBER(5)                                     NOT NULL,
    QUANTIFICATION_ID                  NUMBER(4)                                     NOT NULL,
    NAME                               VARCHAR2(100)                                 NOT NULL,
    VALUE                              VARCHAR2(50)                                  NOT NULL,
    MODIFICATION_DATE                  DATE                                          NOT NULL,
    USER_READ                          NUMBER(1)                                     NOT NULL,
    USER_WRITE                         NUMBER(1)                                     NOT NULL,
    GROUP_READ                         NUMBER(1)                                     NOT NULL,
    GROUP_WRITE                        NUMBER(1)                                     NOT NULL,
    OTHER_READ                         NUMBER(1)                                     NOT NULL,
    OTHER_WRITE                        NUMBER(1)                                     NOT NULL,
    ROW_USER_ID                        NUMBER(12)                                    NOT NULL,
    ROW_GROUP_ID                       NUMBER(12)                                    NOT NULL,
    ROW_PROJECT_ID                     NUMBER(12)                                    NOT NULL,
    ROW_ALG_INVOCATION_ID              NUMBER(12)                                    NOT NULL)
 TABLESPACE @oracle_rad3Tablespace@
 STORAGE (MAXEXTENTS UNLIMITED );

CREATE TABLE @oracle_rad3@.RELATEDACQUISITION (
    RELATED_ACQUISITION_ID             NUMBER(4)                                     NOT NULL,
    ACQUISITION_ID                     NUMBER(8)                                     NOT NULL,
    ASSOCIATED_ACQUISITION_ID          NUMBER(8)                                     NOT NULL,
    NAME                               VARCHAR2(100)                                 NULL,
    DESIGNATION                        VARCHAR2(50)                                  NULL,
    ASSOCIATED_DESIGNATION             VARCHAR2(50)                                  NULL,
    MODIFICATION_DATE                  DATE                                          NOT NULL,
    USER_READ                          NUMBER(1)                                     NOT NULL,
    USER_WRITE                         NUMBER(1)                                     NOT NULL,
    GROUP_READ                         NUMBER(1)                                     NOT NULL,
    GROUP_WRITE                        NUMBER(1)                                     NOT NULL,
    OTHER_READ                         NUMBER(1)                                     NOT NULL,
    OTHER_WRITE                        NUMBER(1)                                     NOT NULL,
    ROW_USER_ID                        NUMBER(12)                                    NOT NULL,
    ROW_GROUP_ID                       NUMBER(12)                                    NOT NULL,
    ROW_PROJECT_ID                     NUMBER(12)                                    NOT NULL,
    ROW_ALG_INVOCATION_ID              NUMBER(12)                                    NOT NULL)
 TABLESPACE @oracle_rad3Tablespace@
 STORAGE (MAXEXTENTS UNLIMITED );

CREATE TABLE @oracle_rad3@.RELATEDQUANTIFICATION (
    RELATED_QUANTIFICATION_ID          NUMBER(4)                                     NOT NULL,
    QUANTIFICATION_ID                  NUMBER(8)                                     NOT NULL,
    ASSOCIATED_QUANTIFICATION_ID       NUMBER(8)                                     NOT NULL,
    NAME                               VARCHAR2(100)                                 NULL,
    DESIGNATION                        VARCHAR2(50)                                  NULL,
    ASSOCIATED_DESIGNATION             VARCHAR2(50)                                  NULL,
    MODIFICATION_DATE                  DATE                                          NOT NULL,
    USER_READ                          NUMBER(1)                                     NOT NULL,
    USER_WRITE                         NUMBER(1)                                     NOT NULL,
    GROUP_READ                         NUMBER(1)                                     NOT NULL,
    GROUP_WRITE                        NUMBER(1)                                     NOT NULL,
    OTHER_READ                         NUMBER(1)                                     NOT NULL,
    OTHER_WRITE                        NUMBER(1)                                     NOT NULL,
    ROW_USER_ID                        NUMBER(12)                                    NOT NULL,
    ROW_GROUP_ID                       NUMBER(12)                                    NOT NULL,
    ROW_PROJECT_ID                     NUMBER(12)                                    NOT NULL,
    ROW_ALG_INVOCATION_ID              NUMBER(12)                                    NOT NULL)
 TABLESPACE @oracle_rad3Tablespace@
 STORAGE (MAXEXTENTS UNLIMITED );

CREATE TABLE @oracle_rad3@.STUDY (
    STUDY_ID                           NUMBER(4)                                     NOT NULL,
    CONTACT_ID                         NUMBER(12)                                    NOT NULL,
    BIBLIOGRAPHIC_REFERENCE_ID         NUMBER(10)                                    NULL,
    EXTERNAL_DATABASE_RELEASE_ID       NUMBER(4)                                     NULL,
    SOURCE_ID                          VARCHAR2(100)                                 NULL,
    NAME                               VARCHAR2(100)                                 NOT NULL,
    DESCRIPTION                        VARCHAR2(4000)                                NULL,
    MODIFICATION_DATE                  DATE                                          NOT NULL,
    USER_READ                          NUMBER(1)                                     NOT NULL,
    USER_WRITE                         NUMBER(1)                                     NOT NULL,
    GROUP_READ                         NUMBER(1)                                     NOT NULL,
    GROUP_WRITE                        NUMBER(1)                                     NOT NULL,
    OTHER_READ                         NUMBER(1)                                     NOT NULL,
    OTHER_WRITE                        NUMBER(1)                                     NOT NULL,
    ROW_USER_ID                        NUMBER(12)                                    NOT NULL,
    ROW_GROUP_ID                       NUMBER(12)                                    NOT NULL,
    ROW_PROJECT_ID                     NUMBER(12)                                    NOT NULL,
    ROW_ALG_INVOCATION_ID              NUMBER(12)                                    NOT NULL)
 TABLESPACE @oracle_rad3Tablespace@
 STORAGE (MAXEXTENTS UNLIMITED );

CREATE TABLE @oracle_rad3@.STUDYASSAY (
    STUDY_ASSAY_ID                     NUMBER(8)                                     NOT NULL,
    STUDY_ID                           NUMBER(5)                                     NOT NULL,
    ASSAY_ID                           NUMBER(8)                                     NOT NULL,
    MODIFICATION_DATE                  DATE                                          NOT NULL,
    USER_READ                          NUMBER(1)                                     NOT NULL,
    USER_WRITE                         NUMBER(1)                                     NOT NULL,
    GROUP_READ                         NUMBER(1)                                     NOT NULL,
    GROUP_WRITE                        NUMBER(1)                                     NOT NULL,
    OTHER_READ                         NUMBER(1)                                     NOT NULL,
    OTHER_WRITE                        NUMBER(1)                                     NOT NULL,
    ROW_USER_ID                        NUMBER(12)                                    NOT NULL,
    ROW_GROUP_ID                       NUMBER(12)                                    NOT NULL,
    ROW_PROJECT_ID                     NUMBER(12)                                    NOT NULL,
    ROW_ALG_INVOCATION_ID              NUMBER(12)                                    NOT NULL)
 TABLESPACE @oracle_rad3Tablespace@
 STORAGE (MAXEXTENTS UNLIMITED );

CREATE TABLE @oracle_rad3@.STUDYDESIGN (
    STUDY_DESIGN_ID                    NUMBER(5)                                     NOT NULL,
    STUDY_ID                           NUMBER(5)                                     NOT NULL,
    DESCRIPTION                        VARCHAR2(4000)                                NULL,
    MODIFICATION_DATE                  DATE                                          NOT NULL,
    USER_READ                          NUMBER(1)                                     NOT NULL,
    USER_WRITE                         NUMBER(1)                                     NOT NULL,
    GROUP_READ                         NUMBER(1)                                     NOT NULL,
    GROUP_WRITE                        NUMBER(1)                                     NOT NULL,
    OTHER_READ                         NUMBER(1)                                     NOT NULL,
    OTHER_WRITE                        NUMBER(1)                                     NOT NULL,
    ROW_USER_ID                        NUMBER(12)                                    NOT NULL,
    ROW_GROUP_ID                       NUMBER(3)                                     NOT NULL,
    ROW_PROJECT_ID                     NUMBER(3)                                     NOT NULL,
    ROW_ALG_INVOCATION_ID              NUMBER(12)                                    NOT NULL)
 TABLESPACE @oracle_rad3Tablespace@
 STORAGE (MAXEXTENTS UNLIMITED );

CREATE TABLE @oracle_rad3@.STUDYDESIGNASSAY (
    STUDY_DESIGN_ASSAY_ID              NUMBER(8)                                     NOT NULL,
    STUDY_DESIGN_ID                    NUMBER(5)                                     NOT NULL,
    ASSAY_ID                           NUMBER(8)                                     NOT NULL,
    MODIFICATION_DATE                  DATE                                          NOT NULL,
    USER_READ                          NUMBER(1)                                     NOT NULL,
    USER_WRITE                         NUMBER(1)                                     NOT NULL,
    GROUP_READ                         NUMBER(1)                                     NOT NULL,
    GROUP_WRITE                        NUMBER(1)                                     NOT NULL,
    OTHER_READ                         NUMBER(1)                                     NOT NULL,
    OTHER_WRITE                        NUMBER(1)                                     NOT NULL,
    ROW_USER_ID                        NUMBER(12)                                    NOT NULL,
    ROW_GROUP_ID                       NUMBER(12)                                    NOT NULL,
    ROW_PROJECT_ID                     NUMBER(12)                                    NOT NULL,
    ROW_ALG_INVOCATION_ID              NUMBER(12)                                    NOT NULL)
 TABLESPACE @oracle_rad3Tablespace@
 STORAGE (MAXEXTENTS UNLIMITED );

CREATE TABLE @oracle_rad3@.STUDYDESIGNDESCRIPTION (
    STUDY_DESIGN_DESCRIPTION_ID        NUMBER(5)                                     NOT NULL,
    STUDY_DESIGN_ID                    NUMBER(5)                                     NOT NULL,
    DESCRIPTION_TYPE                   VARCHAR2(100)                                 NOT NULL,
    DESCRIPTION                        VARCHAR2(4000)                                NOT NULL,
    MODIFICATION_DATE                  DATE                                          NOT NULL,
    USER_READ                          NUMBER(1)                                     NOT NULL,
    USER_WRITE                         NUMBER(1)                                     NOT NULL,
    GROUP_READ                         NUMBER(1)                                     NOT NULL,
    GROUP_WRITE                        NUMBER(1)                                     NOT NULL,
    OTHER_READ                         NUMBER(1)                                     NOT NULL,
    OTHER_WRITE                        NUMBER(1)                                     NOT NULL,
    ROW_USER_ID                        NUMBER(12)                                    NOT NULL,
    ROW_GROUP_ID                       NUMBER(12)                                    NOT NULL,
    ROW_PROJECT_ID                     NUMBER(12)                                    NOT NULL,
    ROW_ALG_INVOCATION_ID              NUMBER(12)                                    NOT NULL)
 TABLESPACE @oracle_rad3Tablespace@
 STORAGE (MAXEXTENTS UNLIMITED );

CREATE TABLE @oracle_rad3@.STUDYDESIGNTYPE (
    STUDY_DESIGN_TYPE_ID               NUMBER(6)                                     NOT NULL,
    STUDY_DESIGN_ID                    NUMBER(5)                                     NOT NULL,
    ONTOLOGY_ENTRY_ID                  NUMBER(8)                                     NOT NULL,
    MODIFICATION_DATE                  DATE                                          NOT NULL,
    USER_READ                          NUMBER(1)                                     NOT NULL,
    USER_WRITE                         NUMBER(1)                                     NOT NULL,
    GROUP_READ                         NUMBER(1)                                     NOT NULL,
    GROUP_WRITE                        NUMBER(1)                                     NOT NULL,
    OTHER_READ                         NUMBER(1)                                     NOT NULL,
    OTHER_WRITE                        NUMBER(1)                                     NOT NULL,
    ROW_USER_ID                        NUMBER(12)                                    NOT NULL,
    ROW_GROUP_ID                       NUMBER(3)                                     NOT NULL,
    ROW_PROJECT_ID                     NUMBER(3)                                     NOT NULL,
    ROW_ALG_INVOCATION_ID              NUMBER(12)                                    NOT NULL)
 TABLESPACE @oracle_rad3Tablespace@
 STORAGE (MAXEXTENTS UNLIMITED );

CREATE TABLE @oracle_rad3@.STUDYFACTOR (
    STUDY_FACTOR_ID                    NUMBER(5)                                     NOT NULL,
    STUDY_DESIGN_ID                    NUMBER(5)                                     NOT NULL,
    STUDY_FACTOR_TYPE_ID               NUMBER(8)                                     NULL,
    NAME                               VARCHAR2(100)                                 NOT NULL,
    DESCRIPTION                        VARCHAR2(500)                                 NULL,
    MODIFICATION_DATE                  DATE                                          NOT NULL,
    USER_READ                          NUMBER(1)                                     NOT NULL,
    USER_WRITE                         NUMBER(1)                                     NOT NULL,
    GROUP_READ                         NUMBER(1)                                     NOT NULL,
    GROUP_WRITE                        NUMBER(1)                                     NOT NULL,
    OTHER_READ                         NUMBER(1)                                     NOT NULL,
    OTHER_WRITE                        NUMBER(1)                                     NOT NULL,
    ROW_USER_ID                        NUMBER(12)                                    NOT NULL,
    ROW_GROUP_ID                       NUMBER(12)                                    NOT NULL,
    ROW_PROJECT_ID                     NUMBER(12)                                    NOT NULL,
    ROW_ALG_INVOCATION_ID              NUMBER(12)                                    NOT NULL)
 TABLESPACE @oracle_rad3Tablespace@
 STORAGE (MAXEXTENTS UNLIMITED );

CREATE TABLE @oracle_rad3@.STUDYFACTORVALUE (
    STUDY_FACTOR_VALUE_ID              NUMBER(8)                                     NOT NULL,
    STUDY_FACTOR_ID                    NUMBER(5)                                     NOT NULL,
    ASSAY_ID                           NUMBER(8)                                     NOT NULL,
    FACTOR_VALUE                       VARCHAR2(100)                                 NOT NULL,
    NAME                               VARCHAR2(100)                                 NULL,
    MODIFICATION_DATE                  DATE                                          NOT NULL,
    USER_READ                          NUMBER(1)                                     NOT NULL,
    USER_WRITE                         NUMBER(1)                                     NOT NULL,
    GROUP_READ                         NUMBER(1)                                     NOT NULL,
    GROUP_WRITE                        NUMBER(1)                                     NOT NULL,
    OTHER_READ                         NUMBER(1)                                     NOT NULL,
    OTHER_WRITE                        NUMBER(1)                                     NOT NULL,
    ROW_USER_ID                        NUMBER(12)                                    NOT NULL,
    ROW_GROUP_ID                       NUMBER(12)                                    NOT NULL,
    ROW_PROJECT_ID                     NUMBER(12)                                    NOT NULL,
    ROW_ALG_INVOCATION_ID              NUMBER(12)                                    NOT NULL)
 TABLESPACE @oracle_rad3Tablespace@
 STORAGE (MAXEXTENTS UNLIMITED );

CREATE TABLE @oracle_rad3@.TREATMENT (
    TREATMENT_ID                       NUMBER(10)                                    NOT NULL,
    ORDER_NUM                          NUMBER(3)                                     NOT NULL,
    BIO_MATERIAL_ID                    NUMBER(5)                                     NOT NULL,
    TREATMENT_TYPE_ID                  NUMBER(5)                                     NOT NULL,
    PROTOCOL_ID                        NUMBER(10)                                    NULL,
    NAME                               VARCHAR2(100)                                 NULL,
    MODIFICATION_DATE                  DATE                                          NOT NULL,
    USER_READ                          NUMBER(1)                                     NOT NULL,
    USER_WRITE                         NUMBER(1)                                     NOT NULL,
    GROUP_READ                         NUMBER(1)                                     NOT NULL,
    GROUP_WRITE                        NUMBER(1)                                     NOT NULL,
    OTHER_READ                         NUMBER(1)                                     NOT NULL,
    OTHER_WRITE                        NUMBER(1)                                     NOT NULL,
    ROW_USER_ID                        NUMBER(12)                                    NOT NULL,
    ROW_GROUP_ID                       NUMBER(12)                                    NOT NULL,
    ROW_PROJECT_ID                     NUMBER(12)                                    NOT NULL,
    ROW_ALG_INVOCATION_ID              NUMBER(12)                                    NOT NULL)
 TABLESPACE @oracle_rad3Tablespace@
 STORAGE (MAXEXTENTS UNLIMITED );

CREATE TABLE @oracle_rad3@.TREATMENTPARAM (
    TREATMENT_PARAM_ID                 NUMBER(10)                                    NOT NULL,
    TREATMENT_ID                       NUMBER(8)                                     NOT NULL,
    PROTOCOL_PARAM_ID                  NUMBER(5)                                     NOT NULL,
    VALUE                              VARCHAR2(100)                                 NOT NULL,
    MODIFICATION_DATE                  DATE                                          NOT NULL,
    USER_READ                          NUMBER(1)                                     NOT NULL,
    USER_WRITE                         NUMBER(1)                                     NOT NULL,
    GROUP_READ                         NUMBER(1)                                     NOT NULL,
    GROUP_WRITE                        NUMBER(1)                                     NOT NULL,
    OTHER_READ                         NUMBER(1)                                     NOT NULL,
    OTHER_WRITE                        NUMBER(1)                                     NOT NULL,
    ROW_USER_ID                        NUMBER(12)                                    NOT NULL,
    ROW_GROUP_ID                       NUMBER(3)                                     NOT NULL,
    ROW_PROJECT_ID                     NUMBER(3)                                     NOT NULL,
    ROW_ALG_INVOCATION_ID              NUMBER(12)                                    NOT NULL)
 TABLESPACE @oracle_rad3Tablespace@
 STORAGE (MAXEXTENTS UNLIMITED );


/* 56 table(s) */

SPOOL OFF
SET ECHO OFF
DISCONNECT
EXIT
