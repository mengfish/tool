#!/bin/bash
if [ `whoami` = "root" ];then
        echo "ok!you can install your software now!"
else
 
       echo "sorry,you must use root!"
       exit 0
fi

#cat ~/.perlbrew/init | grep "perl-5.22.0"
perl_version=$(perl --version|grep "version"|awk -F ',' '{print $3}'|awk -F ' ' '{print $3}')
if [ "$perl_version" == "(v5.22.0)" ] 
then
echo 'perl version installed is perl5.22.0' >> install_version.log
else
wget -c --no-check-certificate -O - http://install.perlbrew.pl | bash
source ~/perl5/perlbrew/etc/bashrc
#sed -i '$ a\\source ~/perl5/perlbrew/etc/bashrc' ~/.bashrc
cat ~/.bashrc | grep 'source ~/perl5/perlbrew/etc/bashrc'
if [ $? -eq 0 ]
then
echo 'it has been added.'
else
sed -i '$ a\\source ~/perl5/perlbrew/etc/bashrc' ~/.bashrc
fi

source ~/perl5/perlbrew/etc/bashrc

source ~/.bashrc

perlbrew --notest install -Duseshrplib -Dusethreads perl-5.22.0

perlbrew switch perl-5.22.0

wget -c http://xrl.us/cpanm -O ~/perl5/perlbrew/bin/cpanm

chmod a+x ~/perl5/perlbrew/bin/cpanm

echo 'perl has been installed successfully.' >> install_version.log

fi

~/perl5/perlbrew/bin/cpanm -v Template -f
if [ $? -eq 0 ]
then
echo "Template  install successfully."  >> install_version.log
else
echo "Template  not install successfully." >> install_version.log
exit $?
fi
set timeout 5;

~/perl5/perlbrew/bin/cpanm -v YAML -f

if [ $? -eq 0 ]
then
echo "YAML  install successfully." >> install_version.log
else
echo "YAML  not install successfully." >> install_version.log
exit $?
fi
set timeout 5;


~/perl5/perlbrew/bin/cpanm -v YAML::XS -f
if [ $? -eq 0 ]
then
echo "YAML::XS  install successfully." >> install_version.log
else
echo "YAML::XS  not install successfully." >> install_version.log
exit $?
fi
set timeout 5;

~/perl5/perlbrew/bin/cpanm -v  Date::Calc -f
if [ $? -eq 0 ]
then
echo "Date::Calc  install successfully." >> install_version.log
else
echo "Date::Calc  not install successfully." >> install_version.log
exit $?
fi

~/perl5/perlbrew/bin/cpanm -v Archive::Zip -f
if [ $? -eq 0 ]
then
echo "Archive::Zip  install successfully." >> install_version.log
else
echo "Archive::Zip  not install successfully." >> install_version.log
exit $?
fi

