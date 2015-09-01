From: huang jun <hjwsm1989@gmail.com>
Subject: how to improve ceph cluster capacity usage
Date: Tue, 1 Sep 2015 22:58:46 +0800
Message-ID: <CABAwU-bokuGL4LzVHxobpHDdGtv7An5JkqVyuAWc5ardk0_rfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f51.google.com ([209.85.213.51]:35216 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754156AbbIAO6r (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 1 Sep 2015 10:58:47 -0400
Received: by vkaw128 with SMTP id w128so58133105vka.2
        for <ceph-devel@vger.kernel.org>; Tue, 01 Sep 2015 07:58:46 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>, ceph-users@lists.ceph.com

hi,all

Recently, i did some experiments on OSD data distribution,
we set up a cluster with 72 OSDs,all 2TB sata disk,
and ceph version is v0.94.3 and linux kernel version is 3.18,
and set "ceph osd crush tunables optimal".
There are 3 pools:
pool 0 'rbd' replicated size 2 min_size 1 crush_ruleset 0 object_hash
rjenkins pg_num 512 pgp_num 512 last_change 302 stripe_width 0
pool 1 'data' replicated size 2 min_size 1 crush_ruleset 0 object_hash
rjenkins pg_num 4096 pgp_num 4096 last_change 832
crash_replay_interval 45 stripe_width 0
pool 2 'metadata' replicated size 3 min_size 1 crush_ruleset 0
object_hash rjenkins pg_num 512 pgp_num 512 last_change 302
stripe_width 0

the osd pg num of each osd:
pool  : 0      1      2      | SUM
----------------------------------------
osd.0   13     105    18     | 136
osd.1   17     110    26     | 153
osd.2   15     114    20     | 149
osd.3   11     101    17     | 129
osd.4   8      106    17     | 131
osd.5   12     102    19     | 133
osd.6   19     114    29     | 162
osd.7   16     115    21     | 152
osd.8   15     117    25     | 157
osd.9   13     117    23     | 153
osd.10  13     133    16     | 162
osd.11  14     105    21     | 140
osd.12  11     94     16     | 121
osd.13  12     110    21     | 143
osd.14  20     119    26     | 165
osd.15  12     125    19     | 156
osd.16  15     126    22     | 163
osd.17  13     109    19     | 141
osd.18  8      119    19     | 146
osd.19  14     114    19     | 147
osd.20  17     113    29     | 159
osd.21  17     111    27     | 155
osd.22  13     121    20     | 154
osd.23  14     95     23     | 132
osd.24  17     110    26     | 153
osd.25  13     133    15     | 161
osd.26  17     124    24     | 165
osd.27  16     119    20     | 155
osd.28  19     134    30     | 183
osd.29  13     121    20     | 154
osd.30  11     97     20     | 128
osd.31  12     109    18     | 139
osd.32  10     112    15     | 137
osd.33  18     114    28     | 160
osd.34  19     112    29     | 160
osd.35  16     121    32     | 169
osd.36  13     111    18     | 142
osd.37  15     107    22     | 144
osd.38  21     129    24     | 174
osd.39  9      121    17     | 147
osd.40  11     102    18     | 131
osd.41  14     101    19     | 134
osd.42  16     119    25     | 160
osd.43  12     118    13     | 143
osd.44  17     114    25     | 156
osd.45  11     114    15     | 140
osd.46  12     107    16     | 135
osd.47  15     111    23     | 149
osd.48  14     115    20     | 149
osd.49  9      94     13     | 116
osd.50  14     117    18     | 149
osd.51  13     112    19     | 144
osd.52  11     126    22     | 159
osd.53  12     122    18     | 152
osd.54  13     121    20     | 154
osd.55  17     114    25     | 156
osd.56  11     118    18     | 147
osd.57  22     137    25     | 184
osd.58  15     105    22     | 142
osd.59  13     120    18     | 151
osd.60  12     110    19     | 141
osd.61  21     114    28     | 163
osd.62  12     97     18     | 127
osd.63  19     109    31     | 159
osd.64  10     132    21     | 163
osd.65  19     137    21     | 177
osd.66  22     107    32     | 161
osd.67  12     107    20     | 139
osd.68  14     100    22     | 136
osd.69  16     110    24     | 150
osd.70  9      101    14     | 124
osd.71  15     112    24     | 151

----------------------------------------
SUM   : 1024   8192   1536   |

We can found that, for poolid=1(data pool),
osd.57 and osd.65 both have 137 PGs but osd.12 and osd.49 only have 94 PGs,
which maybe cause data distribution imbanlance, and reduces the space
utilization of the cluster.

Use "crushtool -i crush.raw --test --show-mappings --rule 0 --num-rep
2 --min-x 1 --max-x %s"
we tested different pool pg_num:

Total PG num PG num stats
------------ -------------------
4096 avg: 113.777778 (avg stands for avg PG num of every osd)
total: 8192  (total stands for total PG num, include replica PG)
max: 139 +0.221680 (max stands for max PG num on OSD, +0.221680 stands
for percent above avage PG num )
min: 113 -0.226562 (min stands for min PG num on OSD, -0.226562 stands
for ratio below avage PG num )

8192 avg: 227.555556
total: 16384
max: 267 0.173340
min: 226 -0.129883

16384 avg: 455.111111
total: 32768
max: 502 0.103027
min: 455 -0.127686

32768 avg: 910.222222
total: 65536
max: 966 0.061279
min: 910 -0.076050

With bigger pg_num, the gap between the maximum and the minimum decreased.
But it's unreasonable to set such large pg_num, which will increase
OSD and MON load.

Is there any way to get a more balanced PG distribution of the cluster?
We tried "ceph osd reweight-by-pg 110 data" many times, but that can
not resolve the problem.

Another problem is that if we can ensure the PG is distributed
balanced, can we ensure the data
distribution is balanced like PG?

Btw, we will write data to this cluster until one or more osd get
full, we set full ratio to 0.98,
and we expect the cluster can use 0.9 total capacity.

Any tips are welcome.

-- 
thanks
huangjun
