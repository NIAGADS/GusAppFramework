
/*                                                                                            */
/* rad3-views.sql                                                                             */
/*                                                                                            */
/* This file was generated automatically by dumpSchema.pl on Wed Feb 12 04:00:17 EST 2003     */
/*                                                                                            */

SET ECHO ON
SPOOL rad3-views.log

CREATE VIEW @oracle_rad3@.AFFYMETRIXCEL
AS SELECT
  elementresultimp.element_result_id AS element_result_id,
  elementresultimp.element_id AS element_id,
  elementresultimp.composite_element_result_id AS composite_element_result_id,
  elementresultimp.quantification_id AS quantification_id,
  elementresultimp.subclass_view AS subclass_view,
  ElementResultImp.foreground AS mean,
  ElementResultImp.float1 AS stdv,
  ElementResultImp.int3 AS npixels,
  elementresultimp.modification_date AS modification_date,
  elementresultimp.user_read AS user_read,
  elementresultimp.user_write AS user_write,
  elementresultimp.group_read AS group_read,
  elementresultimp.group_write AS group_write,
  elementresultimp.other_read AS other_read,
  elementresultimp.other_write AS other_write,
  elementresultimp.row_user_id AS row_user_id,
  elementresultimp.row_group_id AS row_group_id,
  elementresultimp.row_project_id AS row_project_id,
  elementresultimp.row_alg_invocation_id AS row_alg_invocation_id 
FROM ElementResultImp
WHERE subclass_view = 'AffymetrixCEL' WITH CHECK OPTION;

CREATE VIEW @oracle_rad3@.AFFYMETRIXMAS4
AS SELECT
  compositeelementresultimp.composite_element_result_id AS composite_element_result_id,
  compositeelementresultimp.composite_element_id AS composite_element_id,
  compositeelementresultimp.quantification_id AS quantification_id,
  compositeelementresultimp.subclass_view AS subclass_view,
  CompositeElementResultImp.tinyint1 AS positive_probe_pairs,
  CompositeElementResultImp.tinyint2 AS negative_probe_pairs,
  CompositeElementResultImp.tinyint3 AS num_probe_pairs_used,
  CompositeElementResultImp.smallint1 AS pairs_in_average,
  CompositeElementResultImp.float1 AS log_average_ratio,
  CompositeElementResultImp.float2 AS average_difference,
  CompositeElementResultImp.string1 AS absolute_call,
  compositeelementresultimp.modification_date AS modification_date,
  compositeelementresultimp.user_read AS user_read,
  compositeelementresultimp.user_write AS user_write,
  compositeelementresultimp.group_read AS group_read,
  compositeelementresultimp.group_write AS group_write,
  compositeelementresultimp.other_read AS other_read,
  compositeelementresultimp.other_write AS other_write,
  compositeelementresultimp.row_user_id AS row_user_id,
  compositeelementresultimp.row_group_id AS row_group_id,
  compositeelementresultimp.row_project_id AS row_project_id,
  compositeelementresultimp.row_alg_invocation_id AS row_alg_invocation_id 
FROM CompositeElementResultImp
WHERE subclass_view = 'AffymetrixMAS4' WITH CHECK OPTION;

CREATE VIEW @oracle_rad3@.AFFYMETRIXMAS5
AS SELECT
  compositeelementresultimp.composite_element_result_id AS composite_element_result_id,
  compositeelementresultimp.subclass_view AS subclass_view,
  compositeelementresultimp.composite_element_id AS composite_element_id,
  compositeelementresultimp.quantification_id AS quantification_id,
  CompositeElementResultImp.float1 AS signal,
  CompositeElementResultImp.char1 AS detection,
  CompositeElementResultImp.float2 AS detection_p_value,
  CompositeElementResultImp.smallint1 AS stat_pairs,
  CompositeElementResultImp.smallint2 AS stat_pairs_used,
  compositeelementresultimp.modification_date AS modification_date,
  compositeelementresultimp.user_read AS user_read,
  compositeelementresultimp.user_write AS user_write,
  compositeelementresultimp.group_read AS group_read,
  compositeelementresultimp.group_write AS group_write,
  compositeelementresultimp.other_read AS other_read,
  compositeelementresultimp.other_write AS other_write,
  compositeelementresultimp.row_user_id AS row_user_id,
  compositeelementresultimp.row_group_id AS row_group_id,
  compositeelementresultimp.row_project_id AS row_project_id,
  compositeelementresultimp.row_alg_invocation_id AS row_alg_invocation_id 
FROM CompositeElementResultImp
WHERE SUBCLASS_VIEW = 'AffymetrixMAS5' WITH CHECK OPTION;

CREATE VIEW @oracle_rad3@.ARRAYVISIONELEMENTRESULT
AS SELECT
  elementresultimp.element_result_id AS element_result_id,
  elementresultimp.subclass_view AS subclass_view,
  elementresultimp.element_id AS element_id,
  elementresultimp.composite_element_result_id AS composite_element_result_id,
  elementresultimp.quantification_id AS quantification_id,
  elementresultimp.foreground AS foreground,
  elementresultimp.background AS background,
  ElementResultImp.foreground_sd AS sd,
  ElementResultImp.float1 AS mad,
  ElementResultImp.float2 AS signal_to_noise,
  ElementResultImp.float3 AS percent_removed,
  ElementResultImp.float4 AS percent_replaced,
  ElementResultImp.float5 AS percent_at_floor,
  ElementResultImp.float6 AS percent_at_ceiling,
  ElementResultImp.float7 AS bkg_percent_at_floor,
  ElementResultImp.float8 AS bkg_percent_at_ceiling,
  ElementResultImp.tinystring1 AS x,
  ElementResultImp.tinystring2 AS y,
  ElementResultImp.tinystring3 AS area,
  ElementResultImp.tinyint1 AS flag,
  ElementResultImp.modification_date AS modification_date,
  ElementResultImp.user_read AS user_read,
  ElementResultImp.user_write AS user_write,
  ElementResultImp.group_read AS group_read,
  ElementResultImp.group_write AS group_write,
  ElementResultImp.other_read AS other_read,
  ElementResultImp.other_write AS other_write,
  ElementResultImp.row_user_id AS row_user_id,
  ElementResultImp.row_group_id AS row_group_id,
  ElementResultImp.row_project_id AS row_project_id,
  ElementResultImp.row_alg_invocation_id AS row_alg_invocation_id 
FROM ElementResultImp
WHERE subclass_view = 'ArrayVisionElementResult' WITH CHECK OPTION;

CREATE VIEW @oracle_rad3@.BIOMATERIAL
AS SELECT
  biomaterialimp.bio_material_id AS bio_material_id,
  biomaterialimp.subclass_view AS subclass_view,
  biomaterialimp.bio_material_type_id AS bio_material_type_id,
  biomaterialimp.external_database_release_id AS external_database_release_id,
  biomaterialimp.source_id AS source_id,
  biomaterialimp.modification_date AS modification_date,
  biomaterialimp.user_read AS user_read,
  biomaterialimp.user_write AS user_write,
  biomaterialimp.group_read AS group_read,
  biomaterialimp.group_write AS group_write,
  biomaterialimp.other_read AS other_read,
  biomaterialimp.other_write AS other_write,
  biomaterialimp.row_user_id AS row_user_id,
  biomaterialimp.row_group_id AS row_group_id,
  biomaterialimp.row_project_id AS row_project_id,
  biomaterialimp.row_alg_invocation_id AS row_alg_invocation_id 
FROM BioMaterialImp
where subclass_view = 'BioMaterial' with check option;

CREATE VIEW @oracle_rad3@.BIOSAMPLE
AS SELECT
  biomaterialimp.bio_material_id AS bio_material_id,
  biomaterialimp.subclass_view AS subclass_view,
  biomaterialimp.bio_material_type_id AS bio_material_type_id,
  biomaterialimp.external_database_release_id AS external_database_release_id,
  biomaterialimp.source_id AS source_id,
  BioMaterialImp.string1 AS name,
  BioMaterialImp.string2 AS description,
  biomaterialimp.modification_date AS modification_date,
  biomaterialimp.user_read AS user_read,
  biomaterialimp.user_write AS user_write,
  biomaterialimp.group_read AS group_read,
  biomaterialimp.group_write AS group_write,
  biomaterialimp.other_read AS other_read,
  biomaterialimp.other_write AS other_write,
  biomaterialimp.row_user_id AS row_user_id,
  biomaterialimp.row_group_id AS row_group_id,
  biomaterialimp.row_project_id AS row_project_id,
  biomaterialimp.row_alg_invocation_id AS row_alg_invocation_id 
FROM BioMaterialImp
where subclass_view = 'BioSample' WITH CHECK OPTION;

CREATE VIEW @oracle_rad3@.BIOSOURCE
( BIO_MATERIAL_ID,
  SUBCLASS_VIEW,
  TAXON_ID,
  BIO_MATERIAL_TYPE_ID,
  BIO_SOURCE_PROVIDER_ID,
  EXTERNAL_DATABASE_RELEASE_ID,
  SOURCE_ID,
  NAME,
  DESCRIPTION,
  MODIFICATION_DATE,
  USER_READ,
  USER_WRITE,
  GROUP_READ,
  GROUP_WRITE,
  OTHER_READ,
  OTHER_WRITE,
  ROW_USER_ID,
  ROW_GROUP_ID,
  ROW_PROJECT_ID,
  ROW_ALG_INVOCATION_ID )
AS SELECT BioMaterialImp.bio_material_id,
BioMaterialImp.subclass_view,
BioMaterialImp.taxon_id,
BioMaterialImp.bio_material_type_id,
BioMaterialImp.bio_source_provider_id,
BioMaterialImp.external_database_release_id,
BioMaterialImp.source_id,
BioMaterialImp.string1 AS name,
BioMaterialImp.string2 AS description,
BioMaterialImp.modification_date,
BioMaterialImp.user_read,
BioMaterialImp.user_write,
BioMaterialImp.group_read,
BioMaterialImp.group_write,
BioMaterialImp.other_read,
BioMaterialImp.other_write,
BioMaterialImp.row_user_id,
BioMaterialImp.row_group_id,
BioMaterialImp.row_project_id,
BioMaterialImp.row_alg_invocation_id
FROM BioMaterialImp
where bio_source_provider_id is not null
and subclass_view='BioSource' WITH CHECK OPTION;

CREATE VIEW @oracle_rad3@.COMPOSITEELEMENT
AS SELECT
  compositeelementimp.composite_element_id AS composite_element_id,
  compositeelementimp.subclass_view AS subclass_view,
  compositeelementimp.parent_id AS parent_id,
  compositeelementimp.array_id AS array_id,
  compositeelementimp.external_database_release_id AS external_database_release_id,
  compositeelementimp.source_id AS source_id,
  compositeelementimp.modification_date AS modification_date,
  compositeelementimp.user_read AS user_read,
  compositeelementimp.user_write AS user_write,
  compositeelementimp.group_read AS group_read,
  compositeelementimp.group_write AS group_write,
  compositeelementimp.other_read AS other_read,
  compositeelementimp.other_write AS other_write,
  compositeelementimp.row_user_id AS row_user_id,
  compositeelementimp.row_group_id AS row_group_id,
  compositeelementimp.row_project_id AS row_project_id,
  compositeelementimp.row_alg_invocation_id AS row_alg_invocation_id 
FROM CompositeElementImp
where subclass_view = 'CompositeElement' with check option;

CREATE VIEW @oracle_rad3@.COMPOSITEELEMENTRESULT
AS SELECT
  compositeelementresultimp.composite_element_result_id AS composite_element_result_id,
  compositeelementresultimp.subclass_view AS subclass_view,
  compositeelementresultimp.composite_element_id AS composite_element_id,
  compositeelementresultimp.quantification_id AS quantification_id,
  compositeelementresultimp.modification_date AS modification_date,
  compositeelementresultimp.user_read AS user_read,
  compositeelementresultimp.user_write AS user_write,
  compositeelementresultimp.group_read AS group_read,
  compositeelementresultimp.group_write AS group_write,
  compositeelementresultimp.other_read AS other_read,
  compositeelementresultimp.other_write AS other_write,
  compositeelementresultimp.row_user_id AS row_user_id,
  compositeelementresultimp.row_group_id AS row_group_id,
  compositeelementresultimp.row_project_id AS row_project_id,
  compositeelementresultimp.row_alg_invocation_id AS row_alg_invocation_id 
FROM CompositeElementResultImp
WHERE CompositeElementResultImp.SUBCLASS_VIEW = 'CompositeElementResult' WITH CHECK OPTION;

CREATE VIEW @oracle_rad3@.ELEMENT
AS SELECT
  elementimp.element_id AS element_id,
  elementimp.subclass_view AS subclass_view,
  elementimp.element_type_id AS element_type_id,
  elementimp.composite_element_id AS composite_element_id,
  elementimp.array_id AS array_id,
  elementimp.external_database_release_id AS external_database_release_id,
  elementimp.source_id AS source_id,
  elementimp.modification_date AS modification_date,
  elementimp.user_read AS user_read,
  elementimp.user_write AS user_write,
  elementimp.group_read AS group_read,
  elementimp.group_write AS group_write,
  elementimp.other_read AS other_read,
  elementimp.other_write AS other_write,
  elementimp.row_user_id AS row_user_id,
  elementimp.row_group_id AS row_group_id,
  elementimp.row_project_id AS row_project_id,
  elementimp.row_alg_invocation_id AS row_alg_invocation_id 
FROM ElementImp
where subclass_view = 'Element' with check option;

CREATE VIEW @oracle_rad3@.ELEMENTRESULT
AS SELECT
  elementresultimp.element_result_id AS element_result_id,
  elementresultimp.subclass_view AS subclass_view,
  elementresultimp.element_id AS element_id,
  elementresultimp.composite_element_result_id AS composite_element_result_id,
  elementresultimp.quantification_id AS quantification_id,
  elementresultimp.foreground AS foreground,
  elementresultimp.background AS background,
  elementresultimp.foreground_sd AS foreground_sd,
  elementresultimp.background_sd AS background_sd,
  elementresultimp.modification_date AS modification_date,
  elementresultimp.user_read AS user_read,
  elementresultimp.user_write AS user_write,
  elementresultimp.group_read AS group_read,
  elementresultimp.group_write AS group_write,
  elementresultimp.other_read AS other_read,
  elementresultimp.other_write AS other_write,
  elementresultimp.row_user_id AS row_user_id,
  elementresultimp.row_group_id AS row_group_id,
  elementresultimp.row_project_id AS row_project_id,
  elementresultimp.row_alg_invocation_id AS row_alg_invocation_id 
FROM ElementResultImp
WHERE subclass_view = 'ElementResult' WITH CHECK OPTION;

CREATE VIEW @oracle_rad3@.GEMTOOLSELEMENTRESULT
AS SELECT ElementResultImp.element_result_id AS element_result_id,
ElementResultImp.element_id AS element_id,
ElementResultImp.composite_element_result_id AS composite_element_result_id,
ElementResultImp.quantification_id AS quantification_id,
ElementResultImp.subclass_view AS subclass_view,
ElementResultImp.float1 AS signal,
ElementResultImp.float2 AS signal_to_background,
ElementResultImp.float3	as area_percentage,
ElementResultImp.tinyint1 AS visual_flag,
ElementResultImp.modification_date AS modification_date,
ElementResultImp.user_read AS user_read,
ElementResultImp.user_write AS user_write,
ElementResultImp.group_read AS group_read,
ElementResultImp.group_write AS group_write,
ElementResultImp.other_read AS other_read,
ElementResultImp.other_write AS other_write,
ElementResultImp.row_user_id AS row_user_id,
ElementResultImp.row_group_id AS row_group_id,
ElementResultImp.row_project_id AS row_project_id,
ElementResultImp.row_alg_invocation_id AS row_alg_invocation_id
FROM ElementResultImp WHERE subclass_view = 'GEMToolsElementResult' WITH CHECK OPTION;

CREATE VIEW @oracle_rad3@.GENEPIXELEMENTRESULT
AS SELECT
  element_result_id,
  element_id,
  composite_element_result_id,
  quantification_id,
  subclass_view,
  foreground_sd,
  background_sd,
  float1 AS spot_diameter,
  float2 AS foreground_mean,
  float3 AS foreground_median,
  float4 AS background_mean,
  float5 AS background_median,
  float6 AS percent_over_bg_plus_one_sd,
  float7 AS percent_over_bg_plus_two_sds,
  float8 AS percent_foreground_saturated,
  float9 AS mean_of_ratios,
  float10 AS median_of_ratios,
  float11 AS ratios_sd,
  smallint1 AS num_foreground_pixels,
  smallint2 AS num_background_pixels,
  tinyint1 AS flag,
  modification_date,
  user_read,
  user_write,
  group_read,
  group_write,
  other_read,
  other_write,
  row_user_id,
  row_group_id,
  row_project_id,
  row_alg_invocation_id 
FROM ElementResultImp
WHERE subclass_view = 'GenePixElementResult' WITH CHECK OPTION;

CREATE VIEW @oracle_rad3@.LABELEDEXTRACT
( BIO_MATERIAL_ID,
  SUBCLASS_VIEW,
  BIO_MATERIAL_TYPE_ID,
  LABEL_METHOD_ID,
  EXTERNAL_DATABASE_RELEASE_ID,
  SOURCE_ID,
  NAME,
  DESCRIPTION,
  MODIFICATION_DATE,
  USER_READ,
  USER_WRITE,
  GROUP_READ,
  GROUP_WRITE,
  OTHER_READ,
  OTHER_WRITE,
  ROW_USER_ID,
  ROW_GROUP_ID,
  ROW_PROJECT_ID,
  ROW_ALG_INVOCATION_ID )
AS SELECT BioMaterialImp.bio_material_id,
BioMaterialImp.subclass_view,
BioMaterialImp.bio_material_type_id,
BioMaterialImp.label_method_id,
BioMaterialImp.external_database_release_id,
BioMaterialImp.source_id,
BioMaterialImp.string1 AS name,
BioMaterialImp.string2 AS description,
BioMaterialImp.modification_date,
BioMaterialImp.user_read,
BioMaterialImp.user_write,
BioMaterialImp.group_read,
BioMaterialImp.group_write,
BioMaterialImp.other_read,
BioMaterialImp.other_write,
BioMaterialImp.row_user_id,
BioMaterialImp.row_group_id,
BioMaterialImp.row_project_id,
BioMaterialImp.row_alg_invocation_id
FROM BioMaterialImp
WHERE LABEL_METHOD_ID is not null
AND SUBCLASS_VIEW = 'LabeledExtract' WITH CHECK OPTION;

CREATE VIEW @oracle_rad3@.MOIDRESULT
AS SELECT CompositeElementResultImp.composite_element_result_id AS composite_element_result_id,
CompositeElementResultImp.composite_element_id AS composite_element_id,
CompositeElementResultImp.quantification_id AS quantification_id,
CompositeElementResultImp.subclass_view AS subclass_view,
CompositeElementResultImp.float1 AS expression,
CompositeElementResultImp.float2 AS lower_bound,
CompositeElementResultImp.float3 AS upper_bound,
CompositeElementResultImp.float4 AS log_p,
CompositeElementResultImp.modification_date,
CompositeElementResultImp.user_read ,
CompositeElementResultImp.user_write ,
CompositeElementResultImp.group_read ,
CompositeElementResultImp.group_write ,
CompositeElementResultImp.other_read ,
CompositeElementResultImp.other_write ,
CompositeElementResultImp.row_user_id ,
CompositeElementResultImp.row_group_id ,
CompositeElementResultImp.row_project_id,
CompositeElementResultImp.row_alg_invocation_id
FROM CompositeElementResultImp WHERE subclass_view = 'MOIDResult'
WITH CHECK OPTION;

CREATE VIEW @oracle_rad3@.SAGETAG
AS SELECT
  compositeelementimp.composite_element_id AS composite_element_id,
  compositeelementimp.subclass_view AS subclass_view,
  compositeelementimp.parent_id AS parent_id,
  compositeelementimp.array_id AS array_id,
  CompositeElementImp.tinystring1 AS tag,
  compositeelementimp.modification_date AS modification_date,
  compositeelementimp.user_read AS user_read,
  compositeelementimp.user_write AS user_write,
  compositeelementimp.group_read AS group_read,
  compositeelementimp.group_write AS group_write,
  compositeelementimp.other_read AS other_read,
  compositeelementimp.other_write AS other_write,
  compositeelementimp.row_user_id AS row_user_id,
  compositeelementimp.row_group_id AS row_group_id,
  compositeelementimp.row_project_id AS row_project_id,
  compositeelementimp.row_alg_invocation_id AS row_alg_invocation_id 
FROM CompositeElementImp
WHERE subclass_view = 'SAGETag' WITH CHECK OPTION;

CREATE VIEW @oracle_rad3@.SAGETAGMAPPING
AS SELECT
  elementimp.element_id AS element_id,
  elementimp.subclass_view AS subclass_view,
  elementimp.array_id AS array_id,
  elementimp.composite_element_id AS composite_element_id,
  elementimp.external_database_release_id AS external_database_release_id,
  elementimp.source_id AS source_id,
  elementimp.modification_date AS modification_date,
  elementimp.user_read AS user_read,
  elementimp.user_write AS user_write,
  elementimp.group_read AS group_read,
  elementimp.group_write AS group_write,
  elementimp.other_read AS other_read,
  elementimp.other_write AS other_write,
  elementimp.row_user_id AS row_user_id,
  elementimp.row_group_id AS row_group_id,
  elementimp.row_project_id AS row_project_id,
  elementimp.row_alg_invocation_id AS row_alg_invocation_id 
FROM ElementImp
WHERE subclass_view = 'SAGETagMapping' WITH CHECK OPTION;

CREATE VIEW @oracle_rad3@.SAGETAGRESULT
AS SELECT CompositeElementResultImp.composite_element_result_id AS composite_element_result_id,
CompositeElementResultImp.composite_element_id AS composite_element_id,
CompositeElementResultImp.quantification_id AS quantification_id,
CompositeElementResultImp.subclass_view AS subclass_view,
CompositeElementResultImp.int1 AS tag_count,
CompositeElementResultImp.modification_date,
CompositeElementResultImp.user_read ,
CompositeElementResultImp.user_write ,
CompositeElementResultImp.group_read ,
CompositeElementResultImp.group_write ,
CompositeElementResultImp.other_read ,
CompositeElementResultImp.other_write ,
CompositeElementResultImp.row_user_id ,
CompositeElementResultImp.row_group_id ,
CompositeElementResultImp.row_project_id,
CompositeElementResultImp.row_alg_invocation_id
FROM CompositeElementResultImp WHERE subclass_view = 'SAGETagResult'
WITH CHECK OPTION;

CREATE VIEW @oracle_rad3@.SCANALYZEELEMENTRESULT
AS SELECT
  elementresultimp.element_result_id AS element_result_id,
  elementresultimp.element_id AS element_id,
  elementresultimp.composite_element_result_id AS composite_element_result_id,
  elementresultimp.quantification_id AS quantification_id,
  elementresultimp.subclass_view AS subclass_view,
  ElementResultImp.foreground AS i,
  ElementResultImp.background AS b,
  ElementResultImp.float1 AS ba,
  ElementResultImp.int1 AS spix,
  ElementResultImp.int2 AS bgpix,
  ElementResultImp.int3 AS top,
  ElementResultImp.int4 AS left,
  ElementResultImp.int5 AS bot,
  ElementResultImp.int6 AS right,
  ElementResultImp.tinyint1 AS flag,
  ElementResultImp.float2 AS mrat,
  ElementResultImp.float3 AS regr,
  ElementResultImp.float4 AS corr,
  ElementResultImp.float5 AS lfrat,
  ElementResultImp.float6 AS gtb1,
  ElementResultImp.float7 AS gtb2,
  ElementResultImp.float8 AS edgea,
  ElementResultImp.float9 AS ksd,
  ElementResultImp.float10 AS ksp,
  elementresultimp.modification_date AS modification_date,
  elementresultimp.user_read AS user_read,
  elementresultimp.user_write AS user_write,
  elementresultimp.group_read AS group_read,
  elementresultimp.group_write AS group_write,
  elementresultimp.other_read AS other_read,
  elementresultimp.other_write AS other_write,
  elementresultimp.row_user_id AS row_user_id,
  elementresultimp.row_group_id AS row_group_id,
  elementresultimp.row_project_id AS row_project_id,
  elementresultimp.row_alg_invocation_id AS row_alg_invocation_id 
FROM ElementResultImp
WHERE subclass_view = 'ScanAlyzeElementResult' WITH CHECK OPTION;

CREATE VIEW @oracle_rad3@.SHORTOLIGO
AS SELECT
  elementimp.element_id AS element_id,
  elementimp.subclass_view AS subclass_view,
  elementimp.array_id AS array_id,
  elementimp.composite_element_id AS composite_element_id,
  ElementImp.smallstring2 AS name,
  ElementImp.tinystring1 AS x_position,
  ElementImp.tinystring2 AS y_position,
  ElementImp.smallstring1 AS sequence,
  ElementImp.string1 AS description,
  elementimp.modification_date AS modification_date,
  elementimp.user_read AS user_read,
  elementimp.user_write AS user_write,
  elementimp.group_read AS group_read,
  elementimp.group_write AS group_write,
  elementimp.other_read AS other_read,
  elementimp.other_write AS other_write,
  elementimp.row_user_id AS row_user_id,
  elementimp.row_group_id AS row_group_id,
  elementimp.row_project_id AS row_project_id,
  elementimp.row_alg_invocation_id AS row_alg_invocation_id 
FROM ElementImp
WHERE subclass_view = 'ShortOligo' WITH CHECK OPTION;

CREATE VIEW @oracle_rad3@.SHORTOLIGOFAMILY
AS SELECT
  compositeelementimp.composite_element_id AS composite_element_id,
  compositeelementimp.subclass_view AS subclass_view,
  compositeelementimp.parent_id AS parent_id,
  compositeelementimp.array_id AS array_id,
  compositeelementimp.external_database_release_id AS external_database_release_id,
  compositeelementimp.source_id AS source_id,
  CompositeElementImp.smallstring1 AS name,
  CompositeElementImp.string1 AS description,
  compositeelementimp.modification_date AS modification_date,
  compositeelementimp.user_read AS user_read,
  compositeelementimp.user_write AS user_write,
  compositeelementimp.group_read AS group_read,
  compositeelementimp.group_write AS group_write,
  compositeelementimp.other_read AS other_read,
  compositeelementimp.other_write AS other_write,
  compositeelementimp.row_user_id AS row_user_id,
  compositeelementimp.row_group_id AS row_group_id,
  compositeelementimp.row_project_id AS row_project_id,
  compositeelementimp.row_alg_invocation_id AS row_alg_invocation_id 
FROM CompositeElementImp
WHERE subclass_view = 'ShortOligoFamily' WITH CHECK OPTION;

CREATE VIEW @oracle_rad3@.SPOT
AS SELECT
  elementimp.element_id AS element_id,
  elementimp.subclass_view AS subclass_view,
  elementimp.array_id AS array_id,
  elementimp.element_type_id AS element_type_id,
  elementimp.composite_element_id AS composite_element_id,
  elementimp.external_database_release_id AS external_database_release_id,
  elementimp.source_id AS source_id,
  ElementImp.char1 AS array_row,
  ElementImp.char2 AS array_column,
  ElementImp.char3 AS grid_row,
  ElementImp.char4 AS grid_column,
  ElementImp.char5 AS sub_row,
  ElementImp.char6 AS sub_column,
  ElementImp.tinyint1 AS sequence_verified,
  ElementImp.tinystring1 AS name,
  ElementImp.string1 AS description,
  elementimp.modification_date AS modification_date,
  elementimp.user_read AS user_read,
  elementimp.user_write AS user_write,
  elementimp.group_read AS group_read,
  elementimp.group_write AS group_write,
  elementimp.other_read AS other_read,
  elementimp.other_write AS other_write,
  elementimp.row_user_id AS row_user_id,
  elementimp.row_group_id AS row_group_id,
  elementimp.row_project_id AS row_project_id,
  elementimp.row_alg_invocation_id AS row_alg_invocation_id 
FROM ElementImp
WHERE subclass_view = 'Spot' WITH CHECK OPTION;

CREATE VIEW @oracle_rad3@.SPOTELEMENTRESULT
AS SELECT ElementResultImp.element_result_id AS element_result_id,
ElementResultImp.element_id AS element_id,
ElementResultImp.composite_element_result_id AS composite_element_result_id,
ElementResultImp.quantification_id AS quantification_id,
ElementResultImp.subclass_view AS subclass_view,
ElementResultImp.foreground AS median,
ElementResultImp.background AS morph,
ElementResultImp.foreground_sd AS iqr,
ElementResultImp.float1 AS mean,
ElementResultImp.float2 AS bg_median,
ElementResultImp.float3	as bg_mean,
ElementResultImp.float4 AS bg_sd,
ElementResultImp.float5 AS valley,
ElementResultImp.float6 AS morph_erode,
ElementResultImp.float7 AS morph_close_open,
ElementResultImp.int1 AS area,
ElementResultImp.int2 AS perimeter,
ElementResultImp.float8 AS circularity,
ElementResultImp.tinyint1 AS badspot,
ElementResultImp.tinyint2 AS visual_flag,
ElementResultImp.modification_date AS modification_date,
ElementResultImp.user_read AS user_read,
ElementResultImp.user_write AS user_write,
ElementResultImp.group_read AS group_read,
ElementResultImp.group_write AS group_write,
ElementResultImp.other_read AS other_read,
ElementResultImp.other_write AS other_write,
ElementResultImp.row_user_id AS row_user_id,
ElementResultImp.row_group_id AS row_group_id,
ElementResultImp.row_project_id AS row_project_id,
ElementResultImp.row_alg_invocation_id AS row_alg_invocation_id
FROM ElementResultImp WHERE subclass_view = 'SpotElementResult'
WITH CHECK OPTION;

CREATE VIEW @oracle_rad3@.SPOTFAMILY
AS SELECT
  compositeelementimp.composite_element_id AS composite_element_id,
  compositeelementimp.subclass_view AS subclass_view,
  compositeelementimp.parent_id AS parent_id,
  compositeelementimp.array_id AS array_id,
  compositeelementimp.external_database_release_id AS external_database_release_id,
  compositeelementimp.source_id AS source_id,
  CompositeElementImp.smallstring1 AS plate_name,
  CompositeElementImp.smallstring2 AS well_location,
  CompositeElementImp.tinyint1 AS pcr_failure_flag,
  CompositeElementImp.string2 AS name,
  CompositeElementImp.string1 AS description,
  compositeelementimp.modification_date AS modification_date,
  compositeelementimp.user_read AS user_read,
  compositeelementimp.user_write AS user_write,
  compositeelementimp.group_read AS group_read,
  compositeelementimp.group_write AS group_write,
  compositeelementimp.other_read AS other_read,
  compositeelementimp.other_write AS other_write,
  compositeelementimp.row_user_id AS row_user_id,
  compositeelementimp.row_group_id AS row_group_id,
  compositeelementimp.row_project_id AS row_project_id,
  compositeelementimp.row_alg_invocation_id AS row_alg_invocation_id 
FROM CompositeElementImp
where subclass_view = 'SpotFamily' with check option;


/* 24 view(s) */

SPOOL OFF
SET ECHO OFF
DISCONNECT
EXIT
