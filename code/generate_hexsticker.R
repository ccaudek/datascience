

library(ggplot2)

p <- ggplot(aes(x = mpg, y = wt), data = mtcars) + 
  geom_point()
p <- p + 
  theme_void() + 
  theme_transparent()
p

sticker(p, package="CaudekLab", p_size=20, s_x=1, s_y=.75, s_width=1.3, s_height=1,
        filename="caudeklab_logo.png")



#Create Data
x1 = rnorm(100)
x2 = rnorm(100)+rep(2,100)
par(mfrow=c(2,1))

#Make the plot
par(mar=c(0,5,3,3))
hist(x1 , main="" , xlim=c(-2,5), ylab="Frequency for x1", xlab="", ylim=c(0,25) , xaxt="n", las=1 , col="slateblue1", breaks=10)
par(mar=c(5,5,0,3))
p <- hist(x2 , main="" , xlim=c(-2,5), ylab="Frequency for x2", xlab="Value of my variable", ylim=c(25,0) , las=1 , col="tomato3"  , breaks=10)

p <-  p + 
  theme_void() + 
  theme_transparent()

library(showtext)

font_add("Helvetica")

font_add("Helvetica", regular = "Helvetica.ttc")

sticker(p, package="CaudekLab", p_size=20, 
        s_x=1, s_y=.75, s_width=1.3, s_height=1,
        p_family = "Helvetica",
        p_fontface = "bold",
        p_color = "#b22222",
        h_color = "#b22222", h_fill = "#fdfbfb",
        filename="caudeklab_logo.png")
