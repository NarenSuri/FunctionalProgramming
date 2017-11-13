import os
import sys
from MNISTTester import MNISTTester

####################
# directory settings
script_dir = os.path.dirname(os.path.abspath(__file__))

data_path = script_dir + '/mnist/data/'
model_path = script_dir + '/models/mnist-cnn'

#####################################
# prediction test with MNIST test set

mnist = MNISTTester(model_path=model_path, data_path=data_path)

#mnist.accuracy_of_testset()
#mnist.predict_random()

#################################
# prediction test with image file
# mnist = MNISTTester(model_path)
print sys.argv[1] 
mnist.predict(sys.argv[1])

