library(ggplot2) 
library(plyr) 
library(dplyr) 
library(gplots)
library(dygraphs)
library(tidyverse)
library(ggplot2)
library(ggpubr)
library(plotly)
library(shiny)
library(shinyWidgets)

setwd("C:/Users/idank/OneDrive/R/Statistical learning and data analysis/Lab 2/")
med_dat <-  read.delim("gtex.gct",skip=2,row.names=c(1),header=TRUE)
gen_names <- med_dat[ , 1 ]
med_dat <- med_dat[, -c(1)]
med_dat <-t(med_dat)
med_dat <- log(med_dat+1)
sd_colums <- as.data.frame(sort(apply(med_dat,2,sd),decreasing = T)) #get the data sorted by the standard division of every column
top_sd <- head(rownames(sd_colums),200) #get the 200 values with the highest SD
work_df <- med_dat[,top_sd] #this is the requested data


k_means <- function(df,k,n_iters=15,seed=FALSE){
    if(seed>0){
        set.seed(seed)
    }
    centers <- df[sample(nrow(df),k),] #samples the centers of the first K-means 'run'
    rownames(centers) <- 1:k
    temp <- 53+k
    for (i in 1:n_iters){
        euc_dist <- as.matrix(dist(as.matrix(rbind(df,centers))))[1:53,54:temp] #gets the Euclidean distance between the centers to each of the points
        cluster <- apply(euc_dist, 1, function(x) colnames(euc_dist)[which.min(x)]) #assigns to each observation the center closest to it
        within_score <- sum(apply(euc_dist, 1, FUN = min)) #gets the sum of distances between each sample and its center 
        df <- as.data.frame(cbind(df,cluster))
        df <- as.data.frame(sapply(df, as.numeric))
        new_centers <- aggregate(.~cluster,data = df,FUN = mean) %>% select(-cluster) #gets the new centers
        cluster <- df$cluster - 53
        df <- df %>% select(-cluster)
        if(identical(new_centers, centers)){break} 
        #If the condition above is met it means that the centers have remained the same and therefore there is no point in further runs of the algorithm
        centers <- new_centers
    }
    return(list(cluster,centers,within_score))
}

k_m_scatter <- function(data, nk, nIters=15,seed=FALSE){
    a <- k_means(data, nk, nIters,seed)[[1]] 
    b <- prcomp(work_df)
    b <- b$x[,1:2]
    c <- as.data.frame(cbind(a,b))
    colnames(c) <- c("cluster","PC1","PC2")
    plot_color <- c("red","yellow","blue3","chartreuse1","deeppink","orange","darkorchid2",
                    "cyan2","lightslategray","black")
    p <- ggplot(c,aes(x=PC1,y=PC2))+
        geom_point(aes(color = factor(cluster)),size=2.5,alpha=0.75)+scale_color_manual(values=plot_color)+
        theme_light()+labs(color='Cluster')+guides(color = guide_legend(override.aes = list(size=8)))+
        theme(legend.title = element_text( size=13), legend.text=element_text(size=13,face = "bold"),axis.title.x=element_text(size=13),
              axis.title.y=element_text(size=13),panel.background=element_rect(colour="black"))
    
    return(p)
}



ui <- fluidPage(

    titlePanel("The first 2 PCA components"),tags$head(tags$style('h2 {color : black;"')),
    titlePanel("clusters by K-means algorithm"),tags$head(tags$style('h2 {color : black"')),
    tags$text("Please choose the following variables:"),
#    setBackgroundImage(src= 'https://i0.wp.com/sitn.hms.harvard.edu/wp-content/uploads/2019/02/dna_spiral_dark_lines_figure_38174_1920x1080.jpg'),
    setBackgroundImage(src= 'https://assets.newatlas.com/dims4/default/dfdf1aa/2147483647/strip/true/crop/2000x1333+0+0/resize/2400x1600!/format/webp/quality/90/?url=http%3A%2F%2Fnewatlas-brightspot.s3.amazonaws.com%2F48%2F41%2F750628a74fdd93992a04904e0e94%2Fcomplete-genome.jpg'),
    
    

    sidebarLayout(
        sidebarPanel(
            sliderInput("clusters",
                        "Number of clusters:",
                        min = 2,
                        max = 10,
                        value = 3,step = 1),
            sliderInput("n_iters",
                        "Number of iterations in the K-means algorithm:",
                        min = 2,
                        max = 20,
                        value = 10,step = 2),
            checkboxInput("seed", "set seed (allows you to examine how the maximum amount of iterations affects the algorithm)",
                          value = FALSE),
        ),

        mainPanel(
           plotOutput("kplot")
        )
    )
)

server <- function(input, output) {
    output$kplot <- renderPlot({
        if(input$seed){
            seed <- 3
        }
        else{
            seed <- FALSE
        }
        k_m_scatter(work_df,input$clusters,input$n_iters,seed)

    }, height = 420, width = 700)
}

shinyApp(ui = ui, server = server)
