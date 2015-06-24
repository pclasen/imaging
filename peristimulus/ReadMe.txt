Julius,
I have written some matlab code that will compute the HRF at each voxel
for each condition in an event-related analysis.  It's attached here
with a brief explanation. I am also including a matlab program called
extract_clust_ts.m that will extract the timeseries from a 4-D analyze
file across an ROI defined by an image mask; once you've estimated the
HRFs at each voxel using selective_avg.m, you can use this to get the
average across a region.  Unfortunately I don't have any documentation
for these yet (other than what I've attached below), but I'm working on
it.
cheers
russ

Begin forwarded message:

> attached you will find two files, selective_avg.m and
> designconvert.sed.  the former is the main program to do the selective
> averaging, the latter is a sed file that I use to convert the
> design.fsf file into a matlab file, so that I have access to all of
> the design parameters.  here is the usage for selective_avg.m:
>
> % selective averaging for FSL feat analysis
> % read in a 4-d analyze file
> % compute selective average on all in-mask voxels
> %
> % required arguments:
> % params: a struct containing details about analysis:
> %     params.featdir: FEAT directory for analysis
> %     params.ter - effective temporal resolution of analysis
> %        - note: Image Processing  Toolbox is required for TER ~= TR
> %     params.PosWindow - positive time window for averaging
> (default=24 s)
> %     params.NegWindow - negative time window for averaging (default=4
> s)
> %     params.sed_converter - full path of designconvert.sed
>
> you first need to create the params structure that contains at least
> params.featdir (specifying the location of a first-level featdir) and
> params.sed_converter (specifying the location of designconvert.sed).
> what the program does is load flitered_func_data.img, convert
> design.fsf to design.m, load the design specification files (it should
> work with either 1-column or 3-column design files, but I've not
> tested it extensively with the 1-column files), perform selective
> averaging at each voxel, then write out a 4-D volume with peristimulus
> time as the 4th dimension into a subdirectory called roi.  If
> registration has been performed, it will also create a registered
> version of the dataset in reg/roi. it makes a separate file for each
> condition, using the names from the design files. these files can
> then, e.g. be used to view the evoked response at each voxel using
> fslview.
>
> the program has not been tested at all with blocked designs and
> probably won't work with them, unless they are specified using an
> external file (as event-related designs usually are).
>
> I have run some validation with synthetic data and the program appears
> to do the right thing, but it is alpha level so please beware of
> possible bugs.  Let me know if you have any problems or questions.
>
> cheers
> rp
>
