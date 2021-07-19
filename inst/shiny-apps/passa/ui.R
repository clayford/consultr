
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
                        helpText(includeMarkdown("one_sample_prop_help.md"))
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
                        helpText(includeMarkdown("two_sample_prop_help.md"))
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
                                   helpText(includeMarkdown("t_test_help.md"))
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
                          "Between-group standard deviation:",
                          value = 2.1),
             numericInput("within.sd",
                          "Within-group standard deviation:",
                          value = 5.5),
             sliderInput("power_4",
                         "Power:",
                         min = 0.80,max = 0.99,value = 0.80),
             sliderInput("sig.level_4",
                         "Significance Level:",
                         min = 0.01,max = 0.2,value = 0.05),
             helpText(includeMarkdown("anova_help.md"))
           ),
           mainPanel(
             plotOutput("aPlot", height = "500px"),
             verbatimTextOutput("summary.a")
           )
         ))
)
