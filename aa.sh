#! /bin/bash
install_env(){
	sudo apt-get install python-pip
	sudo pip install virtualenv
	sudo pip install virtualenvwrapper
	pip install --upgrade pip
	mkdir ~/.virtualenvs
	echo export WORKON_HOME=$HOME/.virtualenvs >> ~/.bashrc
	echo source /usr/local/bin/virtualenvwrapper.sh >> ~/.bashrc
	source ~/.bashrc
}
parm_num=$#
echo $parm_num
array=$*
main(){
        if [[ $parm_num == 0 ]]
        then
        echo "参数错误 使用方式:/bin/bash $0 virtualenv"
        exit
        elif [[ "${array[@]}" =~ "virtualenv" ]]
        then
	install_env
        else
        echo "参数错误 使用方式:/bin/bash $0 virtualenv"
        fi
}
#main
for i in ${array[@]}
do
	echo $i
done

