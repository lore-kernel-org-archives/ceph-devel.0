From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: client-facing feature bits and pending kernel changes
Date: Fri, 29 Jan 2016 18:07:37 +0100
Message-ID: <CAOi1vP-bPxcLnnekTjM1rQfBEH_MR6Ey-QbxWUWE9PgOrw6FSw@mail.gmail.com>
References: <alpine.DEB.2.11.1601291104270.28963@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:35851 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756426AbcA2RHj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Jan 2016 12:07:39 -0500
Received: by mail-wm0-f47.google.com with SMTP id p63so77362074wmp.1
        for <ceph-devel@vger.kernel.org>; Fri, 29 Jan 2016 09:07:38 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1601291104270.28963@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: "Yan, Zheng" <zyan@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Fri, Jan 29, 2016 at 5:09 PM, Sage Weil <sweil@redhat.com> wrote:
> Hi Zheng,
>
> We have one feature already merged to ceph.git, CRUSH_TUNABLES5, that's a
> pretty trivial change to crush/mapper.c that we can add to the kernel.
>
> But there are two more coming:
>
> OSDOPREPLY_ENCODING makes a small change to the OSDOpReply encoding for
> performance reasons.  Here is the PR
>
>         https://github.com/ceph/ceph/pull/7386
>
> The other is the file layout changes, which are much more invovled:
>
>         https://github.com/ceph/ceph/pull/7098
>
> Ideally we'd use the same feature bit for all of these, but it means they
> all need to upstream into Linux together.  Do you see a problem with that?
> Assuming we get it all ready to go before the next merge window..
>
> The tricky bit is we really need to know that we'll be able to do it
> together before we cut jewel too and commit to the overlapping feature
> bits.

In the worst case, we could advertise support for the new bit for rbd
and not for cephfs - I don't think we ever get/put ceph file layout
from/to the wire in the rbd case.

As for the two easy ones (TUNABLES5 in particular), I think we should
try and get them in ASAP into 4.5 and then finalize the feature bit
arrangement closer to the end of the cycle, if necessary.  Otherwise
we'll have jewel and no kernel supporting its default tunables.

Thanks,

                Ilya
