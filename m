From: John Spray <jspray@redhat.com>
Subject: Re: quota change restriction
Date: Tue, 21 Feb 2017 12:52:34 +0000
Message-ID: <CALe9h7cxUxe6Aheho_cEWyAUALPsmbcZdidDyYjO5y41wCgf4Q@mail.gmail.com>
References: <461205975.109214419.1487599948474.JavaMail.zimbra@redhat.com>
 <1228164616.109276923.1487608022780.JavaMail.zimbra@redhat.com>
 <CALe9h7dmU3c10rSnD-Ux4dB3bFXYko6uvcw1f8-RrJ=7f5NKWg@mail.gmail.com> <CAJ4mKGbeZapFaygONBmMyguz-Q0h8Wj3=0xkn55UYV4WJ4Tm2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f171.google.com ([209.85.128.171]:35463 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752117AbdBUMw4 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Feb 2017 07:52:56 -0500
Received: by mail-wr0-f171.google.com with SMTP id s27so34598936wrb.2
        for <ceph-devel@vger.kernel.org>; Tue, 21 Feb 2017 04:52:56 -0800 (PST)
In-Reply-To: <CAJ4mKGbeZapFaygONBmMyguz-Q0h8Wj3=0xkn55UYV4WJ4Tm2g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Ramana Raja <rraja@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Feb 20, 2017 at 5:13 PM, Gregory Farnum <gfarnum@redhat.com> wrote:
> On Mon, Feb 20, 2017 at 8:43 AM, John Spray <jspray@redhat.com> wrote:
>> (taking to ceph-devel)
>>
>> On Mon, Feb 20, 2017 at 4:27 PM, Ramana Raja <rraja@redhat.com> wrote:
>>> Would it be possible or make sense to disallow clients having
>>> path restricted caps (OpenStack clients) from modifying quota
>>> (change share size) of the root of the exported subtree (manila share)?
>>>
>>> Currently, an OpenStack client can mount a share and modify
>>> its size, by modifying the quota xattr value at the mount point,
>>> without Manila service knowing about the size change.
>>
>> Right, I think this came up before at some point.  I think I didn't
>> think hard about it because it wouldn't be an issue so much with NFS
>> clients, but we should at least decide what direction we want to go
>> in.
>>
>> We had kind of the same issue with layouts, which is why the 'p' part
>> of 'allow rwp' MDS auth caps was introduced.  A few options spring to
>> mind:
>>  A) Apply the 'p' flag rules quotas as well as layouts: generalise it
>> into a "this is a client that isn't allowed to modify the special
>> ceph.* attrs".  Is this too Manila-specific?  Not sure.
>>  B) Special case the client's mount root, and never let it modify the
>> quotas on its own root.  This is probably reasonable in practice as I
>> would expect someone to only be mounting a subpath at the point they
>> had configured their quotas elsewhere, but it seems like quite a
>> quirky move.
>>  C) Introduce another flag to the mds auth caps that controls ability
>> to set quota.  Downside: additional complexity in the auth caps.
>>  D) Do nothing
>>
>> Anyone have other thoughts on this, and/or a preference from those
>> options?  I'm leaning towards A but just because I can't readily
>> imagine use cases where you want to permit layout changes but ban
>> quotas, doesn't mean they don't exist.
>
> I like A but it does restrict the ability of tenants to have a "tenant
> admin" restricting the size of certain of their clients. Not sure if
> we care about that use case or not.

Yeah, it is a limitation.  I think for that type of use case I would
be suggesting to people that they grant the 'p' cap to their tenant,
and be clear that whatever is responsible for sharing resources
onwards to the sub-tenants (who might have individual quotas etc set)
is also responsible for preventing the sub-tenants messing with the
top-level quota.  The tenant in this instance could still modify their
own top-level quota, but I'm not too concerned about that given that
their obedience of the quotas is already voluntary.

John
