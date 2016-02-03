From: Gaurav Bafna <bafnag@gmail.com>
Subject: Reason of Recovery Work Queue not being a priority queue
Date: Wed, 3 Feb 2016 14:14:44 +0530
Message-ID: <CAPg135YuCk3my-O0Bb_jT1enKPoAhvP21Uqz2AgpvkvNH==mDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:34067 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752968AbcBCIop (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Feb 2016 03:44:45 -0500
Received: by mail-wm0-f53.google.com with SMTP id 128so154107381wmz.1
        for <ceph-devel@vger.kernel.org>; Wed, 03 Feb 2016 00:44:44 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi Cephers,

I am going through OSD Code flow. I noticed that the work queue for
normal read write operations is Prioritized Queue (op_shardedwq in
OSD.h), whereas the recovery work queue is FIFO with respect to PGs .
The PG which was first discovered to be "need to be recovered"  will
be recovered first. There might be a PG which has more recovery work
to do , but was last in the queue. So in that case, it will lead to a
higher recovery time.

I think it is FIFO assuming that the PG which needs more recovery ,
must have lost many OSDs and should be well ahead in the queue.

Should we have a recovery queue implemented as priority queue for the PGs ?

Please let me know whether I am right or there is some problem in my
understanding.


-- 
Gaurav Bafna
9540631400
