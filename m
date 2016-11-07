From: Sage Weil <sweil@redhat.com>
Subject: Re: [sepia] bluestore, and how to handle buggy kernels
Date: Mon, 7 Nov 2016 19:57:25 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1611071953080.18089@piezo.us.to>
References: <alpine.DEB.2.11.1611061550170.18089@piezo.us.to> <CALqRxCw1z3-HAh1iQTROmmjTGosZ-upFjnrYd5hr1Y37r3tYww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51174 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750757AbcKGT52 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 7 Nov 2016 14:57:28 -0500
In-Reply-To: <CALqRxCw1z3-HAh1iQTROmmjTGosZ-upFjnrYd5hr1Y37r3tYww@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>
Cc: "sepia@ceph.com" <sepia@ceph.com>, ceph-devel <ceph-devel@vger.kernel.org>, Zack Cerza <zcerza@redhat.com>

On Mon, 7 Nov 2016, Ken Dreyer wrote:
> On Sun, Nov 6, 2016 at 8:59 AM, Sage Weil <sweil@redhat.com> wrote:
> > Under load BlueStore triggers this bug
> >
> >         http://www.gossamer-threads.com/lists/linux/kernel/1993181
> >
> > in 3.13.0-100-generic, the original trusty 14.04 kernel.  We currently do
> > most of the Ceph testing on trusty, xenial, and centos 7.x, and we use the
> > default/original distro kernels (vs the latest ones) exactly so that we
> > notice when kernel bugs like this rear their heads.
> >
> > (We had an embarassing problem with firefly where a bug in the old precise
> > 12.04 kernel affected users but we were testing with the latest ubuntu
> > kernel.)
> 
> In this case with Precise, was the problem that we were testing
> Ubuntu's HWE kernels [1], so we missed that the bug existed in their
> GA kernel (kernel 3.2)?

Yep.
 
> Excluding Ubuntu's HWE situation, I think we'd always want to test
> against "the newest", right? Users should be running whatever is the
> newest, for security's sake.

Yeah, Zack and I went through this an hour or so ago.  On ubuntu, 
we're testing the linux-image-generic package, which is the 'stable' 
kernel for the LTE release (in Trusty's case, 3.13).  In this case it 
was last updated a week or two ago.  We aren't explicitly testing other 
HWE kernels *except* by virtue of also having xenial machines in the lab 
and thus testing that stable kernel as well.  I think that's fine.

For centos, we install the latest 'kernel' package, which is also the 
stable kernel that is updated regularly.  My understanding is that this is 
always the latest regardless of whether the host is 7.0, 7.1, etc.

In any case, I had assumed that the kernel was "out of date," but this was 
actually the latest stable Ubuntu kernel for trusty.  I sent kernel-team a 
bug report and requested a backport of the upstream fix.

sage
