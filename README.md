# photo_scripts

A selection of useful scripts for working with images.


### Astro Star Stacking
This script takes a set of astro images and a set of black images (i.e. noise images).  It averages the noise, subtracts this from the individual star images, aligns the star images and creates an averaged star image.

Place astro_star_stacking.sh in a directory, add 2 directories blackframes and starframes.  Place CR2 files in the relevant directories and run the script.