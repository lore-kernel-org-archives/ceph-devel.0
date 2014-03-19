From: John Spray <john.spray@inktank.com>
Subject: Full OSD handling (CephFS and in general)
Date: Wed, 19 Mar 2014 14:14:54 +0000
Message-ID: <CAGd4Wr17Feoq6hbj0doyMi2hQ-3i1urGabN1k_qThfNgB9hpBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:64364 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965206AbaCSOOz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Mar 2014 10:14:55 -0400
Received: by mail-pa0-f43.google.com with SMTP id bj1so9018906pad.2
        for <ceph-devel@vger.kernel.org>; Wed, 19 Mar 2014 07:14:55 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Having found that our full space handling in CephFS wasn't working
right now[1], there was some discussion on the CephFS standup about
how to improve the free space handling in a more general way.

Currently (once #7780 is fixed), we just give the MDS a pass on all
the fullness checks, so that it can journal file deletions to free up
space.  This is a halfway solution because there are still ways for
the MDS to fill up the remaining space with operations other than
deletions, especially with the advent of inlining for small files.
It's also hacky, because there is code inside the OSD that special
cases writes from the MDS.

Changes discussed
===============

In the CephFS layer:
 * we probably need to do some work to blacklist client requests other
than housekeeping and deletions, when we are in a low-space situation.

In the RADOS layer:
 * Per-pool full flag: For situations where metadata+data pools are on
separate OSDs, a per-pool full flag (instead of the current global
one), so that we can distinguish between situations where we need to
be conservative with metadata operations (low space on metadata pool)
vs situations where only client data IO is blocked (low space on data
pool).  This seems fairly uncontroversial, as the current global full
flag doesn't reflect that different pools can be on entirely separate
storage.
 * Per-pool full ratio: For situations where metadata+data pools are
on the same OSDs, separate full ratios per pool, so that once the data
pool's threshold is reached, the remaining reserved space is given
over to the metadata pool (assuming metadata pool has a higher full
ratio, possibly just set to 100%).

Throwing it out to the list for thoughts.

Cheers,
John

1. http://tracker.ceph.com/issues/7780
