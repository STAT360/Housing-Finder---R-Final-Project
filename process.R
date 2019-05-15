## Data processing

Alabama_Crimes <-mutate(Alabama_Crimes,STATE = "AL")
Alaska_Crimes <- mutate(Alaska_Crimes,STATE = "AK")
Arizona_Crimes <- mutate(Arizona_Crimes ,STATE = "AZ")
Arkansas_Crimes<- mutate(Arkansas_Crimes,STATE = "AR")
California_Crimes<- mutate(California_Crimes,STATE = "CA")
Connecticut_Crimes<- mutate(Connecticut_Crimes,STATE = "CT")
Colorado_Crimes<- mutate(Colorado_Crimes,STATE = "CO")
Delaware_Crimes<- mutate(Delaware_Crimes,STATE = "DE")
Florida_Crimes <- mutate(Florida_Crimes,STATE = "FL")
Georgia_Crimes<- mutate(Georgia_Crimes,STATE = "GA")
Hawaii_Crimes<- mutate(Hawaii_Crimes,STATE = "HI")
Idaho_Crimes<- mutate(Idaho_Crimes,STATE = "ID")
Illinois_Crimes<- mutate(Illinois_Crimes,STATE = "IL")
Indiana_Crimes <- mutate(Indiana_Crimes,STATE = "IN")
Iowa_Crimes<- mutate(Iowa_Crimes,STATE = "IA")
Kansas_Crimes<- mutate(Kansas_Crimes,STATE = "KS")
Kentucky_Crimes<- mutate(Kentucky_Crimes,STATE = "KY")
Louisiana_Crimes<- mutate(Louisiana_Crimes,STATE = "LA")
Maine_Crimes<- mutate(Maine_Crimes,STATE = "ME")
Maryland_Crimes<- mutate(Maryland_Crimes,STATE = "MD")
Massachusettes_Crimes<- mutate(Massachusettes_Crimes,STATE = "MA")
Michigan_Crimes<- mutate(Michigan_Crimes,STATE = "MI")
Minnesota_Crimes<- mutate(Minnesota_Crimes,STATE = "MN")
Mississippi_Crimes<- mutate(Mississippi_Crimes,STATE = "MS")
Missouri_Crimes<- mutate(Missouri_Crimes,STATE = "MO")
Montana_Crimes<- mutate(Montana_Crimes,STATE = "MT")
Nebraska_Crimes<- mutate(Nebraska_Crimes,STATE = "NE")
Nevada_Crimes<- mutate(Nevada_Crimes,STATE = "NV")
New_Hampshire_Crimes<- mutate(New_Hampshire_Crimes,STATE = "NH")
New_Jersey_Crimes<- mutate(New_Jersey_Crimes,STATE = "NJ")
New_Mexico_Crimes<- mutate(New_Mexico_Crimes,STATE = "NM")
New_York_Crimes<- mutate(New_York_Crimes,STATE = "NY")
North_Carolina_Crimes<- mutate(North_Carolina_Crimes,STATE = "NC")
North_Dakota_Crimes<- mutate(North_Dakota_Crimes,STATE = "ND")
Ohio_Crimes<- mutate(Ohio_Crimes,STATE = "OH")
Oklahoma_Crimes<- mutate(Oklahoma_Crimes,STATE = "OK")
Oregon_Crimes<- mutate(Oregon_Crimes,STATE = "OR")
Pennsylvania_Crimes<- mutate(Pennsylvania_Crimes,STATE = "PA")
Rhode_Island_Crimes<- mutate(Rhode_Island_Crimes,STATE = "RI")
South_Carolina_Crimes<- mutate(South_Carolina_Crimes,STATE = "SC")
South_Dakota_Crimes<- mutate(South_Dakota_Crimes,STATE = "SD")
Tennessee_Crimes<- mutate(Tennessee_Crimes,STATE = "TN")
Texas_Crimes<- mutate(Texas_Crimes,STATE = "TX")
Utah_Crimes<- mutate(Utah_Crimes,STATE = "UT")
Vermont_Crimes<- mutate(Vermont_Crimes,STATE = "VT")
Virginia_Crimes<- mutate(Virginia_Crimes,STATE = "VA")
Washington_Crimes<- mutate(Washington_Crimes,STATE = "WA")
West_Virginia_Crimes<- mutate(West_Virginia_Crimes,STATE = "WV")
Wisconsin_Crimes<- mutate(Wisconsin_Crimes,STATE = "WI")
Wyoming_Crimes<- mutate(Wyoming_Crimes,STATE = "WY")





























Crime_Data <- do.call("bind_rows", list(Alabama_Crimes, Alaska_Crimes,
                                        Arizona_Crimes, Arkansas_Crimes,
                                        California_Crimes, Colorado_Crimes,
                                        Connecticut_Crimes,
                                        Delaware_Crimes, Florida_Crimes,
                                        Georgia_Crimes, Hawaii_Crimes,
                                        Idaho_Crimes, Illinois_Crimes,
                                        Indiana_Crimes, Iowa_Crimes,
                                        Kansas_Crimes, Kentucky_Crimes,
                                        Louisiana_Crimes, Maine_Crimes,
                                        Maryland_Crimes, Massachusettes_Crimes,
                                        Michigan_Crimes, Minnesota_Crimes,
                                        Mississippi_Crimes, Missouri_Crimes,
                                        Montana_Crimes, Nebraska_Crimes,
                                        Nevada_Crimes, New_Hampshire_Crimes,
                                        New_Jersey_Crimes, New_Mexico_Crimes,
                                        New_York_Crimes, North_Carolina_Crimes,
                                        North_Dakota_Crimes, Ohio_Crimes,
                                        Oklahoma_Crimes, Oregon_Crimes,
                                        Pennsylvania_Crimes, Rhode_Island_Crimes,
                                        South_Carolina_Crimes, South_Dakota_Crimes,
                                        Tennessee_Crimes, Texas_Crimes, Utah_Crimes,
                                        Vermont_Crimes, Virginia_Crimes,
                                        Washington_Crimes, West_Virginia_Crimes,
                                        Wisconsin_Crimes, Wyoming_Crimes))