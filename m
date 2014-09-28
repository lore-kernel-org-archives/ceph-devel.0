From: Dong Yuan <yuandong1222@gmail.com>
Subject: Latency Improvement Report for ShardedOpWQ
Date: Sun, 28 Sep 2014 11:45:14 +0800
Message-ID: <CAMm-wcKSiQHJW5y_mg5S3t17sY902TnG2G=b5Xen6W9Raa-1aQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f169.google.com ([74.125.82.169]:49105 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752262AbaI1DpP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 27 Sep 2014 23:45:15 -0400
Received: by mail-we0-f169.google.com with SMTP id k48so11402279wev.0
        for <ceph-devel@vger.kernel.org>; Sat, 27 Sep 2014 20:45:14 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

===== Test Purpose =====

Measure whether and how much Sharded OpWQ is better than Traditional
OpWQ for random write scene.

===== Test Case =====

4K Object WriteFull for 1w times.

===== Test Method =====

Put the following static probes into codes when running tests to get
the time span between enqeueue and dequeue of OpWQ.

Start: PG::enqueue_op before osd->op_wq.equeue call
End: OSD::dequeue_op.entry

===== Test Result =====

Traditional OpWQ: 109us(AVG), 40us(MIN)
ShardedOpWQ: 97us(AVG), 32us(MIN)

===== Test Conclusion =====

No Remarkably Improvement for Latency


-- 
Dong Yuan
Email:yuandong1222@gmail.com
