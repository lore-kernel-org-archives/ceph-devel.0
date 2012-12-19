From: Michael Chapman <michael.chapman@anu.edu.au>
Subject: mon not marking dead osds down and slow streaming write performance
Date: Wed, 19 Dec 2012 14:02:07 +1100
Message-ID: <CABf87Xk54Q-SP2258MsXDVKAo2TgjOw8xds2f9W=XxmgdSRFTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f179.google.com ([209.85.216.179]:36456 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752924Ab2LSDCI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 18 Dec 2012 22:02:08 -0500
Received: by mail-qc0-f179.google.com with SMTP id b14so797098qcs.24
        for <ceph-devel@vger.kernel.org>; Tue, 18 Dec 2012 19:02:07 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all,

I apologise if this list is only for dev issues and not for operators,
I didn't see a more general list on the ceph website.

I have 5 OSD processes per host, and an FC uplink port failure caused
kernel panics in two hosts - 0404 and 0401. The mon log looks like
this:

2012-12-19 13:30:38.634865 7f9a0f167700 10 mon.3@0(leader).osd e2184
preprocess_query osd_failure(osd.404 172.22.4.4:6812/12835 for 8832
e2184 v2184) v3 from osd.602 172.22.4.6:6806/5152
2012-12-19 13:30:38.634875 7f9a0f167700  5 mon.3@0(leader).osd e2184
can_mark_down current up_ratio 0.298429 < min 0.3, will not mark
osd.404 down
2012-12-19 13:30:38.634880 7f9a0f167700  5 mon.3@0(leader).osd e2184 preprocess_

The cluster appears healthy

root@os-0405:~# ceph -s
   health HEALTH_OK
   monmap e3: 1 mons at {3=172.22.4.5:6789/0}, election epoch 1, quorum 0 3
   osdmap e2184: 191 osds: 57 up, 57 in
    pgmap v205386: 121952 pgs: 121951 active+clean, 1
active+clean+scrubbing; 4437 MB data, 49497 MB used, 103 TB / 103 TB
avail
   mdsmap e1: 0/0/1 up

root@os-0405:~# ceph osd tree

# id    weight  type name       up/down reweight
-1      30      pool default
-3      30              rack unknownrack
-2      6                       host os-0401
100     1                               osd.100 up      1
101     1                               osd.101 up      1
102     1                               osd.102 up      1
103     1                               osd.103 up      1
104     1                               osd.104 up      1
112     1                               osd.112 up      1
-4      6                       host os-0402
200     1                               osd.200 up      1
201     1                               osd.201 up      1
202     1                               osd.202 up      1
203     1                               osd.203 up      1
204     1                               osd.204 up      1
212     1                               osd.212 up      1
-5      6                       host os-0403
300     1                               osd.300 up      1
301     1                               osd.301 up      1
302     1                               osd.302 up      1
303     1                               osd.303 up      1
304     1                               osd.304 up      1
312     1                               osd.312 up      1
-6      6                       host os-0404
400     1                               osd.400 up      1
401     1                               osd.401 up      1
402     1                               osd.402 up      1
403     1                               osd.403 up      1
404     1                               osd.404 up      1
412     1                               osd.412 up      1
-7      0                       host os-0405
-8      6                       host os-0406
600     1                               osd.600 up      1
601     1                               osd.601 up      1
602     1                               osd.602 up      1
603     1                               osd.603 up      1
604     1                               osd.604 up      1
612     1                               osd.612 up      1

but os-0404 has no osd processes running anymore.

root@os-0404:~# ps aux | grep ceph
root      4964  0.0  0.0   9628   920 pts/1    S+   13:31   0:00 grep
--color=auto ceph

and even if it did, it can't access the luns in order to mount the xfs
filesystems with all the osd data.

What is preventing the mon from marking the osds on 0404 down?

A second issue I have been having is that my reads+writes are very
bursty, going from 8MB/s to 200MB/s when doing a dd from a physical
client over 10GbE. It seems to be waiting on the mon most of the time,
and iostat shows long io wait times for the disk the mon is using. I
can also see it writing ~40MB/s constantly to disk in iotop, though I
don't know if this is random or sequential. I see a lot of waiting for
sub ops which I thought might be a result of the io wait.

Is that a normal amount of activity for a mon process? Should I be
running the mon processes off more than just a single sata disk to
keep up with ~30 OSD processes?

Thanks for your time.

 - Michael Chapman
