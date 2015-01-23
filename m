From: Sage Weil <sweil@redhat.com>
Subject: idempotent op (esp delete)
Date: Fri, 23 Jan 2015 13:43:47 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1501231327570.10173@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55253 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750966AbbAWVnt (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 23 Jan 2015 16:43:49 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t0NLhmE0031403
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <ceph-devel@vger.kernel.org>; Fri, 23 Jan 2015 16:43:48 -0500
Received: from redhat.com (ovpn-112-43.phx2.redhat.com [10.3.112.43])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t0NLhl27027948
	for <ceph-devel@vger.kernel.org>; Fri, 23 Jan 2015 16:43:48 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Background:

1) Way back when we made a task that would thrash the cache modes by 
adding and removing the cache tier while ceph_test_rados was running.  
This mostly worked, but would occasionally fail because we would

 - delete an object from the cache tier
 - a network failure injection would lose the reply
 - we'd disable the cache
 - the delete would resend to the base tier, not get recognized as a dup 
(different pool, different pg log)
   -> -ENOENT instead of 0

2) The proxy write code hits a similar problem:

 - delete gets proxied
 - we initiate async promote
 - a network failure injection loses the delete reply
 - delete resends and blocks on promote (or arrives after it finishes)
 - promote finishes
 - delete is handled
  -> -ENOENT instead of 0

The ticket is http://tracker.ceph.com/issues/8935

The problem is partially addressed by

	https://github.com/ceph/ceph/pull/3447

by logging a few request ids on every object_info_t and preserving that on 
promote and flush.

However, it doesn't solve the problem for delete because we 
throw out object_info_t so that reqid_t is lost.

I think we have two options, not necessarily mutually exclusive:

1) When promoting an object that doesn't exist (to create a whiteout), 
pull reqids out of the base tier's pg log so that the whiteout is primed 
with request ids.

1.5) When flushing... well, that is harder because we have nowhere to put 
the reqids.  Unless we make a way to cram a list of reqid's into a single 
PG log entry...?  In that case, we wouldn't strictly need the per-object 
list since we could pile the base tier's reqids into the promote log entry 
in the cache tier.

2) Make delete idempotent (0 instead of ENOENT if the object doesn't 
exist).  This will require a delicate compat transition (let's ignore that 
a moment) but you can preserve the old behavior for callers that care by 
preceding the delete with an assert_exists op.  Most callers don't care, 
but a handful do.  This simplifies the semantics we need to support going 
forward.

Of course, it's all a bit delicate.  The idempotent op semantics have a 
time horizon so it's all a bit wishy-washy... :/

Thoughts?
sage


