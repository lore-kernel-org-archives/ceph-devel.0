From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: client-facing feature bits and pending kernel changes
Date: Mon, 1 Feb 2016 17:30:02 +0800
Message-ID: <CAAM7YAnygLww6UYemZcFjPxPCnrN8D7xO4wTHZwFjTNAEof61w@mail.gmail.com>
References: <alpine.DEB.2.11.1601291104270.28963@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:36037 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752956AbcBAJaE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 1 Feb 2016 04:30:04 -0500
Received: by mail-lb0-f172.google.com with SMTP id dx2so71058473lbd.3
        for <ceph-devel@vger.kernel.org>; Mon, 01 Feb 2016 01:30:03 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1601291104270.28963@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Zheng Yan <zyan@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Sat, Jan 30, 2016 at 12:09 AM, Sage Weil <sweil@redhat.com> wrote:
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

Can we avoid changing how file layout is encoded in MClientCaps and
MClientReply? Instead, we encode the namespace information at the end
of MClientCaps/MClientReply message. (like how we added inline data
related fields to these message).

Regards
Yan, Zheng

>
> Ideally we'd use the same feature bit for all of these, but it means they
> all need to upstream into Linux together.  Do you see a problem with that?
> Assuming we get it all ready to go before the next merge window..
>
> The tricky bit is we really need to know that we'll be able to do it
> together before we cut jewel too and commit to the overlapping feature
> bits.
>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
