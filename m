From: Alex Elsayed <eternaleye@gmail.com>
Subject: Re: 'Immutable bit' on pools to prevent deletion
Date: Sat, 17 Jan 2015 11:09:42 -0800
Message-ID: <m9ec1p$kts$1@ger.gmane.org>
References: <54B7D2D6.4020503@42on.com> <m9chio$3lp$1@ger.gmane.org> <alpine.DEB.2.00.1501170822460.26676@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:53659 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751348AbbAQTJ6 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 17 Jan 2015 14:09:58 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1YCYkq-00006p-Tj
	for ceph-devel@vger.kernel.org; Sat, 17 Jan 2015 20:09:53 +0100
Received: from 66-87-139-239.pools.spcsdns.net ([66.87.139.239])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Sat, 17 Jan 2015 20:09:52 +0100
Received: from eternaleye by 66-87-139-239.pools.spcsdns.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Sat, 17 Jan 2015 20:09:52 +0100
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Sage Weil wrote:

> On Fri, 16 Jan 2015, Alex Elsayed wrote:
>> Wido den Hollander wrote:
>> 
>> <snip>
>> > Is it a sane thing to look at 'features' which pools could have? Other
>> > features which might be set on a pool:
>> > 
>> > - Read Only (all write operations return -EPERM)
>> > - Delete Protected
>> 
>> There's another pool feature I'd find very useful: a WORM flag, that
>> permits only create & append (at the RADOS level, not the RBD level as
>> was an Emperor blueprint).
>> 
>> In particular, I'd _love_ being able to make something that takes
>> Postgres WAL logs and puts them in such a pool, providing real guarantees
>> re: consistency. Similarly, audit logs and such for compliance.
> 
> How would you want this to work?
> 
> - If the bit is set, object creates are allowed, but not deletes?  What
> about append?
> 
> - Are you allowed to clear the bit with something like 'ceph osd pool set
> <pool> worm false' ?

I'd say that a WORM pool would allow 'create' and 'append' only - that fits 
well with the classic notions of WORM media, and would allow natural 
implementations of virtualized WORM tape libraries and such for people who 
need compatibility (if only object creation was supported, you get issues 
where either you have absurd tiny objects or risk data loss on failure to 
write a larger buffered chunk). Similarly, audit records (like selinux logs, 
that might be written by log daemons) don't really come in nice object-sized 
chunks. You want to always have the newest in the archive, so you really 
don't want to buffer up to that.

I'd also figure that WORM's main purpose is assurance/compliance - you want 
to _know_ that nobody could have turned the bit off, futzed with the data, 
and then turned it back on. Otherwise, you'd just write your clients to only 
use create/append, and have no need for WORM at the pool level. Because of 
that, if the flag can be cleared via commands, it should be possible for the 
admins to forbid it (by flat denying it in config, via some keying system, 
via the bits being a ratchet, whatever - I'm not especially concerned by how 
the guarantee is provided, so long as it can be).

Setting it should probably also be privileged, since it'd be trivial to 
cause a DOS by setting it on (say) a CephFS pool - although handling that 
concern is likely out-of-scope for now, since there are easier ways to ruin 
someone's day at the RADOS level.


