From: Drunkard Zhang <gongfan193@gmail.com>
Subject: osd not in tree
Date: Fri, 16 Nov 2012 15:21:12 +0800
Message-ID: <CAJiejCR3CocWucemBR1++dAohOASLSidnwCc9G=2cREFuTTXXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:52855 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750940Ab2KPHVc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Nov 2012 02:21:32 -0500
Received: by mail-ie0-f174.google.com with SMTP id k13so3199397iea.19
        for <ceph-devel@vger.kernel.org>; Thu, 15 Nov 2012 23:21:32 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I installed mon x1, mds x1 and osd x11 in one host, then add some osd
from other hosts, But they are not in osd tree, also not usable, how
can I fix this?

The crush command I used:
ceph osd crush set 11 osd.11 3 pool=data datacenter=dh-1L, room=room1,
row=02, rack=05, host=squid87-log13

The osds in down state is planed, but not added yet.


log3 ~ # ceph -s
   health HEALTH_OK
   monmap e1: 1 mons at {log3=10.205.119.2:6789/0}, election epoch 0,
quorum 0 log3
   osdmap e453: 28 osds: 14 up, 14 in
    pgmap v32649: 960 pgs: 960 active+clean; 1058 GB data, 2140 GB
used, 35422 GB / 39123 GB avail
   mdsmap e688: 1/1/1 up {0=aa=up:active}'
log3 ~ # ceph osd tree
dumped osdmap tree epoch 453
# id weight type name up/down reweight
-1 36 pool default
-3 36 rack unknownrack
-2 36 host log3
0 3 osd.0 up 3
1 3 osd.1 up 3
2 3 osd.2 up 3
3 3 osd.3 up 3
4 3 osd.4 up 3
5 3 osd.5 up 3
6 3 osd.6 up 3
7 3 osd.7 up 3
8 3 osd.8 up 3
9 3 osd.9 up 3
10 3 osd.10 up 3

11 0 osd.11 up 3
12 0 osd.12 up 3
13 0 osd.13 up 3
14 0 osd.14 down 0
15 0 osd.15 down 0
16 0 osd.16 down 0
17 0 osd.17 down 0
18 0 osd.18 down 0
19 0 osd.19 down 0
20 0 osd.20 down 0
21 0 osd.21 down 0
22 0 osd.22 down 0
23 0 osd.23 down 0
24 0 osd.24 down 0
25 0 osd.25 down 0
26 0 osd.26 down 0
27 0 osd.27 down 0

log3 ~ # ceph osd dump
dumped osdmap epoch 453
epoch 453
fsid cc239202-2278-40d0-9274-fdae6d4a0f2c
created 2012-11-07 14:08:18.310361
modifed 2012-11-16 15:09:20.677612
flags

pool 0 'data' rep size 2 crush_ruleset 0 object_hash rjenkins pg_num
320 pgp_num 320 last_change 1 owner 0 crash_replay_interval 45
pool 1 'metadata' rep size 3 crush_ruleset 1 object_hash rjenkins
pg_num 320 pgp_num 320 last_change 6 owner 0
pool 2 'rbd' rep size 2 crush_ruleset 2 object_hash rjenkins pg_num
320 pgp_num 320 last_change 1 owner 0

max_osd 28
osd.0 up   in  weight 3 up_from 400 up_thru 407 down_at 399
last_clean_interval [371,398) 10.205.119.2:6801/12912
10.205.119.2:6802/12912 10.205.119.2:6803/12912 exists,up
567885be-8edf-4f71-bb2b-410dd973b9e8
osd.1 up   in  weight 3 up_from 401 up_thru 407 down_at 400
last_clean_interval [372,398) 10.205.119.2:6806/13004
10.205.119.2:6809/13004 10.205.119.2:6812/13004 exists,up
617db970-0e2f-4188-93b4-8a825194c359
osd.2 up   in  weight 3 up_from 401 up_thru 407 down_at 400
last_clean_interval [373,398) 10.205.119.2:6818/13333
10.205.119.2:6820/13333 10.205.119.2:6821/13333 exists,up
887e2169-880a-47a9-83c6-11f83f166ed2
osd.3 up   in  weight 3 up_from 402 up_thru 407 down_at 401
last_clean_interval [373,398) 10.205.119.2:6824/13454
10.205.119.2:6827/13454 10.205.119.2:6830/13454 exists,up
237ab216-d405-4e60-a3ca-3ad2c1c2ec75
osd.4 up   in  weight 3 up_from 403 up_thru 407 down_at 402
last_clean_interval [374,398) 10.205.119.2:6833/13550
10.205.119.2:6836/13550 10.205.119.2:6837/13550 exists,up
c3ed8bc8-3393-487a-ace5-ee5d41acceb2
osd.5 up   in  weight 3 up_from 402 up_thru 407 down_at 401
last_clean_interval [374,398) 10.205.119.2:6838/13675
10.205.119.2:6839/13675 10.205.119.2:6840/13675 exists,up
0f6772ea-aab3-4b9b-a33c-44d04b8ba953
osd.6 up   in  weight 3 up_from 403 up_thru 407 down_at 402
last_clean_interval [374,398) 10.205.119.2:6841/13854
10.205.119.2:6842/13854 10.205.119.2:6843/13854 exists,up
2e7593ff-0acf-4f0d-a0a6-506702aed6f6
osd.7 up   in  weight 3 up_from 403 up_thru 407 down_at 402
last_clean_interval [396,398) 10.205.119.2:6844/14007
10.205.119.2:6845/14007 10.205.119.2:6846/14007 exists,up
6f236563-9c8f-4e61-ab96-84c57c9f6f96
osd.8 up   in  weight 3 up_from 404 up_thru 407 down_at 403
last_clean_interval [393,398) 10.205.119.2:6847/14145
10.205.119.2:6848/14145 10.205.119.2:6849/14145 exists,up
0d157aa5-528a-4cbb-ba1b-6c349b1f0d79
osd.9 up   in  weight 3 up_from 407 up_thru 407 down_at 406
last_clean_interval [382,398) 10.205.119.2:6850/14280
10.205.119.2:6851/14280 10.205.119.2:6852/14280 exists,up
a5036100-461a-450b-819e-e38f722ddf93
osd.10 up   in  weight 3 up_from 404 up_thru 407 down_at 403
last_clean_interval [377,398) 10.205.119.2:6814/13093
10.205.119.2:6815/13093 10.205.119.2:6816/13093 exists,up
19a88fc9-9f02-4ce8-a8d5-22b64e62142c
osd.11 up   in  weight 3 up_from 453 up_thru 277 down_at 452
last_clean_interval [343,452) 150.164.100.219:6800/827
150.164.100.219:6805/827 150.164.100.219:6808/827 exists,up
79a80fd3-f76e-4fa7-a623-433f328573f7
osd.12 up   in  weight 3 up_from 445 up_thru 0 down_at 444
last_clean_interval [345,444) 150.164.100.219:6804/1126
150.164.100.219:6809/1126 150.164.100.219:6803/1126 exists,up
5a5ff961-b122-4814-b4e7-35340b7f1bd6
osd.13 up   in  weight 3 up_from 434 up_thru 0 down_at 433
last_clean_interval [347,433) 150.164.100.219:6807/1415
150.164.100.219:6802/1415 150.164.100.219:6806/1415 exists,up
2e6aa5a1-a01f-4943-9efc-2e023b1f7db9
osd.14 down out weight 0 up_from 432 up_thru 0 down_at 433
last_clean_interval [349,431) 150.164.100.219:6810/1703
150.164.100.219:6808/1703 150.164.100.219:6811/1703 autoout,exists
540658ec-7daa-4231-8586-2b86d61fbdba
osd.15 down out weight 0 up_from 0 up_thru 0 down_at 0
last_clean_interval [0,0) :/0 :/0 :/0 exists,new
osd.16 down out weight 0 up_from 0 up_thru 0 down_at 0
last_clean_interval [0,0) :/0 :/0 :/0 exists,new
osd.17 down out weight 0 up_from 0 up_thru 0 down_at 0
last_clean_interval [0,0) :/0 :/0 :/0 exists,new
osd.18 down out weight 0 up_from 0 up_thru 0 down_at 0
last_clean_interval [0,0) :/0 :/0 :/0 exists,new
osd.19 down out weight 0 up_from 0 up_thru 0 down_at 0
last_clean_interval [0,0) :/0 :/0 :/0 exists,new
osd.20 down out weight 0 up_from 0 up_thru 0 down_at 0
last_clean_interval [0,0) :/0 :/0 :/0 exists,new
osd.21 down out weight 0 up_from 0 up_thru 0 down_at 0
last_clean_interval [0,0) :/0 :/0 :/0 exists,new
osd.22 down out weight 0 up_from 0 up_thru 0 down_at 0
last_clean_interval [0,0) :/0 :/0 :/0 exists,new
osd.23 down out weight 0 up_from 0 up_thru 0 down_at 0
last_clean_interval [0,0) :/0 :/0 :/0 exists,new
osd.24 down out weight 0 up_from 0 up_thru 0 down_at 0
last_clean_interval [0,0) :/0 :/0 :/0 exists,new
osd.25 down out weight 0 up_from 0 up_thru 0 down_at 0
last_clean_interval [0,0) :/0 :/0 :/0 exists,new
osd.26 down out weight 0 up_from 0 up_thru 0 down_at 0
last_clean_interval [0,0) :/0 :/0 :/0 exists,new
osd.27 down out weight 0 up_from 0 up_thru 0 down_at 0
last_clean_interval [0,0) :/0 :/0 :/0 exists,new

The osd on squid87-log13 is not used at all:
squid87-log13 ~ # df | grep osd
/dev/sdb1       2.8T  1.1G  2.7T   1% /ceph/osd.11
/dev/sdc1       2.8T 1009M  2.7T   1% /ceph/osd.12
/dev/sdd1       2.8T 1009M  2.7T   1% /ceph/osd.13
/dev/sde1       2.8T 1009M  2.7T   1% /ceph/osd.14
squid87-log13 ~ # netstat -ntulp | grep osd
tcp        0      0 0.0.0.0:6800            0.0.0.0:*
LISTEN      829/ceph-osd
tcp        0      0 150.164.100.219:6802    0.0.0.0:*
LISTEN      1417/ceph-osd
tcp        0      0 150.164.100.219:6803    0.0.0.0:*
LISTEN      1128/ceph-osd
tcp        0      0 0.0.0.0:6804            0.0.0.0:*
LISTEN      1128/ceph-osd
tcp        0      0 150.164.100.219:6805    0.0.0.0:*
LISTEN      829/ceph-osd
tcp        0      0 150.164.100.219:6806    0.0.0.0:*
LISTEN      1417/ceph-osd
tcp        0      0 0.0.0.0:6807            0.0.0.0:*
LISTEN      1417/ceph-osd
tcp        0      0 150.164.100.219:6808    0.0.0.0:*
LISTEN      829/ceph-osd
tcp        0      0 150.164.100.219:6809    0.0.0.0:*
LISTEN      1128/ceph-osd
