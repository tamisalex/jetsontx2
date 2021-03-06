#install tensorflow & object_detection 
pwd=$(pwd)
sudo apt install -f install
sudo apt update
sudo apt install -y python-dev python-setuptools
sudo easy_install pip
#sudo pip install tensorflow-1.9.0rc0-cp27-cp27mu-linux_aarch64.whl
sudo pip install --extra-index-url=https://developer.download.nvidia.com/compute/redist/jp33 tensorflow-gpu
mkdir libs
cd libs
git clone https://github.com/tensorflow/models
cd ..
sudo apt install -y protobuf-compiler python-pil python-lxml python-tk
pip install --user Cython
pip install --user contextlib2
sudo pip install --user pyzmq==17.0.0
pip install --user jupyter
sudo apt install -y libfreetype6-dev 
sudo apt install -y pkg-config
pip install --user matplotlib
cd libs
git clone https://github.com/cocodataset/cocoapi.git
cd cocoapi/PythonAPI
make
cp -r pycocotools ${pwd}/libs/models/research/
cd ${pwd}/libs/models/research
wget -O protobuf.zip https://github.com/protocolbuffers/protobuf/releases/download/v3.6.1/protoc-3.6.1-linux-aarch_64.zip
unzip protobuf.zip
./bin/protoc object_detection/protos/*.proto --python_out=.
echo 'export PYTHONPATH=/home/nvidia/catkin_ws/src/models/research${PYTHONPATH:+${PYTHONPATH}}'
echo 'export PYTHONPATH=/home/nvidia/caktin_ws/src/models/research/slim${PYTHONPATH:+${PYTHONPATH}}'
# check installation of tensorflow
# install ROS
cd ${pwd}/libs
git clone https://github.com/jetsonhacks/installROSTX2
./installROSTX2/installROS.sh
./installROSTX2/setupCatkinWorkspace.sh
sudo apt install -y ros-kinetic-image-transport
sudo apt install -y ros-kinetic-cv-bridge
sudo apt install -y ros-kinetic-image-geometry
#install ptgrey camera drivers
sudo apt-get install -y libraw1394-11 libavcodec-ffmpeg56 \
        libavformat-ffmpeg56 libswscale-ffmpeg3 libswresample-ffmpeg1 \
        libavutil-ffmpeg54 libgtkmm-2.4-dev libglademm-2.4-dev \
        libgtkglextmm-x11-1.2-dev libusb-1.0-0
echo 'debug'
echo ${pwd}
sudo tar xvf ${pwd}/flycapture.2.13.3.31_arm64_xenial.tar.gz -C ${pwd}/libs
stat ${pwd}/libs/flycapture.2.13.3.31_arm64/flycap2-conf
sudo ${pwd}/libs/flycapture.2.13.3.31_arm64/flycap2-conf
sudo apt install -y ros-kinetic-pointgrey-camera-driver
cd ~
sudo sh ~/jetson_clocks.sh
sudo sysctl -w net.core.rmem_max=33554432 net.core.rmem_default=33554432
sudo sysctl -w net.core.wmem_max=33554432 net.core.wmem_default=33554432
