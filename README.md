# stateCollector

It collectin info how often CPU work in certain frequency. 
For now it work only in linux systems(because it works due parsing /proc/cpuinfo). 
If you know how implement this for other OS you suggest it please.

### How run :

```r
ruby stats.rb
``` 

In output it give `conf.json` file where will have written 
CPU frequency and how many times it was applied, by the end of 
the program runed. But it not human readable, therefore i was wrote
small script whole converts all counts to percentages. 
For run it just execute this:

```
ruby transform.rb
```

In output it gives `transformed.json` who you can open via Friefox
but it seems very confusing so that in the future I want add to this
transforming to google chart 