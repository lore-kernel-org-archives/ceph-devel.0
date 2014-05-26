From: "Wang, Zhiqiang" <zhiqiang.wang@intel.com>
Subject: Slow request on cache tiering
Date: Mon, 26 May 2014 12:05:44 +0000
Message-ID: <06E7D85B3BA36C4DB207FEDE871C5348851DB6@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:50985 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751830AbaEZMGX convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 26 May 2014 08:06:23 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi all,

I'm experiencing a problem when running ceph with cache tiering. Can someone help to take a look? Any comments are appreciated, thx!

===Configuration===
I have 2 pools, one is 'rbd', the other is 'cache'. Pool 'cache' is the cache tier of pool 'rbd'. The 'rbd' pool has 16 HDD OSDs. And the 'cache' pool has 8 SSD OSDs.
Here is the OSD tree:
# id    weight  type name       up/down reweight
-6      8       root ssd
-4      4               host zqw-s1-ssd
16      1                       osd.16  up      1
17      1                       osd.17  up      1
18      1                       osd.18  up      1
19      1                       osd.19  up      1
-5      4               host zqw-s2-ssd
20      1                       osd.20  up      1
21      1                       osd.21  up      1
22      1                       osd.22  up      1
23      1                       osd.23  up      1
-1      14.56   root default
-2      7.28            host zqw-s1
0       0.91                    osd.0   up      1
1       0.91                    osd.1   up      1
2       0.91                    osd.2   up      1
3       0.91                    osd.3   up      1
4       0.91                    osd.4   up      1
5       0.91                    osd.5   up      1
6       0.91                    osd.6   up      1
7       0.91                    osd.7   up      1
-3      7.28            host zqw-s2
8       0.91                    osd.8   up      1
9       0.91                    osd.9   up      1
10      0.91                    osd.10  up      1
11      0.91                    osd.11  up      1
12      0.91                    osd.12  up      1
13      0.91                    osd.13  up      1
14      0.91                    osd.14  up      1
15      0.91                    osd.15  up      1

===Problem===
After running IO for a while, I start to see the 'slow request' warnings in the ceph log:

2014-05-26 14:53:23.606138 osd.20 10.44.44.6:6823/61598 14 : [WRN] 6 slow requests, 6 included below; oldest blocked for > 30.921077 secs
2014-05-26 14:53:23.606149 osd.20 10.44.44.6:6823/61598 15 : [WRN] slow request 30.921077 seconds old, received at 2014-05-26 14:52:52.684957: osd_op(client.42161.0:10162 rb.0.93ff.238e1f29.00000000028f [set-alloc-hint object_size 4194304 write_size 4194304,write 0~524288] 22.7ec98e46 ack+ondisk+write e16745) v4 currently waiting for subops from 16
...
2014-05-26 14:53:23.483175 osd.21 10.44.44.6:6825/61597 37 : [WRN] 6 slow requests, 6 included below; oldest blocked for > 30.664500 secs
2014-05-26 14:53:23.483189 osd.21 10.44.44.6:6825/61597 38 : [WRN] slow request 30.664500 seconds old, received at 2014-05-26 14:52:52.799480: osd_op(client.42177.0:10020 rb.0.93f2.238e1f29.000000000239 [set-alloc-hint object_size 4194304 write_size 4194304,write 0~524288] 22.a3cdd2df ack+ondisk+write e16745) v4 currently waiting for subops from 16
...
2014-05-26 14:53:23.483164 osd.23 10.44.44.6:6816/61595 36 : [WRN] 6 slow requests, 6 included below; oldest blocked for > 30.740852 secs
2014-05-26 14:53:23.483178 osd.23 10.44.44.6:6816/61595 37 : [WRN] slow request 30.740852 seconds old, received at 2014-05-26 14:52:52.737293: osd_op(client.42171.0:9359 rb.0.93fd.238e1f29.00000000022b [set-alloc-hint object_size 4194304 write_size 4194304,write 0~524288] 22.5e9da689 ack+ondisk+write e16745) v4 currently waiting for subops from 16
...
2014-05-26 14:53:23.808628 osd.22 10.44.44.6:6813/61596 24 : [WRN] 4 slow requests, 4 included below; oldest blocked for > 30.571487 secs
2014-05-26 14:53:23.808638 osd.22 10.44.44.6:6813/61596 25 : [WRN] slow request 30.571487 seconds old, received at 2014-05-26 14:52:53.237048: osd_op(client.42174.0:9872 rb.0.93f7.238e1f29.00000000023f [set-alloc-hint object_size 4194304 write_size 4194304,write 0~524288] 22.8d495fcc ack+ondisk+write e16745) v4 currently waiting for subops from 16
...
2014-05-26 14:53:23.553157 osd.16 10.44.44.5:6855/72950 62 : [WRN] 6 slow requests, 6 included below; oldest blocked for > 30.930690 secs
2014-05-26 14:53:23.553168 osd.16 10.44.44.5:6855/72950 63 : [WRN] slow request 30.930690 seconds old, received at 2014-05-26 14:52:52.586582: osd_op(client.42175.0:9650 rb.0.93f1.2ae8944a.000000000236 [set-alloc-hint object_size 4194304 write_size 4194304,write 0~524288] 22.3dec4f3b ack+ondisk+write e16745) v4 currently waiting for subops from 20
...
2014-05-26 14:53:35.553099 mon.0 10.44.44.5:6789/0 1348 : [INF] osd.16 10.44.44.5:6855/72950 failed (6 reports from 4 peers after 27.877781 >= grace 26.858363)
2014-05-26 14:53:35.871891 mon.0 10.44.44.5:6789/0 1350 : [INF] osdmap e16746: 24 osds: 23 up, 24 in
...
2014-05-26 14:53:38.168716 osd.16 10.44.44.5:6855/72950 152 : [WRN] map e16747 wrongly marked me down

===Analysis===
From the above log, it seems something went wrong on OSD 16. OSD 16 is on server 'zqw-s1'. The other 4 SSD OSDs (20, 21, 22, 23) on the other server 'zqw-s2' are waiting for operations on OSD 16. Finally the monitor thinks the OSD 16 failed and marked it down. However, OSD 16 didn't think so.

Look at the log of OSD 20, 21, 22 and 23, around the time when the 'slow request' happened, these OSDs didn't get reply from OSD 16 during heartbeat check:
2014-05-26 14:53:27.606927 7f163d0c8700 -1 osd.20 16745 heartbeat_check: no reply from osd.16 since back 2014-05-26 14:53:07.369988 front 2014-05-26 14:53:07.369988 (cutoff 2014-05-26 14:53:07.606925)

And from the log of OSD 16, around the time of the 'slow request', there are lots of logs like this:
2014-05-26 14:53:23.772145 7fb39e35a700  1 heartbeat_map is_healthy 'OSD::op_tp thread 0x7fb39a352700' had timed out after 15

===Questions===
1. From the simple analysis above, looks like the slow request happens when doing PG replicating. The heartbeat also fails. Is it possibly because the cluster network is too busy? I'm currently using 10Gb public network and 10Gb cluster network. If it is true, why I don't see slow request caused by other OSDs at the same time?
2. I run into this problem quite often when running ceph with cache tiering. But I don't see this problem when running without it. Is it possible that OSD 16 stuck at some cache tiering specific code?
3. Any other reasons may cause the 'slow request' like this?
4. I noticed from 'iostat' that when the 'slow request' happened, the cluster halted the IO for 60s. Is this true?
