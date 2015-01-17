From: David Zafman <dzafman@redhat.com>
Subject: Re: 'Immutable bit' on pools to prevent deletion
Date: Sat, 17 Jan 2015 15:28:59 -0800
Message-ID: <54BAF03B.2000400@redhat.com>
References: <54B7D2D6.4020503@42on.com> <m9chio$3lp$1@ger.gmane.org> <alpine.DEB.2.00.1501170822460.26676@cobra.newdream.net> <m9ec1p$kts$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51902 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751562AbbAQX3C (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 17 Jan 2015 18:29:02 -0500
In-Reply-To: <m9ec1p$kts$1@ger.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elsayed <eternaleye@gmail.com>, ceph-devel@vger.kernel.org


The most secure way would be one in which you can only create pools with 
WORM set and can't ever change the WORM state of a pool.  I like this 
simple/secure approach as a first cut.

David

On 1/17/15 11:09 AM, Alex Elsayed wrote:
> Sage Weil wrote:
>
>> On Fri, 16 Jan 2015, Alex Elsayed wrote:
>>> Wido den Hollander wrote:
>>>
>>> <snip>
>>>> Is it a sane thing to look at 'features' which pools could have? Other
>>>> features which might be set on a pool:
>>>>
>>>> - Read Only (all write operations return -EPERM)
>>>> - Delete Protected
>>> There's another pool feature I'd find very useful: a WORM flag, that
>>> permits only create & append (at the RADOS level, not the RBD level as
>>> was an Emperor blueprint).
>>>
>>> In particular, I'd _love_ being able to make something that takes
>>> Postgres WAL logs and puts them in such a pool, providing real guarantees
>>> re: consistency. Similarly, audit logs and such for compliance.
>> How would you want this to work?
>>
>> - If the bit is set, object creates are allowed, but not deletes?  What
>> about append?
>>
>> - Are you allowed to clear the bit with something like 'ceph osd pool set
>> <pool> worm false' ?
> I'd say that a WORM pool would allow 'create' and 'append' only - that fits
> well with the classic notions of WORM media, and would allow natural
> implementations of virtualized WORM tape libraries and such for people who
> need compatibility (if only object creation was supported, you get issues
> where either you have absurd tiny objects or risk data loss on failure to
> write a larger buffered chunk). Similarly, audit records (like selinux logs,
> that might be written by log daemons) don't really come in nice object-sized
> chunks. You want to always have the newest in the archive, so you really
> don't want to buffer up to that.
>
> I'd also figure that WORM's main purpose is assurance/compliance - you want
> to _know_ that nobody could have turned the bit off, futzed with the data,
> and then turned it back on. Otherwise, you'd just write your clients to only
> use create/append, and have no need for WORM at the pool level. Because of
> that, if the flag can be cleared via commands, it should be possible for the
> admins to forbid it (by flat denying it in config, via some keying system,
> via the bits being a ratchet, whatever - I'm not especially concerned by how
> the guarantee is provided, so long as it can be).
>
> Setting it should probably also be privileged, since it'd be trivial to
> cause a DOS by setting it on (say) a CephFS pool - although handling that
> concern is likely out-of-scope for now, since there are easier ways to ruin
> someone's day at the RADOS level.
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

