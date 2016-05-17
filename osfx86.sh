#!/bin/bash
#
# Compiz Head-tracking install script
# Written by osfx86@gmail.com 11-24-2012
#


version_lucid=`cat /etc/issue | grep "10.04" &>/dev/null ; echo $?`
version_maverick=`cat /etc/issue | grep "10.10" &>/dev/null ; echo $?`
version_natty=`cat /etc/issue | grep "11.04" &>/dev/null ; echo $?`

export PATH=$PATH:$PWD
export $version_lucid
export $version_maverick
export $version_natty

echo $version_lucid
echo $version_maverick
echo $version_natty

explugins=( anaglyph atlantis cubemodel dialog elements extra-animations\
 fakeargb fireflies freewins ghost mswitch photowheel putplus screensaver\
 simple-animations smartput snow snowglobe stackswitch stars static swap\
 throw tile toggle-decoration wizard workspacenames )

gits=( git://anongit.compiz.org/users/wodor/anaglyph \
git://anongit.compiz.org/compiz/plugins/atlantis \
git://anongit.compiz.org/compiz/plugins/cubemodel \
git://anongit.compiz.org/users/rcxdude/dialog \
git://anongit.compiz.org/users/pat/elements \
git://anongit.compiz.org/users/kdubois/extra-animations \
git://anongit.compiz.org/compiz/plugins/fakeargb \
git://anongit.compiz.org/inactive/users/smspillaz/fireflies \
git://anongit.compiz.org/users/warlock/freewins \
git://anongit.compiz.org/users/rcxdude/ghost \
git://anongit.compiz.org/compiz/plugins/mswitch \
git://anongit.compiz.org/users/b0le/photowheel \
git://anongit.compiz.org/users/edgurgel/putplus \
git://anongit.compiz.org/users/pafy/screensaver \
git://anongit.compiz.org/users/smspillaz/simple-animations \
git://anongit.compiz.org/users/edgurgel/smartput \
git://anongit.compiz.org/fusion/plugins/snow \
git://anongit.compiz.org/users/metastability/snowglobe \
git://anongit.compiz.org/compiz/plugins/stackswitch \
git://anongit.compiz.org/inactive/users/smspillaz/stars \
git://anongit.compiz.org/users/smspillaz/static \
git://anongit.compiz.org/users/edgurgel/swap \
git://anongit.compiz.org/users/smspillaz/throw \
git://anongit.compiz.org/compiz/plugins/tile \
git://anongit.compiz.org/users/edgurgel/toggle-decoration \
git://anongit.compiz.org/users/soreau/wizard \
git://anongit.compiz.org/users/maniac/workspacenames )

ldeps="compiz-fusion-bcop build-essential \
cmake subversion libgtk2.0-dev pkg-config libpng12-0 libpng12-dev \
libjpeg62 libjpeg62-dev zlib1g zlib1g-dev libtiff4 libtiff4-dev libjasper1 \
libdc1394-22 libcv4 libcvaux4 libcvaux-dev libcv-dev libhighgui4 \
libhighgui-dev opencv-doc python-opencv compiz compiz-fusion-plugins-extra \
compiz-fusion-plugins-main compiz-fusion-bcop compizconfig-settings-manager \
fusion-icon compiz-dev libcompizconfig0-dev python-compizconfig libdecoration0-dev \
libtool x11proto-scrnsaver-dev libglu1-mesa-dev libxss-dev x11proto-scrnsaver-dev \
libxss-dev libcairo2-dev libdecoration0-dev libpango1.0-dev git-core libavcodec-dev libavformat-dev \
cmake libswscale-dev libjasper-dev"

mdeps="compiz-fusion-bcop build-essential \
cmake subversion libgtk2.0-dev pkg-config libpng12-0 libpng12-dev \
libjpeg62 libjpeg62-dev zlib1g zlib1g-dev libtiff4 libtiff4-dev libjasper1 \
libdc1394-22 libcv2.1 libcvaux2.1 libcvaux-dev libcv-dev libhighgui2.1 \
libhighgui-dev opencv-doc python-opencv compiz compiz-fusion-plugins-extra \
compiz-fusion-plugins-main compiz-fusion-bcop compizconfig-settings-manager \
fusion-icon compiz-dev libcompizconfig0-dev python-compizconfig libdecoration0-dev \
libtool x11proto-scrnsaver-dev libglu1-mesa-dev libxss-dev x11proto-scrnsaver-dev \
libxss-dev libcairo2-dev libdecoration0-dev libpango1.0-dev git-core libavcodec-dev libavformat-dev \
cmake libswscale-dev libjasper-dev" 

ndeps="compiz-fusion-bcop build-essential \
cmake subversion libgtk2.0-dev pkg-config libpng12-0 libpng12-dev \
libjpeg62 libjpeg62-dev zlib1g zlib1g-dev libtiff4 libtiff4-dev libjasper1 \
libdc1394-22 libcv2.1 libcvaux2.1 libcvaux-dev libcv-dev libhighgui2.1 \
libhighgui-dev opencv-doc python-opencv compiz compiz-fusion-plugins-extra \
compiz-fusion-plugins-main compiz-fusion-bcop compizconfig-settings-manager \
fusion-icon compiz-dev libcompizconfig0-dev python-compizconfig libdecoration0-dev \
libtool x11proto-scrnsaver-dev libglu1-mesa-dev libxss-dev x11proto-scrnsaver-dev \
libxss-dev libcairo2-dev libdecoration0-dev libpango1.0-dev git-core libavcodec-dev libavformat-dev \
cmake libswscale-dev libjasper-dev libopenexr-dev python-dev python-numpy libtbb-dev libeigen2-dev \
yasm libfaac-dev libopencore-amrnb-dev libopencore-amrwb-dev libtheora-dev libvorbis-dev libxvidcore-dev"

logo() {
echo "   ____   _____ ________   _____    __  
  / __ \ / ____|  ____\ \ / / _ \  / /  
 | |  | | (___ | |__   \ V / (_) |/ /_  
 | |  | |\___ \|  __|   > < > _ <| '_ \ 
 | |__| |____) | |     / . \ (_) | (_) |
  \____/|_____/|_|    /_/ \_\___/ \___/ 
                                      "
}

comp_ffmpeg() {
	#Compile FFmpeg
	clear
	echo "This Will Take A While..."
	wget http://ffmpeg.org/releases/ffmpeg-0.7-rc1.tar.gz
	tar -xvzf ffmpeg-0.7-rc1.tar.gz
	cd ffmpeg-0.7-rc1
	./configure --enable-gpl --enable-version3 --enable-nonfree \
	--enable-postproc --enable-libfaac --enable-libopencore-amrnb --enable-libopencore-amrwb \
	--enable-libtheora --enable-libvorbis --enable-libxvid --enable-x11grab --enable-swscale --enable-shared
	make
	sudo make install
	cd -
	clear
	return 0
}

down_comp() {
	#Downgrade Compiz
	sudo apt-get -y purge compiz compiz-plugins-extra compiz-plugins-main
	sudo apt-get -y purge compizconfig-settings-manager
	sudo apt-get -y purge libemeraldengine0 emerald
	sudo add-apt-repository ppa:guido-iodice/compiz-0.8.6-natty
	sudo apt-get update
	sudo apt-get -y install compiz compiz-core compiz-fusion-plugins-main compiz-fusion-plugins-extra \
	compiz-fusion-plugins-unsupported compiz-gnome compiz-plugins compizconfig-backend-gconf \
	compizconfig-settings-manager libcompizconfig0 libdecoration0 python-compizconfig
	clear
	return 0
}

deps_lucid() {
	# Install dependencies from repo for 10.04
	echo "Script For Compiling Compiz Headtracking + Experimental Plugins On 10.04/10.10/11.04"
	sleep 1
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	echo "Retrieving Dependencies"
	logo
	sleep 6
	clear
	echo "Installing dependencies..."
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	sleep 1
	sudo apt-get -y install $ldeps
	clear
	return 0
}

deps_maverick() {
	# Install dependencies from repo for 10.10
	echo "Script For Compiling Compiz Headtracking + Experimental Plugins On 10.04/10.10/11.04"
	sleep 1
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	echo "Retrieving Dependencies"
	logo
	sleep 6
	clear
	echo "Installing dependencies..."
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	sleep 1
	sudo apt-get -y install $mdeps 
	clear
	return 0
}

deps_natty() {
	# Install dependencies from repo for 11.04
	echo "Script For Compiling Compiz Headtracking + Experimental Plugins On 10.04/10.10/11.04"
	echo "THIS WILL REMOVE UNITY"
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	sleep 1
	echo "Retrieving Dependencies & Downgrading Compiz To A Compatable Version"
	logo
	sleep 11
	clear
	echo "Downgrading Compiz From 0.9.x To 0.8.6"
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	sleep 2
	down_comp
	clear
	echo "Installing dependencies..."
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	sleep 2
	sudo apt-get -y install $ndeps
	clear
	echo "Downloading, Compiling & Installing FFmpeg"
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	sleep 2
	comp_ffmpeg
	clear
	return 0
}

build_opencvold() {
	clear
	echo "Downloading, Building & Installing OpenCV 2.2{Required By Headtracking Plugin}"
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	sleep 6
	wget http://sourceforge.net/projects/opencvlibrary/files/opencv-unix/2.2/OpenCV-2.2.0.tar.bz2
	tar xfv OpenCV-2.2.0.tar.bz2
	rm OpenCV-2.2.0.tar.bz2
	cd OpenCV-2.2.0
	mkdir opencv.build
	cd opencv.build
	cmake ..
	make
	sudo make install
	sudo echo "/usr/local/lib" >> /etc/ld.so.conf.d/opencv.conf
	sudo ldconfig
	sudo echo "PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/lib/pkgconfig
export PKG_CONFIG_PATH" >> /etc/bash.bashrc
	cd ../..
	sudo rm -rf OpenCV-2.2.0 &> /dev/null
	return $?
}

build_opencvnew() {
	clear
	echo "Downloading, Building & Installing OpenCV 2.2{Required By Headtracking Plugin}"
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	sleep 6
	wget http://sourceforge.net/projects/opencvlibrary/files/opencv-unix/2.2/OpenCV-2.2.0.tar.bz2
	tar xfv OpenCV-2.2.0.tar.bz2
	rm OpenCV-2.2.0.tar.bz2
	cd OpenCV-2.2.0
	cmake -D WITH_TBB=ON -D BUILD_NEW_PYTHON_SUPPORT=ON -D WITH_V4L=OFF -D INSTALL_C_EXAMPLES=ON -D INSTALL_PYTHON_EXAMPLES=ON -D \ BUILD_EXAMPLES=ON .
	make
	sudo make install
	sudo echo "/usr/local/lib" >> /etc/ld.so.conf.d/opencv.conf
	sudo ldconfig
	sudo echo "PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/lib/pkgconfig
export PKG_CONFIG_PATH" >> /etc/bash.bashrc
	cd -
	sudo rm -rf OpenCV-2.2.0
	return $?
}

install_icons() {
	clear
	echo "Installing Icons"
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	sleep 2
	wget http://sites.google.com/site/oreaus/icons-experimental.tar.gz
	sudo tar -xvf icons-experimental.tar.gz -C /usr/share/ccsm/icons/hicolor/scalable/apps/ && \
	rm -rf icons-experimental.tar.gz  && cd /usr/share/ccsm/icons/hicolor/scalable/apps/icons-experimental/ && \
	sudo cp * ../ && cd .. && rm -rf icons-experimental
	clear
	install_success
	return $?
}

install_success() {
	clear
	echo "If Your Running 11.04 You MUST Login Using Gnome Classic..."
	echo "Restart CCSM And Your New Plugins Should Be There, Have Fun :-)"
	sleep 2
	return 0
}

install_failed() {
	echo "Headtracking for compiz was not downloaded, compiled or installed."
	echo
	echo "Aborting!"
	exit 1
}

install_plugins() {
	clear
	echo -e "Downloading,Building & Installing HeadTracking Plugin"
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	git clone git://anongit.compiz.org/users/klange/headtracking
	cd headtracking
	make && \
	make install
	cd -
	rm -rf headtracking > /dev/null 2>&1
	sleep 2	
	clear
	echo "Downloading, Building & Installing Experimental Plugins .. "
	echo "This Will Take A Few Minutes"
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	sleep 6
		for i in "${gits[@]}"
		do
		git clone $i
		cd `ls -ltr | awk '{print $NF}' | awk 'END{print}'`
		git checkout -q compiz-0.8
		make clean
		make
		make install
		cd -
	done
	for i in "${explugins[@]}"
		do
		sudo rm -rf $i
	done
	return 0
}

if [ $version_lucid == 0 ]
	then
	clear
	deps_lucid
elif [ $version_maverick == 0 ]
	then
	clear
	deps_maverick
elif [ $version_natty == 0 ]
	then
	clear
	deps_natty
	else
	install_failed
fi

if [ $version_lucid == 0 ]
	then
	clear
	build_opencvold
elif [ $version_maverick == 0 ]
	then
	clear
	build_opencvold
elif [ $version_natty == 0 ]
	then
	clear
	build_opencvnew
else
	install_failed
fi

if [ $? !-eq 0 ]
	then
	install_failed
	else
	install_plugins
fi

if [ $? !-eq 0 ]
	then
	install_failed
	else
	install_icons
fi

if [ $? !-eq 0 ]
	then
	install_failed
	else
	install_success
fi

exit 0
