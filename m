From: John Spray <jspray@redhat.com>
Subject: Re: quota change restriction
Date: Mon, 20 Feb 2017 16:43:16 +0000
Message-ID: <CALe9h7dmU3c10rSnD-Ux4dB3bFXYko6uvcw1f8-RrJ=7f5NKWg@mail.gmail.com>
References: <461205975.109214419.1487599948474.JavaMail.zimbra@redhat.com> <1228164616.109276923.1487608022780.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:37241 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752118AbdBTQni (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 20 Feb 2017 11:43:38 -0500
Received: by mail-wm0-f41.google.com with SMTP id v77so57229932wmv.0
        for <ceph-devel@vger.kernel.org>; Mon, 20 Feb 2017 08:43:37 -0800 (PST)
In-Reply-To: <1228164616.109276923.1487608022780.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ramana Raja <rraja@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

(taking to ceph-devel)

On Mon, Feb 20, 2017 at 4:27 PM, Ramana Raja <rraja@redhat.com> wrote:
> Would it be possible or make sense to disallow clients having
> path restricted caps (OpenStack clients) from modifying quota
> (change share size) of the root of the exported subtree (manila share)?
>
> Currently, an OpenStack client can mount a share and modify
> its size, by modifying the quota xattr value at the mount point,
> without Manila service knowing about the size change.

Right, I think this came up before at some point.  I think I didn't
think hard about it because it wouldn't be an issue so much with NFS
clients, but we should at least decide what direction we want to go
in.

We had kind of the same issue with layouts, which is why the 'p' part
of 'allow rwp' MDS auth caps was introduced.  A few options spring to
mind:
 A) Apply the 'p' flag rules quotas as well as layouts: generalise it
into a "this is a client that isn't allowed to modify the special
ceph.* attrs".  Is this too Manila-specific?  Not sure.
 B) Special case the client's mount root, and never let it modify the
quotas on its own root.  This is probably reasonable in practice as I
would expect someone to only be mounting a subpath at the point they
had configured their quotas elsewhere, but it seems like quite a
quirky move.
 C) Introduce another flag to the mds auth caps that controls ability
to set quota.  Downside: additional complexity in the auth caps.
 D) Do nothing

Anyone have other thoughts on this, and/or a preference from those
options?  I'm leaning towards A but just because I can't readily
imagine use cases where you want to permit layout changes but ban
quotas, doesn't mean they don't exist.

John
