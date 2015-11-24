nan2na = function(dirName,fileName){

  # file
  indFile = paste(dirName,fileName,sep="") 
  
  # import data
  x = read.csv(file=indFile,sep = ",",header=FALSE)

  # change NaN to NA
  x[is.na(x)] = NA

  # save file
  write.table(x,file=indFile,sep = ",",row.names=FALSE,col.names=FALSE)

}