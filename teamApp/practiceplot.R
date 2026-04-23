trait1 <- rice$`Seed length/width ratio`
trait2 <- rice$`Seed volume`

rice %>% 
  ggplot(rice, mapping = aes(x = trait1,
                   y = trait1)) +
  geom_point()
