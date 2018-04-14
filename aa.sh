#! /bin/bash
install_env(){
	sudo pip install virtualenv
	sudo pip install virtualenvwrapper
	mkdir ~/.virtualenvs
	echo export WORKON_HOME=$HOME/.virtualenvs >> ~/.bashrc
	echo source /usr/local/bin/virtualenvwrapper.sh >> ~/.bashrc
	source ~/.bashrc
}
main(){
        prepare_file
        if [[ $parm_num == 0 ]]
        then
        echo "参数错误 使用方式:/bin/bash $0 virtualenv"
        exit
        elif [[ "${arrary[@]}" =~ "virtualenv" ]]
        then
	install_env
        else
        echo "参数错误 使用方式:/bin/bash $0 nginx|redis"
        fi
}
main

