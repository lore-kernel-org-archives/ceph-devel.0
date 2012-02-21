From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: rbd benchmark details
Date: Tue, 21 Feb 2012 12:25:33 -0800
Message-ID: <AE277795-A081-4CCA-9816-E5BA717A6946@cs.ucsc.edu>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-01.cse.ucsc.edu ([128.114.48.32]:44887 "EHLO
	mail-01.cse.ucsc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752148Ab2BUUZe convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Feb 2012 15:25:34 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Adam Manzanares <nmtadam@gmail.com>

Hi, we are trying to track down a performance problem with rados that is leading no where.

We are using 23 OSDs. Running "ceph osd tell <osd> bench" we are seeing decent performance on each osd.

However, running "rados -p rbd bench 120 write -t 1" from a client we only see around 10 MBs. We can increase the number of threads from 1 to 10 and see an increase in 10 MB/s for each new thread up until the network bottlenecks us around 100 MB/s.

None of the micro benchmarks showed throughput less than 30 MB/s, so we are a bit at a loss for tracking down this performance issue.

Any suggestions?

Thanks,
-Noah