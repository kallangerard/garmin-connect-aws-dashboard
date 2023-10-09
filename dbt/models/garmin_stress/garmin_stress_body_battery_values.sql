WITH battery_base AS (
  SELECT 
    userProfilePK,
    calendarDate,
    CAST(element_at(t.bodyBatteryValuesArray, 1) AS bigint) as bodyBatteryTimestamp,
    CAST(element_at(t.bodyBatteryValuesArray, 2) AS varchar) as bodyBatteryStatus,
    CAST(element_at(t.bodyBatteryValuesArray, 3) AS int) as bodyBatteryLevel,
    CAST(element_at(t.bodyBatteryValuesArray, 4) AS double) as bodyBatteryVersion
  FROM {{ source('garmin', 'garmin_stress') }}
  CROSS JOIN UNNEST(bodyBatteryValuesArray) AS t (bodyBatteryValuesArray)
)

SELECT
  userProfilePK,
  calendarDate,
  bodyBatteryTimestamp,
  bodyBatteryStatus,
  bodyBatteryLevel,
  bodyBatteryVersion
FROM battery_base