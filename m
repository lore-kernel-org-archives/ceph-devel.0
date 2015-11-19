From: "Igor.Podoski@ts.fujitsu.com" <Igor.Podoski@ts.fujitsu.com>
Subject: FW: ceph_monitor - monitor your cluster with parallel python
Date: Thu, 19 Nov 2015 08:03:05 +0000
Message-ID: <f4bad529fa3f491c8a89ba158a2a113c@R01UKEXCASM222.r01.fujitsu.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail1.bemta14.messagelabs.com ([193.109.254.106]:53183 "EHLO
	mail1.bemta14.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756203AbbKSIKD convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 19 Nov 2015 03:10:03 -0500
Received: from R01UKEXCASM223.r01.fujitsu.local (ex2k13_223.fs.fujitsu.com [10.182.185.121])
	by mailhost4.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id tAJ80jNX009858
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL)
	for <ceph-devel@vger.kernel.org>; Thu, 19 Nov 2015 08:00:45 GMT
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hey, one more time here, I=92ve got reject from mail daemon.

Regards,
Igor.

=46rom: Podoski, Igor=20
Sent: Thursday, November 19, 2015 8:53 AM
To: ceph-devel; 'ceph-users@ceph.com'
Subject: ceph_monitor - monitor your cluster with parallel python

Hi Cephers!

I=92ve created small tool to help track memory/cpu/io usage. It=92s use=
ful for me so I thought I could share with you: https://github.com/aiic=
ore/ceph_monitor

In general this is a python script, that uses parallel python to run a =
function on remote host. Data is gathered from all hosts and presented =
on console or added to sqlite database, then can be plotted with e.g. g=
nuplot. You can define osd ranges, that you want to monitor, or monitor=
 certain process, e.g. osds only from pool that has ssds.

The main concept is that monitor don=92t know and don=92t care on which=
 host osd=92s are running, it treats them as a whole set.

Script uses psutil to get data related to processes (mon/osd/rgw/whatev=
er). In near feature I=92d like to add modes that can modify process be=
havior e.g. psutil has .nice .ionice .cpu_affinity methods, that could =
be useful in some tests. Basically with parallel python you can run any=
 function remotely, so tuning SO by changing some /proc/* files can be =
done too.

You can add labels to data to see when what happens.

Sample plot: https://raw.githubusercontent.com/aiicore/ceph_monitor/mas=
ter/examples/avg_cpu_mem.png=20
Simple test: https://github.com/aiicore/ceph_monitor/blob/master/exampl=
es/example_test_with_rados.sh=20

Short readme:=A0 https://github.com/aiicore/ceph_monitor=20
=46ull readme: https://github.com/aiicore/ceph_monitor/blob/master/read=
me.txt=20

I encourage You to use and develop it, if not just please read the full=
 readme text, maybe you=92ll =A0come up with a better idea based on my =
this concept and something interesting will happen.

p.s. This currently works with python 2.6 and psutil 0.6.1 on centos 6.=
6. =A0If you find any bug =96 report it on my github as an issue.

!!! Security notice !!!
Parallel python supports SHA authentication =A0=96 my version currently=
 runs WITHOUT this so in certain environments it could be dangerous (yo=
u could run any function from untrusted client). For now use it only in=
 test/dev isolated clusters.

Regards,
Igor.

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
