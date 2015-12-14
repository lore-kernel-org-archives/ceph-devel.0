From: Luis Pabon <lpabon@redhat.com>
Subject: Issues installing on CentOS 7.1
Date: Mon, 14 Dec 2015 17:07:09 -0500 (EST)
Message-ID: <1135941745.28525784.1450130829176.JavaMail.zimbra@redhat.com>
References: <298784230.28525181.1450130580765.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24]:37186 "EHLO
	mx3-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932292AbbLNWHJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 14 Dec 2015 17:07:09 -0500
Received: from zmail17.collab.prod.int.phx2.redhat.com (zmail17.collab.prod.int.phx2.redhat.com [10.5.83.19])
	by mx3-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id tBEM79Pi004952
	for <ceph-devel@vger.kernel.org>; Mon, 14 Dec 2015 17:07:09 -0500
In-Reply-To: <298784230.28525181.1450130580765.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Just wanted to check if it is me or something else is going on.  Is anyone seeing the following when installing on CentOS 7.1? :

---------------------------------------
------------ INFERNALIS ---------------
---------------------------------------

[vagrant@ceph ~]$ sudo yum install http://download.ceph.com/rpm-infernalis/el7/noarch/ceph-release-1-1.el7.noarch.rpm
Loaded plugins: fastestmirror
ceph-release-1-1.el7.noarch.rpm                                                                                                                                        | 3.9 kB  00:00:00
Examining /var/tmp/yum-root-r1Dzps/ceph-release-1-1.el7.noarch.rpm: ceph-release-1-1.el7.noarch
Marking /var/tmp/yum-root-r1Dzps/ceph-release-1-1.el7.noarch.rpm to be installed
Resolving Dependencies 
--> Running transaction check
---> Package ceph-release.noarch 0:1-1.el7 will be installed
--> Finished Dependency Resolution

Dependencies Resolved  

==============================================================================================================================================================================================
 Package                                     Arch                                  Version                                  Repository                                                   Size
==============================================================================================================================================================================================
Installing:
 ceph-release                                noarch                                1-1.el7                                  /ceph-release-1-1.el7.noarch                                550

Transaction Summary
==============================================================================================================================================================================================
Install  1 Package

Total size: 550
Installed size: 550
Is this ok [y/d/N]: y  
Downloading packages:  
Running transaction check
Running transaction test
Transaction test succeeded
Running transaction
  Installing : ceph-release-1-1.el7.noarch                                                                                                                                                1/1
  Verifying  : ceph-release-1-1.el7.noarch                                                                                                                                                1/1

Installed:
  ceph-release.noarch 0:1-1.el7

Complete!


[vagrant@ceph ~]$ sudo yum install ceph-deploy
Loaded plugins: fastestmirror
Ceph                                                                                                                                                                   | 2.9 kB  00:00:00
Ceph-noarch                                                                                                                                                            | 2.9 kB  00:00:00
base                                                                                                                                                                   | 3.6 kB  00:00:00
ceph-source                                                                                                                                                            | 2.9 kB  00:00:00
extras                                                                                                                                                                 | 3.4 kB  00:00:00
updates                                                                                                                                                                | 3.4 kB  00:00:00
(1/7): Ceph-noarch/primary_db                                                                                                                                          | 2.5 kB  00:00:00
(2/7): Ceph/x86_64/primary_db                                                                                                                                          |  25 kB  00:00:00
(3/7): ceph-source/primary_db                                                                                                                                          | 3.7 kB  00:00:00
(4/7): extras/7/x86_64/primary_db                                                                                                                                      |  90 kB  00:00:00
(5/7): base/7/x86_64/group_gz                                                                                                                                          | 155 kB  00:00:00
(6/7): updates/7/x86_64/primary_db                                                                                                                                     | 935 kB  00:00:01
(7/7): base/7/x86_64/primary_db                                                                                                                                        | 5.3 MB  00:00:03
Determining fastest mirrors
 * base: mirror.umd.edu
 * extras: distro.ibiblio.org
 * updates: mirror.5ninesolutions.com
Resolving Dependencies 
--> Running transaction check
---> Package ceph-deploy.noarch 0:1.5.30-0 will be installed
--> Finished Dependency Resolution

Dependencies Resolved  

==============================================================================================================================================================================================
 Package                                        Arch                                      Version                                        Repository                                      Size
==============================================================================================================================================================================================
Installing:
 ceph-deploy                                    noarch                                    1.5.30-0                                       Ceph-noarch                                    268 k

Transaction Summary
==============================================================================================================================================================================================
Install  1 Package

Total download size: 268 k
Installed size: 1.1 M
Is this ok [y/d/N]: y
Downloading packages:
ceph-deploy-1.5.30-0.noarch.rp FAILED
http://download.ceph.com/rpm-infernalis/el7/noarch/ceph-deploy-1.5.30-0.noarch.rpm: [Errno -1] Package does not match intended download. Suggestion: run yum --enablerepo=Ceph-noarch clean metadata
Trying other mirror.


Error downloading packages:
  ceph-deploy-1.5.30-0.noarch: [Errno 256] No more mirrors to try.

---------------------------------------
------------ HAMMER -------------------
---------------------------------------
[vagrant@ceph ~]$ sudo yum install http://download.ceph.com/rpm-hammer/rhel7/noarch/ceph-release-1-1.el7.noarch.rpm
Loaded plugins: fastestmirror
ceph-release-1-1.el7.noarch.rpm                                                                                                                                        | 4.0 kB  00:00:00
Examining /var/tmp/yum-root-r1Dzps/ceph-release-1-1.el7.noarch.rpm: ceph-release-1-1.el7.noarch
Marking /var/tmp/yum-root-r1Dzps/ceph-release-1-1.el7.noarch.rpm to be installed
Resolving Dependencies 
--> Running transaction check
---> Package ceph-release.noarch 0:1-1.el7 will be installed
--> Finished Dependency Resolution

Dependencies Resolved  

==============================================================================================================================================================================================
 Package                                     Arch                                  Version                                  Repository                                                   Size
==============================================================================================================================================================================================
Installing:
 ceph-release                                noarch                                1-1.el7                                  /ceph-release-1-1.el7.noarch                                583

Transaction Summary
==============================================================================================================================================================================================
Install  1 Package

Total size: 583  
Installed size: 583  
Is this ok [y/d/N]: y
Downloading packages:
Running transaction check
Running transaction test
Transaction test succeeded
Running transaction
  Installing : ceph-release-1-1.el7.noarch                                                                                                                                                1/1 
  Verifying  : ceph-release-1-1.el7.noarch                                                                                                                                                1/1 

Installed:
  ceph-release.noarch 0:1-1.el7                                                                                                                                                               

Complete!

[vagrant@ceph ~]$ sudo yum install ceph-deploy
Loaded plugins: fastestmirror
Loading mirror speeds from cached hostfile
 * base: mirror.umd.edu
 * extras: distro.ibiblio.org
 * updates: mirror.5ninesolutions.com
Resolving Dependencies
--> Running transaction check
---> Package ceph-deploy.noarch 0:1.5.30-0 will be installed
--> Finished Dependency Resolution

Dependencies Resolved

==============================================================================================================================================================================================
 Package                                        Arch                                      Version                                        Repository                                      Size
==============================================================================================================================================================================================
Installing:
 ceph-deploy                                    noarch                                    1.5.30-0                                       Ceph-noarch                                    268 k

Transaction Summary
==============================================================================================================================================================================================
Install  1 Package

Total download size: 268 k
Installed size: 1.1 M
Is this ok [y/d/N]: y
Downloading packages:
Delta RPMs disabled because /usr/bin/applydeltarpm not installed.
ceph-deploy-1.5.30-0.noarch.rp FAILED                                          
http://ceph.com/rpm-hammer/rhel7/noarch/ceph-deploy-1.5.30-0.noarch.rpm: [Errno 14] HTTP Error 404 - Not Found                                              ]  0.0 B/s |    0 B  --:--:-- ETA 
Trying other mirror.


Error downloading packages:
  ceph-deploy-1.5.30-0.noarch: [Errno 256] No more mirrors to try.
