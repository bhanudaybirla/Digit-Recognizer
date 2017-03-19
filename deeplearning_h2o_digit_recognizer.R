library("h2o")
localH2O = h2o.init(max_mem_size = '6g',nthreads = -1)
train <- read.csv("C:\\Users\\admin\\Downloads\\train.csv")
train[,1] = as.factor(train[,1]) # convert digit labels to factor for classification
train_h2o = as.h2o(train)

time=c()
acc=c()

  ## set timer
  s <- proc.time()
  
  ## train model
  model =
    h2o.deeplearning(x = 2:785,  # column numbers for predictors
                     y = 1,   # column number for label
                     training_frame = train_h2o, # data in H2O format
                     activation = "RectifierWithDropout", # algorithm
                     input_dropout_ratio = 0.2, # % of inputs dropout
                     hidden_dropout_ratios = c(0.5,0.5), # % for nodes dropout
                     balance_classes = TRUE, 
                     hidden = c(500,500),# two layers of 500 nodes
                     momentum_stable = 0.99,
                     nesterov_accelerated_gradient = T, # use it for speed
                     epochs = 20) # no. of epochs
  ## print confusion matrix
  x=h2o.confusionMatrix(model)
  print(i)
  print(x)
  time[length(time)+1]=as.numeric(proc.time()[3]-s[3])
  print(time[length(time)])
  acc[length(acc)+1]=1-x$Error[dim(x)[1]]
  print(acc[length(acc)])
  test=as.h2o(read.csv("C:\\Users\\admin\\Downloads\\test.csv"))
  finalcsv<-as.data.frame(predict(model,test))
  finalcsv1=cbind(ImageId=1:28000,Label=as.vector(finalcsv[,1]))
  write.csv(finalcsv1, file = "Predicted1.csv",row.names=FALSE)
