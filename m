From: Jun He <jhe@cs.wisc.edu>
Subject: error msg: 'Error in sys.exitfunc'
Date: Wed, 12 Nov 2014 15:07:29 -0600
Message-ID: <CABW1wHSUEThDhCCr0bpFrEtHmT+to0V=ERVVEpei0XF2Zrfepg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f52.google.com ([209.85.218.52]:56530 "EHLO
	mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753309AbaKLVIL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Nov 2014 16:08:11 -0500
Received: by mail-oi0-f52.google.com with SMTP id u20so9125932oif.25
        for <ceph-devel@vger.kernel.org>; Wed, 12 Nov 2014 13:08:10 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,
When I was deploying Ceph using ceph-deploy
(http://docs.ceph.com/docs/master/start/), I encountered an "error":

jhe@node0.lustre3:/tmp/my-cluster$ ceph-deploy new node1
[ceph_deploy.conf][DEBUG ] found configuration file at:
/users/jhe/.cephdeploy.conf
[ceph_deploy.cli][INFO  ] Invoked (1.5.19): /usr/bin/ceph-deploy new node1
[ceph_deploy.new][DEBUG ] Creating new cluster named ceph
[ceph_deploy.new][INFO  ] making sure passwordless SSH succeeds
[node1][DEBUG ] connected to host:
node0.lustre3.scalablefs.susitna.pdl.cmu.local
[node1][INFO  ] Running command: ssh -CT -o BatchMode=yes node1
Warning: Permanently added 'node1,10.51.1.19' (RSA) to the list of known hosts.
[node1][DEBUG ] connection detected need for sudo
Warning: Permanently added 'node1,10.51.1.19' (RSA) to the list of known hosts.
[node1][DEBUG ] connected to host: node1
[node1][DEBUG ] detect platform information from remote host
[node1][DEBUG ] detect machine type
[node1][DEBUG ] find the location of an executable
[node1][INFO  ] Running command: sudo /sbin/ip link show
[node1][INFO  ] Running command: sudo /sbin/ip addr show
[node1][DEBUG ] IP addresses found: ['10.52.1.19', '10.54.1.19', '10.51.1.19']
[ceph_deploy.new][DEBUG ] Resolving host node1
[ceph_deploy.new][DEBUG ] Monitor node1 at 10.51.1.19
[ceph_deploy.new][DEBUG ] Monitor initial members are ['node1']
[ceph_deploy.new][DEBUG ] Monitor addrs are ['10.51.1.19']
[ceph_deploy.new][DEBUG ] Creating a random mon key...
[ceph_deploy.new][DEBUG ] Writing monitor keyring to ceph.mon.keyring...
[ceph_deploy.new][DEBUG ] Writing initial config to ceph.conf...
Error in sys.exitfunc:

*****************************
Another example:

jhe@node0.lustre3:/tmp/my-cluster$ ceph-deploy jkjsnxnh3
usage: ceph-deploy [-h] [-v | -q] [--version] [--username USERNAME]
                   [--overwrite-conf] [--cluster NAME] [--ceph-conf CEPH_CONF]
                   COMMAND ...
ceph-deploy: error: argument COMMAND: invalid choice: 'jkjsnxnh3'
(choose from 'purgedata', 'pkg', 'mds', 'forgetkeys', 'calamari',
'purge', 'admin', 'mon', 'install', 'gatherkeys', 'new', 'disk',
'config', 'osd', 'uninstall')
Error in sys.exitfunc:

*****************************
I looked at the code and find this might suppress the weird behavior.
In the following case, 'Error in sys.exitfunc:' disappears.

jhe@node0.lustre3:/tmp/my-cluster$ env CEPH_DEPLOY_TEST=YES ceph-deploy jjjjj
usage: ceph-deploy [-h] [-v | -q] [--version] [--username USERNAME]
                   [--overwrite-conf] [--cluster NAME] [--ceph-conf CEPH_CONF]
                   COMMAND ...
ceph-deploy: error: argument COMMAND: invalid choice: 'jjjjj' (choose
from 'purgedata', 'pkg', 'mds', 'forgetkeys', 'calamari', 'purge',
'admin', 'mon', 'install', 'gatherkeys', 'new', 'disk', 'config',
'osd', 'uninstall')
jhe@node0.lustre3:/tmp/my-cluster$

*****************************
This is the info of my machine:

jhe@node0.lustre3:/tmp/my-cluster$ python -V
Python 2.6.6
jhe@node0.lustre3:/tmp/my-cluster$ cat /etc/centos-release
CentOS release 6.6 (Final)
jhe@node0.lustre3:/tmp/my-cluster$ uname -ra
Linux node0.lustre3.scalablefs.susitna.pdl.cmu.local
2.6.32-504.1.3.el6.x86_64 #1 SMP Tue Nov 11 17:57:25 UTC 2014 x86_64
x86_64 x86_64 GNU/Linux

ceph-deploy v1.5.19

Hope this reveals some interesting issues other than my inexperience with Ceph.

Bests,
Jun
