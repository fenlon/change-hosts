#!/bin/bash
#crontab schedule get new hosts from github

cd $(dirname $0)
home=`pwd`
#projectGitUrl='git@github.com:racaljk/hosts.git'
projectGitUrl='git@git.coding.net:scaffrey/hosts.git'
hosts_tmp=$home/hosts_tmp

function checkTmp(){

    echo "start tmp"
    if [ -e $hosts_tmp ]; then
        rm -f $hosts_tmp
    fi
    echo "end tmp"

}

# copy my hosts to tmp
function getMyHosts()
{
    echo "start own hosts"
    hosts_own=$home/hosts.own
    if [ -e $hosts_own ];then
        cat $hosts_own >> $hosts_tmp
    fi
    echo "end own hosts"
}

function refreshFromGithub()
{

    echo "start github hosts"
    project=$home/hosts

    if [ ! -d $project ] || [ `ls hosts|wc -l` -eq 0 ]; then
        #git clone $projectGitUrl
        git submodule init
        git submodule update        
        git pull origin master
    else
        cd $project
        git pull origin master
        cd $home
    fi

    echo >> $hosts_tmp
    echo "# NEXT IS FROM GITHUB" >> $hosts_tmp
    echo >> $hosts_tmp
    cat $project/hosts >> $hosts_tmp
    echo "end github hosts"
}

function moveToEtc()
{
    target="/etc/hosts"
    mv $hosts_tmp $target
}


function main()
{
    echo
    echo `date '+%Y-%m-%d %H:%M:%S'`
    checkTmp
    getMyHosts
    refreshFromGithub
    moveToEtc
    echo "===============end====================="
    echo
}

main
