From: =?ISO-8859-1?Q?Matthijs_M=F6hlmann?= <matthijs@cacholong.nl>
Subject: Fwd: [ceph-users] Ceph cluster and rbd (communication trouble?)
Date: Tue, 18 Jun 2013 23:37:16 +0200
Message-ID: <51C0D30C.3020702@cacholong.nl>
References: <51BB0173.9000705@cacholong.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from web01.cacholong.nl ([46.182.221.98]:40645 "EHLO
	ironhorse.hellinga-webservice.nl" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S933051Ab3FRVmt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Tue, 18 Jun 2013 17:42:49 -0400
Received: from localhost (localhost [127.0.0.1])
	by ironhorse.hellinga-webservice.nl (Postfix) with ESMTP id 1E334C00481E2
	for <ceph-devel@vger.kernel.org>; Tue, 18 Jun 2013 23:37:20 +0200 (CEST)
Received: from ironhorse.hellinga-webservice.nl ([127.0.0.1])
	by localhost (ironhorse.hellinga-webservice.nl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id fXWvHzvsgAGz for <ceph-devel@vger.kernel.org>;
	Tue, 18 Jun 2013 23:37:18 +0200 (CEST)
Received: from Matthijss-MacBook-Pro.local (matthijs.cacholong.nl [83.161.145.88])
	(Authenticated sender: matthijs@cacholong.nl)
	by ironhorse.hellinga-webservice.nl (Postfix) with ESMTPSA id 93C8CC00481F3
	for <ceph-devel@vger.kernel.org>; Tue, 18 Jun 2013 23:37:16 +0200 (CEST)
In-Reply-To: <51BB0173.9000705@cacholong.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello all,

I'm forwarding this message to ceph-devel@ to see if someone here has a=
n
answer to my problem.

Is there a way to debug this issue? And if you do need more information
please don't hesitate to ask.

One more note:
The messages below in the osd logs are coming in at a rate of few
messages per minute.

Please, keep me in the CC as I'm not subscribed to this list.

Regards,

Matthijs M=F6hlmann
Cacholong

-------- Original Message --------
Subject: [ceph-users] Ceph cluster and rbd (communication trouble?)
Date: Fri, 14 Jun 2013 13:41:39 +0200
=46rom: Matthijs M=F6hlmann <matthijs@cacholong.nl>
To: ceph-users@lists.ceph.com

Hello all,

=46irst of all:
Thanks for this wonderfull piece of software. This way we are able to
truly have redundant storage.

=46irst the situation:
We have currently running 1 Storage server (running 8 OSD's), this is
the only storage server we currently have and will be expanded by one
more in the near future. This server has also 1 MON running.
We also have 2 VM servers (running xen). Each of these servers have one
MON server running.

We are using RBD for the block devices which get attached by xen to the
VPS. After that the VPS can startup and do its thing.

Now the logs of the VM server are showing the following:
[188542.746229] libceph: osd1 10.150.150.10:6804 socket closed (con
state OPEN)
[188542.747963] rbd: obj_request ffff88010ab8c2c0 was already done
[188542.747963]
[188547.758064] libceph: osd1 10.150.150.10:6804 socket closed (con
state OPEN)
[188547.758940] libceph: osd1 10.150.150.10:6804 socket error on read
[188548.671066] rbd: obj_request ffff88010ab8c2c0 was already done
[188548.671066]

Looking at the osd log (in this case osd1):
2013-06-14 13:31:24.038029 7f7ba8d89700  0 bad crc in data 1404955113 !=
=3D
exp 3510295870
2013-06-14 13:31:24.038599 7f7ba8d89700  0 -- 10.150.150.10:6804/5205 >=
>
10.150.150.101:0/1542084666 pipe(0x6021400 sd=3D32 :6804 s=3D0 pgs=3D0 =
cs=3D0
l=3D0).accept peer addr is really 10.150.150.101:0/1542084666 (socket i=
s
10.150.150.101:41501/0)
2013-06-14 13:31:24.038714 7f7ba8d89700  0 auth: could not find secret_=
id=3D0
2013-06-14 13:31:24.038725 7f7ba8d89700  0 cephx: verify_authorizer
could not get service secret for service osd secret_id=3D0
2013-06-14 13:31:24.038731 7f7ba8d89700  0 -- 10.150.150.10:6804/5205 >=
>
10.150.150.101:0/1542084666 pipe(0x6021400 sd=3D32 :6804 s=3D0 pgs=3D0 =
cs=3D0
l=3D1).accept: got bad authorizer
2013-06-14 13:31:29.049213 7f7ba8d89700  0 bad crc in data 1760589740 !=
=3D
exp 3270696062
2013-06-14 13:31:29.049976 7f7ba8d89700  0 -- 10.150.150.10:6804/5205 >=
>
10.150.150.101:0/1542084666 pipe(0x799b180 sd=3D32 :6804 s=3D0 pgs=3D0 =
cs=3D0
l=3D0).accept peer addr is really 10.150.150.101:0/1542084666 (socket i=
s
10.150.150.101:41502/0)
2013-06-14 13:31:29.050113 7f7ba8d89700  0 auth: could not find secret_=
id=3D0
2013-06-14 13:31:29.050124 7f7ba8d89700  0 cephx: verify_authorizer
could not get service secret for service osd secret_id=3D0
2013-06-14 13:31:29.050129 7f7ba8d89700  0 -- 10.150.150.10:6804/5205 >=
>
10.150.150.101:0/1542084666 pipe(0x799b180 sd=3D32 :6804 s=3D0 pgs=3D0 =
cs=3D0
l=3D1).accept: got bad authorizer
2013-06-14 13:31:29.961212 7f7ba8d89700  0 -- 10.150.150.10:6804/5205 >=
>
10.150.150.101:0/1542084666 pipe(0x799af00 sd=3D32 :6804 s=3D0 pgs=3D0 =
cs=3D0
l=3D0).accept peer addr is really 10.150.150.101:0/1542084666 (socket i=
s
10.150.150.101:41503/0)

This happens to all the OSD servers running on the storage machine, so
it is not only this one causing trouble.

Checking the health of ceph:
root@vms02:~# ceph status
   health HEALTH_OK
   monmap e1: 3 mons at
{a=3D10.150.150.10:6789/0,b=3D10.150.150.102:6789/0,c=3D10.150.150.101:=
6789/0}, election
epoch 24, quorum 0,1,2 a,b,c
   osdmap e95: 8 osds: 8 up, 8 in
    pgmap v39247: 592 pgs: 592 active+clean; 19870 MB data, 119 GB used=
,
14773 GB / 14892 GB avail; 11448B/s wr, 0op/s
   mdsmap e1: 0/0/1 up

Obviously something is causing the warnings / errors but I don't know
what. Can someone help me in understanding what's going on here?

All our servers are running Debian Wheezy with all updates applied.
We're using the ceph sources from ceph.com to install ceph.

The servers have all the same kernel and software versions installed:
Linux kernel version:
Linux vms02 3.9-1-amd64 #1 SMP Debian 3.9.4-1 x86_64 GNU/Linux

Version of ceph:
0.61.3-1~bpo70+1

Cephx enabled.

Let me know if you need more information.

Regards,

Matthijs M=F6hlmann
_______________________________________________
ceph-users mailing list
ceph-users@lists.ceph.com
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
