From: Haomai Wang <haomai@xsky.com>
Subject: Re: reducing buffer allocations
Date: Fri, 5 Feb 2016 10:56:34 +0800
Message-ID: <CACJqLyYztuh_8pOHSW3VnNLz6V_OMpEJM2LAZU5QoAAmhLYw7w@mail.gmail.com>
References: <alpine.DEB.2.11.1602041730260.28396@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-sg2apc01on0091.outbound.protection.outlook.com ([104.47.125.91]:52544
	"EHLO APC01-SG2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750722AbcBEC4u (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 4 Feb 2016 21:56:50 -0500
Received: by mail-ig0-f176.google.com with SMTP id 5so5437811igt.0
        for <ceph-devel@vger.kernel.org>; Thu, 04 Feb 2016 18:56:45 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1602041730260.28396@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Feb 5, 2016 at 6:33 AM, Sage Weil <sweil@redhat.com> wrote:
> https://github.com/ceph/ceph/pull/5534
>
> does two things: (1) combine the buffer::raw reference count and buffer
> into a single allocation (ala make_shared), and (2) convert buffer::list
> into an intrusive_list, while embedding N (=3) buffer::ptr's in the
> buffer::raw so that most buffers require only 1 allocation (provided they
> aren't on more than N lists).
>
> This needs a rebase, and some benchmarking.  But before I pull it up, is
> this the right direction?  I saw little benefit from (2) after doing
> (1), but I was doing a really simple microbenchmark.  Do we want both, or
> just 1, or is there an alternative we should consider?

I think a another way is separating the owner of memory and the
reference to the part of memory. Like Buffer structure in
RAMCloud(https://github.com/PlatformLab/RAMCloud/blob/master/src/Buffer.h)

1. The Buffer(like bufferlist) own "vector<void*> allocations" to
store all associated memory to keep them. It will be convenient for
addition malloc(like getRange)
2. Chunk(like ptr) maintain *next ptr instead std::list

Hmm, it doesn't have much difference. FYI

>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
