From: "Moore, Shawn M" <smmoore@catawba.edu>
Subject: Crushmap Design Question
Date: Tue, 8 Jan 2013 20:20:40 +0000
Message-ID: <AEBA0243790A484AA72D5CDF477159BC1CEB087D@SN2PRD0106MB178.prod.exchangelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from co1ehsobe003.messaging.microsoft.com ([216.32.180.186]:6385
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751210Ab3AHUUr convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 8 Jan 2013 15:20:47 -0500
Received: from mail169-co1 (localhost [127.0.0.1])	by
 mail169-co1-R.bigfish.com (Postfix) with ESMTP id 714B6B800DD	for
 <ceph-devel@vger.kernel.org>; Tue,  8 Jan 2013 20:20:46 +0000 (UTC)
Received: from CO1EHSMHS028.bigfish.com (unknown [10.243.78.215])	by
 mail169-co1.bigfish.com (Postfix) with ESMTP id 18F78300113	for
 <ceph-devel@vger.kernel.org>; Tue,  8 Jan 2013 20:20:44 +0000 (UTC)
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I have been testing ceph for a little over a month now.  Our design goal is to have 3 datacenters in different buildings all tied together over 10GbE.  Currently there are 10 servers each serving 1 osd in 2 of the datacenters.  In the third is one large server with 16 SAS disks serving 8 osds.  Eventually we will add one more identical large server into the third datacenter.  I have told ceph to keep 3 copies and tried to do the crushmap in such a way that as long as a majority of mon's can stay up, we could run off of one datacenter's worth of osds.   So in my testing, it doesn't work out quite this way...

Everything is currently ceph version 0.56.1 (e4a541624df62ef353e754391cbbb707f54b16f7)

I will put hopefully relevant files at the end of this email.

When all 28 osds are up, I get:
2013-01-08 13:56:07.435914 mon.0 [INF] pgmap v2712076: 7104 pgs: 7104 active+clean; 60264 MB data, 137 GB used, 13570 GB / 14146 GB avail

When I fail a datacenter (including 1 of 3 mon's) I eventually get:
2013-01-08 13:58:54.020477 mon.0 [INF] pgmap v2712139: 7104 pgs: 7104 active+degraded; 60264 MB data, 137 GB used, 13570 GB / 14146 GB avail; 16362/49086 degraded (33.333%)

At this point everything is still ok.  But when I fail the 2nd datacenter (still leaving 2 out of 3 mons running) I get:
2013-01-08 14:01:25.600056 mon.0 [INF] pgmap v2712189: 7104 pgs: 7104 incomplete; 60264 MB data, 137 GB used, 13570 GB / 14146 GB avail

Most VM's quit working and "rbd ls" works, but not a single line from "rados -p rbd ls" works and the command hangs.  Now after a while (you can see from timestamps) I end up at and stays this way: 
2013-01-08 14:40:54.030370 mon.0 [INF] pgmap v2713794: 7104 pgs: 213 active, 117 active+remapped, 3660 incomplete, 3108 active+degraded+remapped, 6 remapped+incomplete; 60264 MB data, 65701 MB used, 4604 GB / 4768 GB avail; 7696/49086 degraded (15.679%)

I'm hoping I've done something wrong, so please advise.  Below are my configs.  If you need something more to help, just ask.

Normal output with all datacenters up.
# ceph osd tree
# id	weight	type name	up/down	reweight
-1	80	root default
-3	36		datacenter hok
-2	1			host blade151
0	1				osd.0	up	1	
-4	1			host blade152
1	1				osd.1	up	1	
-15	1			host blade153
2	1				osd.2	up	1	
-17	1			host blade154
3	1				osd.3	up	1	
-18	1			host blade155
4	1				osd.4	up	1	
-19	1			host blade159
5	1				osd.5	up	1	
-20	1			host blade160
6	1				osd.6	up	1	
-21	1			host blade161
7	1				osd.7	up	1	
-22	1			host blade162
8	1				osd.8	up	1	
-23	1			host blade163
9	1				osd.9	up	1	
-24	36		datacenter csc
-5	1			host admbc0-01
10	1				osd.10	up	1	
-6	1			host admbc0-02
11	1				osd.11	up	1	
-7	1			host admbc0-03
12	1				osd.12	up	1	
-8	1			host admbc0-04
13	1				osd.13	up	1	
-9	1			host admbc0-05
14	1				osd.14	up	1	
-10	1			host admbc0-06
15	1				osd.15	up	1	
-11	1			host admbc0-09
16	1				osd.16	up	1	
-12	1			host admbc0-10
17	1				osd.17	up	1	
-13	1			host admbc0-11
18	1				osd.18	up	1	
-14	1			host admbc0-12
19	1				osd.19	up	1	
-25	8		datacenter adm
-16	8			host admdisk0
20	1				osd.20	up	1	
21	1				osd.21	up	1	
22	1				osd.22	up	1	
23	1				osd.23	up	1	
24	1				osd.24	up	1	
25	1				osd.25	up	1	
26	1				osd.26	up	1	
27	1				osd.27	up	1



Showing copes set to 3.
# ceph osd dump | grep " size "
pool 0 'data' rep size 3 crush_ruleset 0 object_hash rjenkins pg_num 2368 pgp_num 2368 last_change 63 owner 0 crash_replay_interval 45
pool 1 'metadata' rep size 3 crush_ruleset 1 object_hash rjenkins pg_num 2368 pgp_num 2368 last_change 65 owner 0
pool 2 'rbd' rep size 3 crush_ruleset 2 object_hash rjenkins pg_num 2368 pgp_num 2368 last_change 6061 owner 0




Crushmap
# begin crush map

# devices
device 0 osd.0
device 1 osd.1
device 2 osd.2
device 3 osd.3
device 4 osd.4
device 5 osd.5
device 6 osd.6
device 7 osd.7
device 8 osd.8
device 9 osd.9
device 10 osd.10
device 11 osd.11
device 12 osd.12
device 13 osd.13
device 14 osd.14
device 15 osd.15
device 16 osd.16
device 17 osd.17
device 18 osd.18
device 19 osd.19
device 20 osd.20
device 21 osd.21
device 22 osd.22
device 23 osd.23
device 24 osd.24
device 25 osd.25
device 26 osd.26
device 27 osd.27

# types
type 0 osd
type 1 host
type 2 rack
type 3 row
type 4 room
type 5 datacenter
type 6 root

# buckets
host blade151 {
	id -2		# do not change unnecessarily
	# weight 1.000
	alg straw
	hash 0	# rjenkins1
	item osd.0 weight 1.000
}
host blade152 {
	id -4		# do not change unnecessarily
	# weight 1.000
	alg straw
	hash 0	# rjenkins1
	item osd.1 weight 1.000
}
host blade153 {
	id -15		# do not change unnecessarily
	# weight 1.000
	alg straw
	hash 0	# rjenkins1
	item osd.2 weight 1.000
}
host blade154 {
	id -17		# do not change unnecessarily
	# weight 1.000
	alg straw
	hash 0	# rjenkins1
	item osd.3 weight 1.000
}
host blade155 {
	id -18		# do not change unnecessarily
	# weight 1.000
	alg straw
	hash 0	# rjenkins1
	item osd.4 weight 1.000
}
host blade159 {
	id -19		# do not change unnecessarily
	# weight 1.000
	alg straw
	hash 0	# rjenkins1
	item osd.5 weight 1.000
}
host blade160 {
	id -20		# do not change unnecessarily
	# weight 1.000
	alg straw
	hash 0	# rjenkins1
	item osd.6 weight 1.000
}
host blade161 {
	id -21		# do not change unnecessarily
	# weight 1.000
	alg straw
	hash 0	# rjenkins1
	item osd.7 weight 1.000
}
host blade162 {
	id -22		# do not change unnecessarily
	# weight 1.000
	alg straw
	hash 0	# rjenkins1
	item osd.8 weight 1.000
}
host blade163 {
	id -23		# do not change unnecessarily
	# weight 1.000
	alg straw
	hash 0	# rjenkins1
	item osd.9 weight 1.000
}
datacenter hok {
	id -3		# do not change unnecessarily
	# weight 10.000
	alg straw
	hash 0	# rjenkins1
	item blade151 weight 1.000
	item blade152 weight 1.000
	item blade153 weight 1.000
	item blade154 weight 1.000
	item blade155 weight 1.000
	item blade159 weight 1.000
	item blade160 weight 1.000
	item blade161 weight 1.000
	item blade162 weight 1.000
	item blade163 weight 1.000
}
host admbc0-01 {
	id -5		# do not change unnecessarily
	# weight 1.000
	alg straw
	hash 0	# rjenkins1
	item osd.10 weight 1.000
}
host admbc0-02 {
	id -6		# do not change unnecessarily
	# weight 1.000
	alg straw
	hash 0	# rjenkins1
	item osd.11 weight 1.000
}
host admbc0-03 {
	id -7		# do not change unnecessarily
	# weight 1.000
	alg straw
	hash 0	# rjenkins1
	item osd.12 weight 1.000
}
host admbc0-04 {
	id -8		# do not change unnecessarily
	# weight 1.000
	alg straw
	hash 0	# rjenkins1
	item osd.13 weight 1.000
}
host admbc0-05 {
	id -9		# do not change unnecessarily
	# weight 1.000
	alg straw
	hash 0	# rjenkins1
	item osd.14 weight 1.000
}
host admbc0-06 {
	id -10		# do not change unnecessarily
	# weight 1.000
	alg straw
	hash 0	# rjenkins1
	item osd.15 weight 1.000
}
host admbc0-09 {
	id -11		# do not change unnecessarily
	# weight 1.000
	alg straw
	hash 0	# rjenkins1
	item osd.16 weight 1.000
}
host admbc0-10 {
	id -12		# do not change unnecessarily
	# weight 1.000
	alg straw
	hash 0	# rjenkins1
	item osd.17 weight 1.000
}
host admbc0-11 {
	id -13		# do not change unnecessarily
	# weight 1.000
	alg straw
	hash 0	# rjenkins1
	item osd.18 weight 1.000
}
host admbc0-12 {
	id -14		# do not change unnecessarily
	# weight 1.000
	alg straw
	hash 0	# rjenkins1
	item osd.19 weight 1.000
}
datacenter csc {
	id -24		# do not change unnecessarily
	# weight 10.000
	alg straw
	hash 0	# rjenkins1
	item admbc0-01 weight 1.000
	item admbc0-02 weight 1.000
	item admbc0-03 weight 1.000
	item admbc0-04 weight 1.000
	item admbc0-05 weight 1.000
	item admbc0-06 weight 1.000
	item admbc0-09 weight 1.000
	item admbc0-10 weight 1.000
	item admbc0-11 weight 1.000
	item admbc0-12 weight 1.000
}
host admdisk0 {
	id -16		# do not change unnecessarily
	# weight 8.000
	alg straw
	hash 0	# rjenkins1
	item osd.20 weight 1.000
	item osd.21 weight 1.000
	item osd.22 weight 1.000
	item osd.23 weight 1.000
	item osd.24 weight 1.000
	item osd.25 weight 1.000
	item osd.26 weight 1.000
	item osd.27 weight 1.000
}
datacenter adm {
	id -25		# do not change unnecessarily
	# weight 8.000
	alg straw
	hash 0	# rjenkins1
	item admdisk0 weight 8.000
}
root default {
	id -1		# do not change unnecessarily
	# weight 80.000
	alg straw
	hash 0	# rjenkins1
	item hok weight 36.000
	item csc weight 36.000
	item adm weight 8.000
}

# rules
rule data {
	ruleset 0
	type replicated
	min_size 1
	max_size 10
	step take default
	step chooseleaf firstn 0 type datacenter
	step emit
}
rule metadata {
	ruleset 1
	type replicated
	min_size 1
	max_size 10
	step take default
	step chooseleaf firstn 0 type datacenter
	step emit
}
rule rbd {
	ruleset 2
	type replicated
	min_size 1
	max_size 10
	step take default
	step chooseleaf firstn 0 type datacenter
	step emit
}

# end crush map

