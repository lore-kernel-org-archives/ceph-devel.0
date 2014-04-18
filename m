From: Dyweni - Ceph-Devel <YS3fpFE2ykfB@dyweni.com>
Subject: Documentation Discrepancy - Manual Configuration
Date: Fri, 18 Apr 2014 02:10:37 -0500
Message-ID: <6b1a50710afdfd0b10133934be7eac38@pl1.haspere.com>
Reply-To: YS3fpFE2ykfB@dyweni.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from pl1.haspere.com ([209.177.156.123]:41554 "EHLO pl1.haspere.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750987AbaDRHKi (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 18 Apr 2014 03:10:38 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

Testing Ceph with 0.79.

1 Monitor
2 OSDs


Following the instructions here 
(http://ceph.com/docs/master/install/manual-deployment/)... I arrive at 
this state:

------
     cluster e3e1a87b-d282-41b5-b4ad-fb3f969e164f
      health HEALTH_WARN 192 pgs degraded; 192 pgs stuck unclean
      monmap e1: 1 mons at {a=10.208.39.100:6789/0}, election epoch 1, 
quorum 0 a
      osdmap e16: 2 osds: 2 up, 2 in
       pgmap v21: 192 pgs, 3 pools, 0 bytes data, 0 objects
             2004 MB used, 59381 MB / 65536 MB avail
                  192 active+degraded
------

'ceph osd dump' shows this:
------
...
pool 0 'data' replicated size 3 min_size 2 ...
pool 1 'metadata' replicated size 3 min_size 2 ...
pool 2 'rbd' replicated size 3 min_size 2 ...
...
------



It's not until I add a third OSD, or reduce the size of the pools, does 
the 192 pgs become unstuck and migrate towards active+clean.



I think the documentation should indicate that three nodes are required 
for Ceph to become optimal.



-- 
Thanks,
Dyweni
