From: Luis Henriques <lhenriques@suse.com>
Subject: Re: cephfs quotas
Date: Tue, 12 Dec 2017 09:12:21 +0000
Message-ID: <87wp1sqphm.fsf@suse.com>
References: <20171018101122.pfz7e27l32e34b2f@jf_suse_laptop>
        <87d13lryvd.fsf@suse.com>
        <CAJ4mKGaa=H9PJbreJGq5a6t8NtFQ4B+5F7fvrz9mg8D0BD7Kzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:48039 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750955AbdLLJMY (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 12 Dec 2017 04:12:24 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Jan Fajerski <jfajerski@suse.com>, Sage Weil <sweil@redhat.com>, John Spray <jspray@redhat.com>, Patrick Donnelly <pdonnell@redhat.com>, "Yan, Zheng" <zyan@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

Gregory Farnum <gfarnum@redhat.com> writes:

> On Mon, Dec 11, 2017 at 8:52 AM, Luis Henriques <lhenriques@suse.com> wrote:
>> Hi,
>>
>> [ and sorry for hijacking this old thread! ]
>>
>> Here's a write-up of what I was saying earlier on the cephfs standup:
>>
>> Basically, by using the ceph branch wip-cephfs-quota-realm branch[1] the
>> kernel client should have everything needed to implement client-side
>> enforced quotas (just like the current fuse client).  That branch
>> contains code that will create a new realm whenever a client sets a
>> quota xattr, and the clients will be updated with this new realm.
>>
>> My first question would be: is there something on the kernel client to
>> handle this realms (a snaprealm) that is still missing?  As far as I
>> could understand from reading the code there's nothing missing -- it
>> should be possible to walk through the realms hierarchy as the kernel
>> client will always get the updated realms hierarchy from the MDS -- both
>> for snapshots and for this new 'quota realms'.  Implementing a 'quota
>> realms' PoC based on the RFC I sent out a few weeks ago shouldn't take
>> too long.  Or is there something obvious that I'm missing?
>
> So with that branch, the MDS is maintaining quota realms and sending
> out the realm info to the clients. But unless there's a kernel branch
> somewhere else, the kernel client doesn't know how to do anything with
> those for quotas. So all of that code needs to be written.

Oh, that's absolutely clear!  I know the kernel doesn't know anything
about quotas or quota realms.  And one of my priorities at this point is
to change that ;-)

I just asked this question because I was under the impression that
during the standup someone hinted that there was something else missing
in the kernel code regarding snaprealms (not quotas-specific).  Anyway,
sorry if I managed to confuse everyone.

> But reading your second question, you may here be asking some other
> question I don't understand...?
>
>> Now, the 2nd (big!) question is how to proceed.  Or, to be more clear,
>> what are the expectations :-) My understanding was that John Spray would
>> like to see a client-side quota enforcement as an initial step, and then
>> have everything else added on top of it.  But I'm afraid that this would
>> introduce complexity for future releases -- for example, if in the
>> future we have a cluster-side enforced quotas (voucher-based or other),
>> I guess that the kernel clients would be require to support both
>> scenarios => maintenance burden.  Not to talk about clusters migration
>> from different quotas implementations.
>
> Any quota system we might implement server-side will be well-served by
> having the clients do checks voluntarily as well. I don't think a
> voluntary client-side system is going to look much different than just
> doing the checks to avoid sending off writes we know the servers will
> reject.
>
> More to the point, we have a working model for client-side enforcement
> of quotas, and we *don't* have one for server-side enforcement yet.
> Don't make the perfect the enemy of the good. :)

Ok, gotcha.  I wanted to raise my concerns one last time and make sure
we're all on the same page.  I guess it's now time to go re-write those
old patches.  Thanks!

Cheers,
-- 
Luis
