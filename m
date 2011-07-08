From: Meng Zhao <mzhao@carbonite.cn>
Subject: Replacing a failed disk/OSD: unfound object
Date: Fri, 08 Jul 2011 16:23:34 +0800
Message-ID: <739109542484ec419c72b1a0f941a54d@carbonite.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from [218.240.156.147] ([218.240.156.147]:40498 "EHLO
	mail.carbonite.cn" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1753527Ab1GHIdR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Jul 2011 04:33:17 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph devel <ceph-devel@vger.kernel.org>


Hi,

I was trying to replace a disk for an osd by following instruction at: 
http://ceph.newdream.net/wiki/Replacing_a_failed_disk/OSD

Now, ceph -w getting
2011-07-08 15:52:39.702881    pg v1602: 602 pgs: 49 active+degraded, 
553 active+clean+degraded; 349 MB data, 333 MB used, 566 MB / 1023 MB 
avail; 167/224 degraded (74.554%); 55/112 unfound (49.107%)

and a copy operation hang on the ceph client forever. I cannot kill 
(-9) the cp process. Is there any hope to recover my ceph filesystem?

My general question is: How are objects distributed among OSDs? Does 
duplication (2x) guarantee that a failure of a single OSD would not lose 
data?  It appears to me that the objects are statistically redistributed 
and does not guarantee physical separation of replication data location.

Thanks!

