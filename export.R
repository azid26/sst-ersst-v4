## Export SST data to CSV files
## Michael Malick


## SASAP N. Pacific SST ------------------------------------
sasap.raw <- sst_load(years    = 1950:2016,
                      months   = 1:12,
                      read.dir = "./data/rawdata/")

sasap.raw.np <- sst_subset_space(sasap.raw,
                                 lat.min = 36,
                                 lat.max = 80,
                                 lon.min = 170,
                                 lon.max = 250)

sasap.anom.np <- sst_anomaly(sasap.raw.np,
                             ref.years = 1950:2016)

sasap.raw.np.df <- sst_dataframe(sasap.raw.np)
head(sasap.raw.np.df)
tail(sasap.raw.np.df)

dat.sub <- sasap.raw.np.df[sasap.raw.np.df$year == 2015 &
                           sasap.raw.np.df$month == 3, ]
plot(dat.sub$lon, dat.sub$lat)
maps::map("world2", add = TRUE)

levelplot(sst ~ lon * lat, data = sasap.raw.np.df,
          subset = month == 1 & year == 1950,
          contour = TRUE,
          ylab = "Latitude", xlab = "Longitude")

sasap.anom.np.df <- sst_dataframe(sasap.anom.np)
head(sasap.anom.np.df)
tail(sasap.anom.np.df)
levelplot(sst ~ lon * lat, data = sasap.anom.np.df,
          subset = month == 1 & year == 2015,
          # subset = month == 1 & year == 1950,
          at = seq(-4.5, 4.5, 0.5),
          contour = TRUE,
          labels = TRUE,
          ylab = "Latitude", xlab = "Longitude")

sst_write_csv(data = sasap.raw.np.df,
              file = "./data/export/sasap-ersstv4-raw-2017-09-13.csv",
              date = Sys.time(),
              contact = "Michael Malick <malickmj@gmail.com>",
              data.type = "SST values",
              years = "1950-2016",
              months = "1-12",
              spatial.extent = "36-80N and 170-250E")

sst_write_csv(data = sasap.anom.np.df,
              file = "./data/export/sasap-ersstv4-anom-2017-09-13.csv",
              date = Sys.time(),
              contact = "Michael Malick <malickmj@gmail.com>",
              data.type = "SST anomalies (reference years = 1950-2016)",
              years = "1950-2016",
              months = "1-12",
              spatial.extent = "36-80N and 170-250E")

