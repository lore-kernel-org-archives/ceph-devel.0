From: Isaac Otsiabah <zmoo76b@yahoo.com>
Subject: ceph-deploy errors on CentOS
Date: Tue, 21 May 2013 13:21:14 -0700 (PDT)
Message-ID: <1369167674.88429.YahooMailNeo@web121904.mail.ne1.yahoo.com>
References: <1359048283.79398.YahooMailNeo@web121906.mail.ne1.yahoo.com>
	<4428CF82A82E485B81CB865DFBE92465@inktank.com>
	<1359136273.17901.YahooMailNeo@web121903.mail.ne1.yahoo.com>
	<1359404261.7789.YahooMailNeo@web121901.mail.ne1.yahoo.com> <CAPYLRzjbs4FB54uTv+rmt8Rsc7wHTfKPhrpEEKd0tKU92jR2FA@mail.gmail.com>
Reply-To: Isaac Otsiabah <zmoo76b@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from nm30-vm1.bullet.mail.ne1.yahoo.com ([98.138.90.46]:24642 "EHLO
	nm30-vm1.bullet.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751762Ab3EUU0i convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 21 May 2013 16:26:38 -0400
In-Reply-To: <CAPYLRzjbs4FB54uTv+rmt8Rsc7wHTfKPhrpEEKd0tKU92jR2FA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>



Hello everyone, i am testing ceph-deploy on Centos 6.3 i am getting err=
ors. i have a simple one node setup as follows:

OS: CentOS 6.3
kernel 3.5=A0 and also kernel 2.6.32-279.el6.x86_64
Journal partition size=3D2GB
/dev/sdb label=3Dgpt
selinux=3DOFF
iptables=3DOFF
NUMBER OF OSD=3D2


Test 1:
ceph-deploy new gclient158
ceph-deploy mon create gclient158
ceph-deploy disk zap gclient158:/dev/sdc
ceph-deploy disk zap gclient158:/dev/sdd

ceph-deploy gatherkeys gclient158

ceph-deploy mds create gclient158

ceph-deploy osd prepare gclient158:sdc:/dev/sdb1

ceph-deploy osd prepare gclient158:sdd:/dev/sdb2

ceph-deploy osd activate gclient158:/dev/sdc:/dev/sdb1

ceph-deploy osd activate gclient158:/dev/sdd:/dev/sdb2


The result of the above ceph-deploy commands are shown below. The 2 osd=
 are running but "ceph health" command nnnever show HEALTK_OK. It stays=
 in HEALTH_WARN forever and is degraded. By the way /var/log/ceph/ceph-=
osd.0.log and /var/log/ceph/ceph-osd.1.log contain no real errors.This =
behavior is the same for kernel 3.5 and 2.6.32-279.el6.x86_64. What am =
i missing?


[root@gclient158 ~]# ps -elf|grep ceph
5 S root=A0=A0=A0=A0=A0 3124=A0=A0=A0=A0 1=A0 0=A0 80=A0=A0 0 - 40727 f=
utex_ 10:49 ?=A0=A0=A0=A0=A0=A0=A0 00:00:00 /usr/bin/ceph-mon -i gclien=
t158 --pid-file /var/run/ceph/mon.gclient158.pid -c /etc/ceph/ceph.conf
5 S root=A0=A0=A0=A0=A0 3472=A0=A0=A0=A0 1=A0 0=A0 80=A0=A0 0 - 41194 f=
utex_ 10:49 ?=A0=A0=A0=A0=A0=A0=A0 00:00:00 /usr/bin/ceph-mds -i gclien=
t158 --pid-file /var/run/ceph/mds.gclient158.pid -c /etc/ceph/ceph.conf
5 S root=A0=A0=A0=A0=A0 4035=A0=A0=A0=A0 1=A0 1=A0 78=A0 -2 - 115119 fu=
tex_ 10:50 ?=A0=A0=A0=A0=A0=A0 00:00:00 /usr/bin/ceph-osd -i 0 --pid-fi=
le /var/run/ceph/osd.0.pid -c /etc/ceph/ceph.conf
5 S root=A0=A0=A0=A0=A0 4769=A0=A0=A0=A0 1=A0 0=A0 78=A0 -2 - 112304 fu=
tex_ 10:50 ?=A0=A0=A0=A0=A0=A0 00:00:00 /usr/bin/ceph-osd -i 1 --pid-fi=
le /var/run/ceph/osd.1.pid -c /etc/ceph/ceph.conf
0 S root=A0=A0=A0=A0=A0 5025=A0 2710=A0 0=A0 80=A0=A0 0 - 25811 pipe_w =
10:50 pts/0=A0=A0=A0 00:00:00 grep ceph

[root@gclient158 ~]# ceph osd tree

# id=A0=A0=A0 weight=A0 type name=A0=A0=A0=A0=A0=A0 up/down reweight
-1=A0=A0=A0=A0=A0 0.14=A0=A0=A0 root default
-2=A0=A0=A0=A0=A0 0.14=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 host gclient158
0=A0=A0=A0=A0=A0=A0 0.06999=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 osd.0=A0=A0 up=A0=A0=A0=A0=A0 1
1=A0=A0=A0=A0=A0=A0 0.06999=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 osd.1=A0=A0 up=A0=A0=A0=A0=A0 1

[root@gclient158 ~]# ceph health
HEALTH_WARN 91 pgs degraded; 192 pgs stuck unclean; recovery 9/42 degra=
ded (21.429%);=A0 recovering 2 o/s, 1492B/s
[root@gclient158 ~]# ceph health
HEALTH_WARN 91 pgs degraded; 192 pgs stuck unclean; recovery 9/42 degra=
ded (21.429%);=A0 recovering 2 o/s, 1492B/s
[root@gclient158 ~]# ceph health
HEALTH_WARN 91 pgs degraded; 192 pgs stuck unclean; recovery 9/42 degra=
ded (21.429%);=A0 recovering 2 o/s, 1492B/s


By the way /var/log/ceph/ceph-osd.0.log and /var/log/ceph/ceph-osd.1.lo=
g contain no real errors but one thing that happens after osd prepare a=
nd activate commands is the error below:

Traceback (most recent call last):
=A0 File "/usr/sbin/ceph-deploy", line 8, in <module>
=A0=A0=A0 load_entry_point('ceph-deploy=3D=3D0.1', 'console_scripts', '=
ceph-deploy')()
=A0 File "/root/ceph-deploy/ceph_deploy/cli.py", line 112, in main
=A0=A0=A0 return args.func(args)
=A0 File "/root/ceph-deploy/ceph_deploy/osd.py", line 426, in osd
=A0=A0=A0 prepare(args, cfg, activate_prepared_disk=3DFalse)
=A0 File "/root/ceph-deploy/ceph_deploy/osd.py", line 273, in prepare
=A0=A0=A0 s =3D '{} returned {}\n{}\n{}'.format(cmd, ret, out, err)
ValueError: zero length field name in format

The above error probably has to with the journal device. I had the same=
 error when the journal device label=3Dgpt and also with journal device=
 label=3Dmsdos. Please, what am i missing here and why does the cluster=
 never reaches HEALTH_OK?





TEST 2:=A0 the setup for this test is same as above except i used same =
disk for both ceph data and journal as follows:

ceph-deploy osd prepare gclient158:/dev/sdc
ceph-deploy osd prepare gclient158:/dev/sdd
ceph-deploy osd activate gclient158:/dev/sdc
ceph-deploy osd activate gclient158:/dev/sdd


=46or test 2, i do not get the error in test 1 but osd's fail to start =
and both osd log files contain this error:

2013-05-21 11:54:24.806747 7f26cfa26780 -1 journal check: ondisk fsid 0=
0000000-0000-0000-0000-000000000000 doesn't match expected 942af534-ccc=
0-4843-8598-79420592317a, invalid (someone else's?) journal
2013-05-21 11:54:24.806784 7f26cfa26780 -1 filestore(/var/lib/ceph/tmp/=
mnt.3YsEmH) mkjournal error creating journal on /var/lib/ceph/tmp/mnt.3=
YsEmH/journal: (22) Invalid argument
2013-05-21 11:54:24.806802 7f26cfa26780 -1 OSD::mkfs: FileStore::mkfs f=
ailed with error -22
2013-05-21 11:54:24.806838 7f26cfa26780 -1 ^[[0;31m ** ERROR: error cre=
ating empty object store in /var/lib/ceph/tmp/mnt.3YsEmH: (22) Invalid =
argument^[[0m


What am i missing? any suggestion on both test cases would be appreciat=
ed. Thank you.

Isaac
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
