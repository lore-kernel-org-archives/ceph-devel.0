From: Milosz Tanski <milosz@adfin.com>
Subject: Re: why the performance of ceph.ko is better than others.
Date: Thu, 28 Aug 2014 10:53:58 -0400
Message-ID: <CANP1eJHK6DSfsrOJT_Z0zFvcQ-HerCtCVU74cu9K2JuM+0BN3g@mail.gmail.com>
References: <CAPaK2r-MVyuzncNXCx1xitvHPkFsQn-H7+xR+t-mK4CExxcrqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:52300 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750831AbaH1OyC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 Aug 2014 10:54:02 -0400
Received: by mail-lb0-f179.google.com with SMTP id l4so1041392lbv.10
        for <ceph-devel@vger.kernel.org>; Thu, 28 Aug 2014 07:53:58 -0700 (PDT)
In-Reply-To: <CAPaK2r-MVyuzncNXCx1xitvHPkFsQn-H7+xR+t-mK4CExxcrqw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: yue longguang <yuelongguang@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Yue,

In the kernel vs. fuse case it comes down to ... it's the kernel.

There's the obvious part of having less overhead by having it in the
kernel. Consider the IO path between the kernel implementation vs. the
fuse implementation.

1. application (perf test) -> kernel (VFS/VMA) -> kernel (ceph.ko) ->
kernel (network) -> kernel (ceph.ko) -> kernel (VFS) -> application.
2. application (perf test) -> kernel (VFS/VMA) -> kernel (fuse) ->
userspace (ceph) -> network (kernel) -> userspace (ceph) -> kernel
(fuse) -> kernel (VFS) -> application

The kernel nowadays and especially the VMA and VFS subsystem are
pretty tuned for scalability though a lot of efforts though out the
years. The ceph kernel implementation benefits a lot for that
(ongoing) work. The userspace client has to worry / re-implement some
part of that are already provided in the kernel. In many cases the
concurrency primitives in user space are less low-level,
sophisitcated, blunter tools.

The above reason is why we (Adfin) ended up investing in using and
helping develop parts of the Ceph kernel client.

I can only speak for ceph kernel vs. fuse implementations (I have
never really focused on RBD) based my experience and some of it's
anecdotal evidence. It's hard to make an apples to apples comparison,
there's many other variables to tease out.

Best,
- Milosz

On Thu, Aug 28, 2014 at 4:04 AM, yue longguang <yuelongguang@gmail.com> wrote:
> the conclusion is from the link.
> http://www.slideshare.net/Inktank_Ceph/fj-20140227-cephbestpractisedistributedintelligentunifiedcloudstoragev4ksp
>
>
> guys, could you tell me the reason?
>
> thanks
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Milosz Tanski
CTO
16 East 34th Street, 15th floor
New York, NY 10016

p: 646-253-9055
e: milosz@adfin.com
