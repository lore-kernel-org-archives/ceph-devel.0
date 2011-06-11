From: Wilfrid Allembrand <wilfrid.allembrand@gmail.com>
Subject: OSD wrongly marked up (well, half up)
Date: Sat, 11 Jun 2011 23:08:42 +0200
Message-ID: <BANLkTimJZ=zpr0VoiSDK34Dkc4sVZeqX=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:34808 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751679Ab1FKVIn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 11 Jun 2011 17:08:43 -0400
Received: by ywe9 with SMTP id 9so1460793ywe.19
        for <ceph-devel@vger.kernel.org>; Sat, 11 Jun 2011 14:08:42 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all,

On my test cluster I have 3 MON, 2 MDS and 2 OSD. I'm doing some
failover test on OSD and got a strange thing on the status.
The 2 nodes hosting the OSDs have been shutdown but the status continu
to 'see' one alive :

# ceph -v
ceph version 0.29 (commit:8e69c39f69936e2912a887247c6e268d1c9059ed)
# uname -a
Linux test2 2.6.38-8-server #42-Ubuntu SMP Mon Apr 11 03:49:04 UTC
2011 x86_64 x86_64 x86_64 GNU/Linux

root@test2:~# ceph health
2011-06-11 17:03:38.492734 mon <- [health]
2011-06-11 17:03:38.493913 mon1 -> 'HEALTH_WARN 594 pgs degraded,
551/1102 degraded (50.000%); 1/2 osds down, 1/2 osds out' (0)

root@test2:~# ceph osd stat
2011-06-11 17:03:48.071885 mon <- [osd,stat]
2011-06-11 17:03:48.073290 mon1 -> 'e31: 2 osds: 1 up, 1 in' (0)

root@test2:~# ceph mds stat
2011-06-11 17:03:54.868986 mon <- [mds,stat]
2011-06-11 17:03:54.870418 mon1 -> 'e48: 1/1/1 up {0=test4=up:active},
1 up:standby' (0)

root@test2:~# ceph mon stat
2011-06-11 17:04:09.638549 mon <- [mon,stat]
2011-06-11 17:04:09.639994 mon0 -> 'e1: 3 mons at
{0=10.1.56.231:6789/0,1=10.1.56.232:6789/0,2=10.1.56.233:6789/0},
election epoch 508, quorum 0,1,2' (0)

How could it be, is it a bug ?
(be sure I triple checked that my 2 osd nodes are really shutdown)

Thanks !
Wilfrid
