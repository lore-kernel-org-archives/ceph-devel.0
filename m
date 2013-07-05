From: Mark Kirkwood <mark.kirkwood@catalyst.net.nz>
Subject: Unexpected pg placement in degraded mode with custom crush rule
Date: Fri, 05 Jul 2013 15:36:52 +1200
Message-ID: <51D63F54.70900@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:47444 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757050Ab3GEDpx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 4 Jul 2013 23:45:53 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.catalyst.net.nz (Postfix) with ESMTP id 957516766D
	for <ceph-devel@vger.kernel.org>; Fri,  5 Jul 2013 15:36:53 +1200 (NZST)
Received: from mail.catalyst.net.nz ([127.0.0.1])
	by localhost (bertrand.catalyst.net.nz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UXbKwSRaj+Zu for <ceph-devel@vger.kernel.org>;
	Fri,  5 Jul 2013 15:36:52 +1200 (NZST)
Received: from [IPv6:2404:130:0:1000:222:4dff:fe88:a586] (unknown [IPv6:2404:130:0:1000:222:4dff:fe88:a586])
	(Authenticated sender: mark.kirkwood)
	by mail.catalyst.net.nz (Postfix) with ESMTPSA id 4BB983301F
	for <ceph-devel@vger.kernel.org>; Fri,  5 Jul 2013 15:36:52 +1200 (NZST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

I have a 4 osd system (4 hosts, 1 osd per host), in two (imagined) racks 
(osd 0 and 1 in rack 0, osd 2 and 3 in rack1). All pools have number of 
replicas = 2. I have a crush rule that puts one pg copy on each rack 
(see notes) - but is essentially:

         step take root
         step chooseleaf firstn 0 type rack
         step emit

I created a pool (called obj) with 200 pgs, and created 100 objects each 
of size 20MB.

I simulate a rack failure by stopping ceph on the hosts in one rack. I 
*expected* that the system would continue to run in 50% degraded mode, 
as we would not place replicas on/in the same rack. Indeed initially I see:

2013-07-04 16:38:36.403975 mon.0 [INF] pgmap v760: 1160 pgs: 3 peering, 
1157 active+degraded; 2000 MB data, 6488 MB used, 3075 MB / 10075 MB 
avail; 100/200 degraded (50.000%)

However what I see is (after a while) is:

2013-07-04 16:39:07.071987 mon.0 [INF] pgmap v775: 1160 pgs: 308 
active+remapped, 852 active+degraded; 2000 MB data, 6934 MB used, 2629 
MB / 10075 MB avail; 78/200 degraded (39.000%)

Hmm - sure enough if I dump the pg map for each object in the pool, most 
look like:

osdmap e55 pool 'obj' (3) object 'smallnode0.dat' -> pg 3.c85a49e4 
(3.64) -> up [1] acting [1]

but some are like:

osdmap e55 pool 'obj' (3) object 'smallnode5.dat' -> pg 3.9b37ca18 
(3.18) -> up [1] acting [1,0]


Clearly I have misunderstood something here! How am I getting replicas 
on osd.0 and osd.1, when they are in the same rack?


Notes:

The version

ceph version 0.56.6 (95a0bda7f007a33b0dc7adf4b330778fa1e5d70c)
on Ubuntu 12.04 (KVM guest).

The osd tree

# id    weight  type name       up/down reweight
-7      4       root root
-5      2               rack rack0
-1      1                       host ceph1
0       1                               osd.0   up      1
-2      1                       host ceph2
1       1                               osd.1   up      1
-6      2               rack rack1
-3      1                       host ceph3
2       1                               osd.2   down    0
-4      1                       host ceph4
3       1                               osd.3   down    0

The crushmap

# begin crush map

# devices
device 0 osd.0
device 1 osd.1
device 2 osd.2
device 3 osd.3

# types
type 0 device
type 1 host
type 2 rack
type 3 root

# buckets
host ceph1 {
         id -1           # do not change unnecessarily
         # weight 1.000
         alg straw
         hash 0  # rjenkins1
         item osd.0 weight 1.000
}
host ceph2 {
         id -2           # do not change unnecessarily
         # weight 1.000
         alg straw
         hash 0  # rjenkins1
         item osd.1 weight 1.000
}
host ceph3 {
         id -3           # do not change unnecessarily
         # weight 1.000
         alg straw
         hash 0  # rjenkins1
         item osd.2 weight 1.000
}
host ceph4 {
         id -4           # do not change unnecessarily
         # weight 1.000
         alg straw
         hash 0  # rjenkins1
         item osd.3 weight 1.000
}
rack rack0 {
         id -5           # do not change unnecessarily
         # weight 2.000
         alg straw
         hash 0  # rjenkins1
         item ceph1 weight 1.000
         item ceph2 weight 1.000
}
rack rack1 {
         id -6           # do not change unnecessarily
         # weight 2.000
         alg straw
         hash 0  # rjenkins1
         item ceph3 weight 1.000
         item ceph4 weight 1.000
}
root root {
         id -7           # do not change unnecessarily
         # weight 4.000
         alg straw
         hash 0  # rjenkins1
         item rack0 weight 2.000
         item rack1 weight 2.000
}

# rules
rule data {
         ruleset 0
         type replicated
         min_size 1
         max_size 10
         step take root
         step chooseleaf firstn 0 type rack
         step emit
}
rule metadata {
         ruleset 1
         type replicated
         min_size 1
         max_size 10
         step take root
         step chooseleaf firstn 0 type rack
         step emit
}
rule rbd {
         ruleset 2
         type replicated
         min_size 1
         max_size 10
         step take root
         step chooseleaf firstn 0 type rack
         step emit
}

# end crush map


The pg map with all 4 osd up:

osdmap e39 pool 'obj' (3) object 'smallnode0.dat' -> pg 3.c85a49e4 
(3.64) -> up [1,2] acting [1,2]
osdmap e39 pool 'obj' (3) object 'smallnode1.dat' -> pg 3.da72a8fd 
(3.7d) -> up [2,1] acting [2,1]
osdmap e39 pool 'obj' (3) object 'smallnode2.dat' -> pg 3.5309389d 
(3.9d) -> up [0,2] acting [0,2]
osdmap e39 pool 'obj' (3) object 'smallnode3.dat' -> pg 3.2fa9d2c8 
(3.48) -> up [1,3] acting [1,3]
osdmap e39 pool 'obj' (3) object 'smallnode4.dat' -> pg 3.e29c0d42 
(3.42) -> up [1,2] acting [1,2]
osdmap e39 pool 'obj' (3) object 'smallnode5.dat' -> pg 3.9b37ca18 
(3.18) -> up [3,0] acting [3,0]
osdmap e39 pool 'obj' (3) object 'smallnode6.dat' -> pg 3.4c1a3bc0 
(3.c0) -> up [0,3] acting [0,3]
osdmap e39 pool 'obj' (3) object 'smallnode7.dat' -> pg 3.e260b675 
(3.75) -> up [0,2] acting [0,2]
osdmap e39 pool 'obj' (3) object 'smallnode8.dat' -> pg 3.b05e3892 
(3.92) -> up [3,0] acting [3,0]
...

The pg map with 2 osd (1 rack) up:

osdmap e55 pool 'obj' (3) object 'smallnode0.dat' -> pg 3.c85a49e4 
(3.64) -> up [1] acting [1]
osdmap e55 pool 'obj' (3) object 'smallnode1.dat' -> pg 3.da72a8fd 
(3.7d) -> up [1] acting [1]
osdmap e55 pool 'obj' (3) object 'smallnode2.dat' -> pg 3.5309389d 
(3.9d) -> up [0] acting [0]
osdmap e55 pool 'obj' (3) object 'smallnode3.dat' -> pg 3.2fa9d2c8 
(3.48) -> up [1] acting [1]
osdmap e55 pool 'obj' (3) object 'smallnode4.dat' -> pg 3.e29c0d42 
(3.42) -> up [1] acting [1]
osdmap e55 pool 'obj' (3) object 'smallnode5.dat' -> pg 3.9b37ca18 
(3.18) -> up [1] acting [1,0]
osdmap e55 pool 'obj' (3) object 'smallnode6.dat' -> pg 3.4c1a3bc0 
(3.c0) -> up [0] acting [0]
osdmap e55 pool 'obj' (3) object 'smallnode7.dat' -> pg 3.e260b675 
(3.75) -> up [0] acting [0]
osdmap e55 pool 'obj' (3) object 'smallnode8.dat' -> pg 3.b05e3892 
(3.92) -> up [1] acting [1,0]
...

Cheers

Mark
