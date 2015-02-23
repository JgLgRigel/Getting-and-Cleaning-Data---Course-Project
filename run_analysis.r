## Tables to make readable the database
dirActivities<-paste(getwd(),"/UCI HAR Dataset/activity_labels.txt",sep="")
dirFeatures<-paste(getwd(),"/UCI HAR Dataset/features.txt",sep="")
Activities<-read.table(dirActivities)
names(Activities)=c("Activity.Code","Activity.Description")
Features<-read.table(dirFeatures)

## tidy test database
dirSub<-paste(getwd(),"/UCI HAR Dataset/test/subject_test.txt",sep="")
dirdb<-paste(getwd(),"/UCI HAR Dataset/test/X_test.txt",sep="")
dirAct<-paste(getwd(),"/UCI HAR Dataset/test/y_test.txt",sep="")
tmpIndex<-data.frame(a=read.table(dirSub),b=read.table(dirAct))
names(tmpIndex)=c("Subject.Code","Activity.Code")
tmpdb<-read.table(dirdb)
names(tmpdb)=Features$V2
tidyTestdb<-cbind(tmpIndex,select(tmpdb,matches("mean"),matches("std")))

## tidy train database
dirSub<-paste(getwd(),"/UCI HAR Dataset/train/subject_train.txt",sep="")
dirdb<-paste(getwd(),"/UCI HAR Dataset/train/X_train.txt",sep="")
dirAct<-paste(getwd(),"/UCI HAR Dataset/train/y_train.txt",sep="")
tmpIndex<-data.frame(a=read.table(dirSub),b=read.table(dirAct))
names(tmpIndex)=c("Subject.Code","Activity.Code")
tmpdb<-read.table(dirdb)
names(tmpdb)=Features$V2
tidyTraindb<-cbind(tmpIndex,select(tmpdb,matches("mean"),matches("std")))

## merge test and train database
tidyTotaldb<-rbind(tidyTestdb,tidyTraindb)

## add description activity name
tidyTotaldb<-merge(tidyTotaldb,Activities,by.x="Activity.Code",by.y="Activity.Code",all=TRUE,sort=FALSE)

## final database
finaldb<-group_by(tidyTotaldb,Activity.Description,Subject.Code)
