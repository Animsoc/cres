/****** Script for TESTING  ******/
  SELECT count(*) as valid_recordS FROM [Crescendo_Source].[dbo].[soccer_sample]
  WHERE '2017'= substring(offerTimeStampUTC,1,4) AND LEN(offerid) < 11

  SELECT count(*) as fact_records FROM [Crescendo_dw].[dbo].[fact_offers]
 
  SELECT count(*) as all_records FROM [Crescendo_Source].[dbo].[soccer_sample]

  SELECT count(*) as invalid_records FROM [Crescendo_Source].[dbo].[soccer_sample]
  WHERE '2017'<> substring(offerTimeStampUTC,1,4) or LEN(offerid) > 10