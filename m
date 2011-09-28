From: huang jun <hjwsm1989@gmail.com>
Subject: heartbeat epoch
Date: Wed, 28 Sep 2011 22:59:21 +0800
Message-ID: <CABAwU-bJA62SRO47mBKdZa8at8mAr=v2KYeQGAs8ogXb4hpF5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:42913 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754722Ab1I1O7W convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 28 Sep 2011 10:59:22 -0400
Received: by pzk1 with SMTP id 1so20521867pzk.1
        for <ceph-devel@vger.kernel.org>; Wed, 28 Sep 2011 07:59:21 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

hi,all
we encountered some problem
origin cluster OSD0=85=85OSD23
we add OSD24=85=85OSD27

the OSD20 log:
2011-09-28 10:32:50.602820 7f63498b6700 osd20 27
update_heartbeat_peers: new _from osd24 192.168.0.118:6802/10487
2011-09-28 10:32:50.602831 7f63498b6700 -- 192.168.0.116:6802/10666
--> 192.168.0.118:6802/10487 -- osd_ping(e0 as_of 27
request_heartbeat) v1 -- ?+0 0x45a08c0 con 0x44863c0

the OSD24 log:
2011-09-28 10:13:23.325257 7f1c33c99700 osd24 25  advance to epoch 26
(<=3D newest 27)
2011-09-28 10:13:23.325261 7f1c33c99700 osd24 25 get_map 26 - cached 0x=
156f000
2011-09-28 10:13:23.325268 7f1c33c99700 osd24 26 advance_map epoch 26  =
0 pgs
2011-09-28 10:13:23.325273 7f1c33c99700 osd24 26 get_map 25 - cached 0x=
14d1c00
2011-09-28 10:13:23.325279 7f1c33c99700 osd24 26  advance to epoch 27
(<=3D newest 27)
2011-09-28 10:13:23.325282 7f1c33c99700 osd24 26 get_map 27 - cached 0x=
156f300
2011-09-28 10:13:23.325288 7f1c33c99700 osd24 27 advance_map epoch 27  =
0 pgs
2011-09-28 10:13:23.325292 7f1c33c99700 osd24 27 get_map 26 - cached 0x=
156f000
2011-09-28 10:13:23.325298 7f1c33c99700 osd24 27 activate_map version 2=
7

2011-09-28 10:16:43.576857 7f1c33c99700 osd24 28  advance to epoch 29
(<=3D newest 29)
2011-09-28 10:16:43.576868 7f1c33c99700 osd24 28 get_map 29 - cached 0x=
156f300
2011-09-28 10:16:43.576894 7f1c33c99700 osd24 29 advance_map epoch 29  =
27 pgs

i can not figure out why there is 0 pgs when OSD24 get osdmap of epoch =
27?
but the OSD20 really regard the OSD24 as the new heartbeat_from peer
at the epoch 27?
so this will result the OSD20 wronly marked OSD24 down.
is  it a normal operation to marked down the timeout osd?

thanks!
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
