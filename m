From: Guang Yang <yguang11@outlook.com>
Subject: Changes of scrubbing?
Date: Wed, 21 May 2014 09:44:37 +0800
Message-ID: <BLU436-SMTP155ED6E6FBB4FD0E72FC5CDF3C0@phx.gbl>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from blu0-omc4-s37.blu0.hotmail.com ([65.55.111.176]:8670 "EHLO
	blu0-omc4-s37.blu0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750952AbaEUBoq convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 20 May 2014 21:44:46 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph-devel <ceph-devel@vger.kernel.org>

Hi ceph-devel,
Like some users of Ceph, we are using Ceph for a latency sensitive project, and scrubbing (especially deep-scrubbing) impacts the SLA in a non-trivial way, as commodity hardware could fail in one way or the other, I think it is essential to have scrubbing enabled to preserve data durability.

Inspired by how erasure coding backend implement scrubbing[1], I am wondering if the following changes is valid to somehow reduce the performance impact from scrubbing:
 1. Store the CRC checksum along with each physical copy of the object on filesystem (via xattr or omap?)
 2. For read request, it checks the CRC locally and if it mismatch, redirect the request to a replica and mark the PG as inconsistent.

This is just a general idea and details (like append) will need to further discussed.

By having such, we can schedule the scrubbing less aggresively but still preserve the durability for read.

Does this make some sense?

[1] http://ceph.com/docs/master/dev/osd_internals/erasure_coding/pgbackend/ 

Thanks,
Guang Yang