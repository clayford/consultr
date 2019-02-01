
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

navbarPage("Sample Size Analysis",
           tabPanel("One-Sample Proportion",
                    sidebarLayout(
                      sidebarPanel(
                        sliderInput("p1",
                                    "Alternate proportion:",
                                    min = 0.01,max = 0.99,value = 0.60),
                        sliderInput("p2",
                                    "Null proportion:",
                                    min = 0.01,max = 0.99,value = 0.50),
                        sliderInput("power",
                                    "Power:",
                                    min = 0.80,max = 0.99,value = 0.80),
                        sliderInput("sig.level",
                                    "Significance Level:",
                                    min = 0.01,max = 0.2,value = 0.05),
                        selectInput("alternative", "Alternative:", 
                                    choices = list("two.sided" = "two.sided", "less" = "less", "greater" = "greater"), 
                                    selected = "two.sided"),
                        helpText("Example: we think people place name tags on the left side of their chest 
                                  75% percent of the time versus random chance (50%). What sample size do we 
                                  need to show this assuming a significance level (Type I error) of 0.05 and 
                                 a desired power of 0.80?\n\nSet the Alternate proportion to 0.75 and the Null
                                 Proportion to 0.50. Since our hypothesis is greater than 0.50, we would also set 
                                 Alternative to 'greater'. However it is common practice and more conservative to 
                                 assume a 'two-sided' alternative.")
                      ),
                    mainPanel(
                      plotOutput("p1Plot", height = "500px"),
                      verbatimTextOutput("summary.1p")
                    )
           )),
           tabPanel("Two-Sample Proportion",
                    sidebarLayout(
                      sidebarPanel(
                        sliderInput("p1_two",
                                    "Group 1 proportion:",
                                    min = 0.01,max = 0.99,value = 0.60),
                        sliderInput("p2_two",
                                    "Group 2 proportion:",
                                    min = 0.01,max = 0.99,value = 0.50),
                        sliderInput("power_two",
                                    "Power:",
                                    min = 0.80,max = 0.99,value = 0.80),
                        sliderInput("sig.level_two",
                                    "Significance Level:",
                                    min = 0.01,max = 0.2,value = 0.05),
                        selectInput("alternative_two", "Alternative:", 
                                    choices = list("two.sided" = "two.sided", "less" = "less", "greater" = "greater"), 
                                    selected = "two.sided"),
                        helpText("Example: we want to randomly sample male and female undergraduate students and 
                                  ask them if they consume alcohol at least once a week. Our null hypothesis is no 
                                  difference in the proportion that answer yes. Our alternative hypothesis is that there 
                                  is a difference. (two-sided; one gender has higher proportion, we don't know which.) 
                                  We want to detect a difference as small as 5%. How many students do we need to sample
                                  in each group if we want 80% power and a significance level of 0.05? Set the Group 1 
                                 proportion to, say, 15%, and the group proportion to 10%.")
                      ),
                    mainPanel(
                      plotOutput("p2Plot", height = "500px"),
                      verbatimTextOutput("summary.2p")
                    )
           )),
#             navbarMenu("More",
                      tabPanel("T-Test",
                               sidebarLayout(
                                 sidebarPanel(
                                   numericInput("delta",
                                               "True difference in means:",
                                               value = 1),
                                   numericInput("sd",
                                               "Standard Deviation:",
                                               value = 1),
                                   sliderInput("power_3",
                                               "Power:",
                                               min = 0.80,max = 0.99,value = 0.80),
                                   sliderInput("sig.level_3",
                                               "Significance Level:",
                                               min = 0.01,max = 0.2,value = 0.05),
                                   selectInput("type", "Type of T-test:", 
                                               choices = list("two.sample" = "two.sample", 
                                                              "one.sample" = "one.sample", 
                                                              "paired" = "paired"), 
                                               selected = "two.sample"),
                                   selectInput("alternative_3", "Alternative:", 
                                               choices = list("two.sided" = "two.sided", "less" = "less", 
                                                              "greater" = "greater"), 
                                               selected = "two.sided"),
                                   helpText("Two-sample Example: we want to know if there is a difference in the mean price of
                                            what male and female students pay at a library coffee shop. Let's say we
                                            want to detect a difference as large as 75 cents and we assume the 
                                            standard deviation of purchases for each gender $2.25. Set True Different 
                                            in Means to 0.75 and Standard Deviation to 2.25."),
                                   helpText("One-sample Example: we think the average purchase price at a Library coffee
                                            shop is over $3 per student. Our null is $3 or less; our alternative is 
                                            greater than $3. If the true average purchase price is $3.50, we would like
                                            to have 90% power to declare the estimated average purchase price is 
                                            greater than $3. How many transactions do we need to observe assuming a 
                                            significance level of 0.05 and a purchase price standard deviation of $2.25?
                                            Set True Difference in Means to 0.5, set Standard Deviation to 2.25, set Power to 
                                            0.9, select Type 'One-Sample', and select Alternative 'Greater'."),
                                   helpText("Paired T-test Example: We want to know if an ultraheavy rope-jumping program 
                                            decreases 40-yard dash time. We'll recruit students and measure their 40 time 
                                            before the program and after. Assume the standard deviation of the differences
                                            (after time - before time, for each student) will be about 0.25. How many 
                                            students do we need to recruit to detect a improvement of 0.08 sections with 
                                            80% power and 0.05 significance? Set True Difference in Means to -0.08, 
                                            Standard Deviation to 0.25, and Type as 'paired'")
                                 ),
                                 mainPanel(
                                   plotOutput("tPlot", height = "500px"),
                                   verbatimTextOutput("summary.t")
                                 )
                               )),
tabPanel("ANOVA",
         sidebarLayout(
           sidebarPanel(
             numericInput("groups",
                          "Number of groups:",
                          value = 3),
             numericInput("between.sd",
                          "Between group standard deviation:",
                          value = 2.1),
             numericInput("within.sd",
                          "Within group standard deviation:",
                          value = 5.5),
             sliderInput("power_4",
                         "Power:",
                         min = 0.80,max = 0.99,value = 0.80),
             sliderInput("sig.level_4",
                         "Significance Level:",
                         min = 0.01,max = 0.2,value = 0.05),
             helpText("Example: Let's say you're a web developer and you're interested in 3 web site designs for 
                      a client. You want to know which design helps users find information fastest, or which design
                      requires the most time. You design an experiment where you have 3 groups of randomly 
                      selected people use one of the 3 designs to find some piece of information and you record how 
                      long it takes. (All groups look for the same information.) How many people do you need in each
                      group if you believe two of the designs will take 30 seconds and one will take 25
                      seconds? Assume population standard deviation is 5 seconds and that you want power and 
                      significance levels of 0.8 and 0.05. Calculate the standard deviation of the three times (2.88) 
                      and enter in the Between group standard deviation field. Enter 5 in the Within group standard 
                      deviation field and set number of groups to 3.")
           ),
           mainPanel(
             plotOutput("aPlot", height = "500px"),
             verbatimTextOutput("summary.a")
           )
         ))

#            )
)
