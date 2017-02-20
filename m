From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: quota change restriction
Date: Mon, 20 Feb 2017 09:13:39 -0800
Message-ID: <CAJ4mKGbeZapFaygONBmMyguz-Q0h8Wj3=0xkn55UYV4WJ4Tm2g@mail.gmail.com>
References: <461205975.109214419.1487599948474.JavaMail.zimbra@redhat.com>
 <1228164616.109276923.1487608022780.JavaMail.zimbra@redhat.com> <CALe9h7dmU3c10rSnD-Ux4dB3bFXYko6uvcw1f8-RrJ=7f5NKWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f178.google.com ([209.85.161.178]:36068 "EHLO
        mail-yw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753401AbdBTROV (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 20 Feb 2017 12:14:21 -0500
Received: by mail-yw0-f178.google.com with SMTP id v200so52760869ywc.3
        for <ceph-devel@vger.kernel.org>; Mon, 20 Feb 2017 09:13:41 -0800 (PST)
In-Reply-To: <CALe9h7dmU3c10rSnD-Ux4dB3bFXYko6uvcw1f8-RrJ=7f5NKWg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Ramana Raja <rraja@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Feb 20, 2017 at 8:43 AM, John Spray <jspray@redhat.com> wrote:
> (taking to ceph-devel)
>
> On Mon, Feb 20, 2017 at 4:27 PM, Ramana Raja <rraja@redhat.com> wrote:
>> Would it be possible or make sense to disallow clients having
>> path restricted caps (OpenStack clients) from modifying quota
>> (change share size) of the root of the exported subtree (manila share)?
>>
>> Currently, an OpenStack client can mount a share and modify
>> its size, by modifying the quota xattr value at the mount point,
>> without Manila service knowing about the size change.
>
> Right, I think this came up before at some point.  I think I didn't
> think hard about it because it wouldn't be an issue so much with NFS
> clients, but we should at least decide what direction we want to go
> in.
>
> We had kind of the same issue with layouts, which is why the 'p' part
> of 'allow rwp' MDS auth caps was introduced.  A few options spring to
> mind:
>  A) Apply the 'p' flag rules quotas as well as layouts: generalise it
> into a "this is a client that isn't allowed to modify the special
> ceph.* attrs".  Is this too Manila-specific?  Not sure.
>  B) Special case the client's mount root, and never let it modify the
> quotas on its own root.  This is probably reasonable in practice as I
> would expect someone to only be mounting a subpath at the point they
> had configured their quotas elsewhere, but it seems like quite a
> quirky move.
>  C) Introduce another flag to the mds auth caps that controls ability
> to set quota.  Downside: additional complexity in the auth caps.
>  D) Do nothing
>
> Anyone have other thoughts on this, and/or a preference from those
> options?  I'm leaning towards A but just because I can't readily
> imagine use cases where you want to permit layout changes but ban
> quotas, doesn't mean they don't exist.

I like A but it does restrict the ability of tenants to have a "tenant
admin" restricting the size of certain of their clients. Not sure if
we care about that use case or not.
-Greg
