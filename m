From: Roman Hlynovskiy <roman.hlynovskiy@gmail.com>
Subject: recoverying from 95% full osd
Date: Tue, 8 Jan 2013 16:42:07 +0600
Message-ID: <CAD5ewroRv5-F0ZxBUmXqjz77zNenHQsrBacJ7LgXCqyduoxHsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f44.google.com ([209.85.212.44]:33815 "EHLO
	mail-vb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755696Ab3AHKmI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Jan 2013 05:42:08 -0500
Received: by mail-vb0-f44.google.com with SMTP id fc26so210560vbb.31
        for <ceph-devel@vger.kernel.org>; Tue, 08 Jan 2013 02:42:08 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello,

I am running ceph v0.56 and at the moment trying to recover ceph which
got completely stuck after 1 osd got filled by 95%. Looks like the
distribution algorithm is not perfect since all 3 OSD's I user are
256Gb each, however one of them got filled faster than others:

osd-1:
Filesystem            Size  Used Avail Use% Mounted on
/dev/mapper/vg00-osd  252G  173G   80G  69% /var/lib/ceph/osd/ceph-0

osd-2:
Filesystem            Size  Used Avail Use% Mounted on
/dev/mapper/vg00-osd  252G  203G   50G  81% /var/lib/ceph/osd/ceph-1

osd-3:
Filesystem            Size  Used Avail Use% Mounted on
/dev/mapper/vg00-osd  252G  240G   13G  96% /var/lib/ceph/osd/ceph-2


by the moment mds is showing the following behaviour:
2013-01-08 16:25:47.006354 b4a73b70  0 mds.0.objecter  FULL, paused
modify 0x9ba63c0 tid 23448
2013-01-08 16:26:47.005211 b4a73b70  0 mds.0.objecter  FULL, paused
modify 0xca86c30 tid 23449

so, it does not respond to any mount requests

I've played around with all types of commands like:
ceph mon tell \* injectargs '--mon-osd-full-ratio 98'
ceph mon tell \* injectargs '--mon-osd-full-ratio 0.98'

and

'mon osd full ratio = 0.98' in mon configuration for each mon

however

chef@ceph-node03:/var/log/ceph$ ceph health detail
HEALTH_ERR 1 full osd(s)
osd.2 is full at 95%

mds still believes 95% is the threshold, so no responses to mount requests.

chef@ceph-node03:/var/log/ceph$ rados -p data bench 10 write
 Maintaining 16 concurrent writes of 4194304 bytes for at least 10 seconds.
 Object prefix: benchmark_data_ceph-node03_3903
2013-01-08 16:33:02.363206 b6be3710  0 client.9958.objecter  FULL,
paused modify 0xa467ff0 tid 1
2013-01-08 16:33:02.363618 b6be3710  0 client.9958.objecter  FULL,
paused modify 0xa468780 tid 2
2013-01-08 16:33:02.363741 b6be3710  0 client.9958.objecter  FULL,
paused modify 0xa468f88 tid 3
2013-01-08 16:33:02.364056 b6be3710  0 client.9958.objecter  FULL,
paused modify 0xa469348 tid 4
2013-01-08 16:33:02.364171 b6be3710  0 client.9958.objecter  FULL,
paused modify 0xa469708 tid 5
2013-01-08 16:33:02.365024 b6be3710  0 client.9958.objecter  FULL,
paused modify 0xa469ac8 tid 6
2013-01-08 16:33:02.365187 b6be3710  0 client.9958.objecter  FULL,
paused modify 0xa46a2d0 tid 7
2013-01-08 16:33:02.365296 b6be3710  0 client.9958.objecter  FULL,
paused modify 0xa46a690 tid 8
2013-01-08 16:33:02.365402 b6be3710  0 client.9958.objecter  FULL,
paused modify 0xa46aa50 tid 9
2013-01-08 16:33:02.365508 b6be3710  0 client.9958.objecter  FULL,
paused modify 0xa46ae10 tid 10
2013-01-08 16:33:02.365635 b6be3710  0 client.9958.objecter  FULL,
paused modify 0xa46b1d0 tid 11
2013-01-08 16:33:02.365742 b6be3710  0 client.9958.objecter  FULL,
paused modify 0xa46b590 tid 12
2013-01-08 16:33:02.365868 b6be3710  0 client.9958.objecter  FULL,
paused modify 0xa46b950 tid 13
2013-01-08 16:33:02.365975 b6be3710  0 client.9958.objecter  FULL,
paused modify 0xa46bd10 tid 14
2013-01-08 16:33:02.366096 b6be3710  0 client.9958.objecter  FULL,
paused modify 0xa46c0d0 tid 15
2013-01-08 16:33:02.366203 b6be3710  0 client.9958.objecter  FULL,
paused modify 0xa46c490 tid 16
   sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   avg lat
     0      16        16         0         0         0         -         0
     1      16        16         0         0         0         -         0
     2      16        16         0         0         0         -         0

rados doesn't work.

chef@ceph-node03:/var/log/ceph$ ceph osd reweight-by-utilization
no change: average_util: 0.812678, overload_util: 0.975214. overloaded
osds: (none)

this one also.


is there any chance to recover ceph?


--
...WBR, Roman Hlynovskiy
