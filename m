From: Mark Nelson <mnelson@redhat.com>
Subject: RBD client wallclock profile during 4k random writes
Date: Wed, 10 May 2017 17:10:28 -0500
Message-ID: <9e13c0f0-cde1-b8ec-d469-da5d87c5ba74@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:4583 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751069AbdEJWKa (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 10 May 2017 18:10:30 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C9F84A08FB
        for <ceph-devel@vger.kernel.org>; Wed, 10 May 2017 22:10:29 +0000 (UTC)
Received: from [10.3.116.91] (ovpn-116-91.phx2.redhat.com [10.3.116.91])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9BB7C78497
        for <ceph-devel@vger.kernel.org>; Wed, 10 May 2017 22:10:29 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Ugh, trying this one more time. :(

I didn't see the original version of this message go out to ceph-devel 
(possibly due to the attachment).  I'll use pastebin instead:

https://pastebin.com/6txSkM7r

While debugging a bluestore issue I grabbed a wall-clock profile of a 
client fio process while doing 4k random writes.  This likely is not 
associated with the other issues I'm trying to track down, but I wanted 
to share since there's some locking going on that might be worth looking 
at.  FWIW, this is a single client issuing 32 concurrent IOs to a 3x rep 
pool on a cluster with 16 OSDs on NVMe.  The NVMe drives are nowhere 
near saturated and the OSDs are semi-idle waiting for work.  Top was 
showing the fio process using about 300-320% CPU while the profiler 
wasn't running and fio was doing somewhere around 14-15k IOPS.

1) 7 - tp_librbd, line 82

Lots of stuff going on here, but the big thing is all the time spent in 
librbd::ImageCtx::write_to_cache.  70.2% of the total time in this 
thread is spent in ObjectCacher::writex with lots of nested stuff, but 
if you look all the way down on line 1293, another 11.8% of the time is 
spent in Locker() and 1.5% of the time spent in ~Locker().

Of note is that ~12% of the time in this thread was spent in 
Objecter::_calc_target.  A bit less than half of that was crush.

2) 8 - fn-radosclient, line 1641

This thread is spending about half it's time in Context::complete, and 
half it's time just waiting around.  On line 1651 in 
librbd::C_OrderedWrite::finish, we see a whopping 33.60% of the samples 
spent in Locker doing Mutex::Lock.  On line 1819, 3.15% spent in ~Locker 
doing Mutex::Unlock.

Otherwise we see some of the usual suspects sprinkled around. bufferlist 
appends, encode/decode, fast_dispatch, etc.

Mark


