From: =?ISO-8859-1?Q?Alexis_G=DCNST_HORN?=
	<alexis.gunsthorn@outscale.com>
Subject: CephFS issue
Date: Mon, 14 Jan 2013 08:51:57 +0100
Message-ID: <CAEqYNSYaMvprh580HNosaQe7ahMmT-iB9irMsgA87tE2fwtCTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from eu1sys200aog116.obsmtp.com ([207.126.144.141]:34777 "HELO
	eu1sys200aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752905Ab3ANHwA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Mon, 14 Jan 2013 02:52:00 -0500
Received: by mail-ia0-f199.google.com with SMTP id u20so11949553iag.6
        for <ceph-devel@vger.kernel.org>; Sun, 13 Jan 2013 23:51:57 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello,

I've a 0.56.1 Ceph cluster up and running. RBD is working fine, but
i've some troubles with CephFS.

Here is my config :

- only 2 OSD nodes, with 10 disks each + SSD for journal.
- OSDs hosts are gigabit (public) + gigabit (private)
- one client which is 10 gigabit

The client mount a cephFS : /mnt/cephfs.

OK. working.

Then, i ran this little script on the client :


#!/bin/sh
cd /mnt/cephfs

function process {
  for a in {0..9} {a..f}; do
echo "Create disk $a ($1 G)";
truncate -s $(($1*1024*1024*1024)) $a;
echo "Format disk $a ($1 G)";
mke2fs -jF $a;
  done
}

process 150
process 340
process 420
process 840
process 1680


At the beginning, it works well. Then quickly, the Ceph cluster become
instable. A lot of warning appears :

2013-01-14 07:20:47.276215 osd.8 [WRN] slow request 32.023561 seconds
old, received at 2013-01-14 07:20:15.252598:
osd_op(client.4119.1:72303 10000000019.00013cc0 [write 0~8192
[1@-1],startsync 0~0] 0.1ddb4dfd RETRY snapc 1=[]) currently delayed


On the OSD itself, i have these messages :

2013-01-11 15:46:18.511465 7f9d8c4f5700  0 -- 172.17.243.40:6800/16010
>> 172.17.243.40:6818/16648 pipe(0x7f9d28001320 sd=31 :6800 pgs=10
cs=1 l=0).fault with nothing to send, going to standby
2013-01-11 16:06:18.570870 7f9d8c6f7700  0 -- 172.17.243.40:6800/16010
>> 172.17.243.39:6805/13385 pipe(0x7f9d28000e10 sd=30 :6800 pgs=8 cs=1
l=0).fault with nothing to send, going to standby

then

2013-01-11 16:13:27.691045 7f9d6e1e1700  0 -- 172.17.243.40:6800/16010
>> 172.17.243.39:6807/13483 pipe(0x7f9d28003690 sd=60 :6800 pgs=0 cs=0
l=0).accept connect_seq 2 vs existing 1 state standby

then

2013-01-11 16:15:31.548441 7f9d78ff9700  0 --
172.17.243.140:6800/16010 submit_message osd_op_reply(15037
10000000009.00001c20 [write 8192~2097152] ondisk = 0) v4 remote,
172.17.243.180:0/232969487, failed lossy con, dropping message
0x7f9d70130d40

At the end, the client mountpoint become unresponsive, and the only
way is to force reboot.


Do you have any idea ?
Thanks a lot,

Alexis
