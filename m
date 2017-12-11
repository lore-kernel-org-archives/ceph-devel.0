From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: cephfs quotas
Date: Mon, 11 Dec 2017 10:36:20 -0800
Message-ID: <CAJ4mKGaa=H9PJbreJGq5a6t8NtFQ4B+5F7fvrz9mg8D0BD7Kzg@mail.gmail.com>
References: <20171018101122.pfz7e27l32e34b2f@jf_suse_laptop> <87d13lryvd.fsf@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f47.google.com ([209.85.214.47]:35188 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751705AbdLKSgV (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Dec 2017 13:36:21 -0500
Received: by mail-it0-f47.google.com with SMTP id f143so18144991itb.0
        for <ceph-devel@vger.kernel.org>; Mon, 11 Dec 2017 10:36:21 -0800 (PST)
In-Reply-To: <87d13lryvd.fsf@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Luis Henriques <lhenriques@suse.com>
Cc: Jan Fajerski <jfajerski@suse.com>, Sage Weil <sweil@redhat.com>, John Spray <jspray@redhat.com>, Patrick Donnelly <pdonnell@redhat.com>, "Yan, Zheng" <zyan@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Dec 11, 2017 at 8:52 AM, Luis Henriques <lhenriques@suse.com> wrote:
> Hi,
>
> [ and sorry for hijacking this old thread! ]
>
> Here's a write-up of what I was saying earlier on the cephfs standup:
>
> Basically, by using the ceph branch wip-cephfs-quota-realm branch[1] the
> kernel client should have everything needed to implement client-side
> enforced quotas (just like the current fuse client).  That branch
> contains code that will create a new realm whenever a client sets a
> quota xattr, and the clients will be updated with this new realm.
>
> My first question would be: is there something on the kernel client to
> handle this realms (a snaprealm) that is still missing?  As far as I
> could understand from reading the code there's nothing missing -- it
> should be possible to walk through the realms hierarchy as the kernel
> client will always get the updated realms hierarchy from the MDS -- both
> for snapshots and for this new 'quota realms'.  Implementing a 'quota
> realms' PoC based on the RFC I sent out a few weeks ago shouldn't take
> too long.  Or is there something obvious that I'm missing?

So with that branch, the MDS is maintaining quota realms and sending
out the realm info to the clients. But unless there's a kernel branch
somewhere else, the kernel client doesn't know how to do anything with
those for quotas. So all of that code needs to be written.
But reading your second question, you may here be asking some other
question I don't understand...?

> Now, the 2nd (big!) question is how to proceed.  Or, to be more clear,
> what are the expectations :-) My understanding was that John Spray would
> like to see a client-side quota enforcement as an initial step, and then
> have everything else added on top of it.  But I'm afraid that this would
> introduce complexity for future releases -- for example, if in the
> future we have a cluster-side enforced quotas (voucher-based or other),
> I guess that the kernel clients would be require to support both
> scenarios => maintenance burden.  Not to talk about clusters migration
> from different quotas implementations.

Any quota system we might implement server-side will be well-served by
having the clients do checks voluntarily as well. I don't think a
voluntary client-side system is going to look much different than just
doing the checks to avoid sending off writes we know the servers will
reject.

More to the point, we have a working model for client-side enforcement
of quotas, and we *don't* have one for server-side enforcement yet.
Don't make the perfect the enemy of the good. :)
-Greg

>
> My personal preference would be to stay away from client quotas.  That's
> obviously the best short-term solution but not necessarily the best in
> the long run.
>
> Thoughts?
>
> [1] https://github.com/ukernel/ceph/tree/wip-cephfs-quota-realm
>
> Cheers,
> --
> Luis
>
> Jan Fajerski <jfajerski@suse.com> writes:
>
>> Hi list,
>> A while ago this list saw a little discussion about quota support for the cephfs
>> kernel client. The result was that instead of adding kernel support for the
>> current implementation, a new quota implementation would be the preferred
>> solution. Here we would like to propose such an implementation.
>>
>> The objective is to implement quotas such that the implementation scales well,
>> it can be implemented in ceph-fuse, the kernel client and libcephfs based
>> clients and are enforceable without relying on client cooperation. The latter
>> suggests that ceph daemon(s) must be involved in checking quota limits. We think
>> that an approach as described in "Quota Enforcement for High-Performance
>> Distributed Storage Systems" by Pollack et
>> al. (https://www.ssrc.ucsc.edu/pub/pollack07-msst.html) can provide a good
>> blueprint for such an implementation. This approach enforces quota limits with
>> the help of vouchers. At a very high level this system works by one or more
>> quota servers (in our case MDSs) issuing vouchers carrying (among other things)
>> an expiration timestamp, an amount, a uid and a (cryptographic) signature to
>> clients. An MDS can track how much space it has given out by tracking the
>> vouchers it issues. A client can spend these vouchers on OSDs by sending them
>> along with a write request. The OSD can verify a valid voucher by the
>> signature. It will deduct the amount of written data from the voucher and might
>> return the voucher if the voucher was not used up in full.  The client can
>> return the remaining amount or it can give it back to the MDS.  Client failures
>> and misbehaving clients are handled through a periodical reconciliation phase
>> where the MDSs and OSDs reconciles issued and used vouchers. Vouchers held by a
>> failed client can be detected by the expiration timestamp attached to the
>> vouchers. Any unused and invalid vouchers can be reclaimed by an MDS. Clients
>> that try to cheat by spending the same voucher on multiple OSDs are detected by
>> the uid of the voucher. This means that adversarial clients can exceed the
>> quota, but will be caught within a limited time period. The signature ensure
>> that clients can not fabricate valid vouchers.  For a much better and much more
>> detailed description please refer to the paper.
>>
>> This approach has been implemented in Ceph before as described here
>> http://drona.csa.iisc.ernet.in/~gopi/docs/amarnath-MSc.pdf. We could however not
>> find the source code for this and it seemingly didn't find its way in to the
>> current code base.
>> The virtues of a protocol like this are that it can scale well, since there is
>> no central entity that keeps a global state of the quotas, while still being
>> able to enforce (somewhat) hard quotas.
>> On the downside there is a protocol overhead that impacts performance. Research
>> and reports on implementations suggest that this overhead can be kept fairly
>> small though (2% performance penalty or less). Furthermore additional state must
>> be kept on MDSs, OSDs and clients. Such a solution also adds considerable
>> complexity to all involved components.
>>
>> We'd like to hear criticism and comments from the community, before a more
>> in-depth CDM discussion.
>>
>> Best,
>> Luis and Jan
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
