From: =?ISO-8859-2?Q?Maciej_Ga=B3kiewicz?=
	<maciejgalkiewicz@ragnarson.com>
Subject: can't read superblock
Date: Tue, 18 Jan 2011 12:59:05 +0100
Message-ID: <AANLkTim+oK0=_oK5DnsVwfR2mKndDTGpLBO-znwQfq8T@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:59745 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751662Ab1ARL7G (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 18 Jan 2011 06:59:06 -0500
Received: by pzk35 with SMTP id 35so957577pzk.19
        for <ceph-devel@vger.kernel.org>; Tue, 18 Jan 2011 03:59:06 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I could not report a bug in bug tracer (I am not allowed to or I just
couldn't find appropriate button?) so I send it here. There is a
problem on debian squeeze with kernel 2.6.32 and ceph kernel module.
Ceph version 0.24.1-1~bpo60+1. I can not mount filesystem on client
machine:

client:
# mount -t ceph 10.1.0.15:/ /ceph
# mount: 10.1.0.15:/: can't read superblock

mon0 log:
2011-01-18 12:08:23.534637 7ff675d6d710 -- 10.1.0.15:6789/0 >>
10.1.0.29:0/1783749524 pipe(0xd5b000 sd=8 pgs=0 cs=0 l=0).accept peer
addr is really 10.1.0.29:0/1783749524 (socket is 10.1.0.29:48987/0)
2011-01-18 12:10:27.338512 7ff675d6d710 -- 10.1.0.15:6789/0 >>
10.1.0.29:0/4142445380 pipe(0xd5d260 sd=8 pgs=0 cs=0 l=0).accept peer
addr is really 10.1.0.29:0/4142445380 (socket is 10.1.0.29:44569/0)

mon console:
# ceph -s
2011-01-18 12:50:54.083205    pg v287: 528 pgs: 528 active+clean; 0 KB
data, 27640 KB used, 2021 MB / 2048 MB avail
2011-01-18 12:50:54.084113   mds e6: 1/1/1 up {0=up:creating}, 1 up:standby
2011-01-18 12:50:54.084188   osd e9: 2 osds: 2 up, 2 in
2011-01-18 12:50:54.084286   log 2011-01-18 12:46:59.375405 osd0
10.1.0.15:6801/14921 285 : [INF] 3.1p0 scrub ok
2011-01-18 12:50:54.084432   mon e1: 2 mons at
{0=10.1.0.15:6789/0,1=10.1.0.27:6789/0}
