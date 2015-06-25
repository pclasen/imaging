function ts=extract_clust_ts(filename, clustfile)

try,
  fprintf('loading %s...\n',filename);
  [d,d_dims,d_scales]=read_avw(filename);
catch,
  fprintf('Error loading file!\n');
  return;
end;

if ~iscell(clustfile),
  clustfile={clustfile};
end;
nclust=size(clustfile,2);

c=zeros([d_dims(1:3)' nclust]);
clust_vox=cell(1,nclust);

for x=1:nclust,
  fprintf('loading ROI file %d of %d: %s\n',x,nclust,clustfile{x});
  c(:,:,:,x)=read_avw(clustfile{x});
  clust_vox(x)={find(c(:,:,:,x)>0)};
end;

ntp=size(d,4);

ts=zeros(nclust,ntp);

for c=1:nclust,
  for tp=1:ntp,
    tmp=squeeze(d(:,:,:,tp));
    ts(c,tp)=mean(tmp(clust_vox{c}))';

  end;
end;
