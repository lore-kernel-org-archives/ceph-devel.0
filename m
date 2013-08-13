From: Sage Weil <sage@inktank.com>
Subject: Re: poll/sendmsg problem with 3.5.0-37-generic #58~precise1-Ubuntu
Date: Tue, 13 Aug 2013 15:15:22 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1308131451450.22762@cobra.newdream.net>
References: <alpine.DEB.2.00.1308122111030.1479@cobra.newdream.net> <87fvud4s0v.fsf@canonical.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44710 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757355Ab3HMWPW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Aug 2013 18:15:22 -0400
In-Reply-To: <87fvud4s0v.fsf@canonical.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Luis Henriques <luis.henriques@canonical.com>
Cc: kernel-team@lists.ubuntu.com, ceph-devel@vger.kernel.org

On Tue, 13 Aug 2013, Luis Henriques wrote:
> Sage Weil <sage@inktank.com> writes:
> 
> > Hi,
> >
> > A ceph user hit a problem with the 3.5 precise kernel with symptoms 
> > exactly like an old poll(2) bug[1].  Basically, one end of a socket is 
> > blocked on sendmsg(2), and the other end is blocked on poll(2) waiting for 
> > data.  15 minutes later the poll(2) timeout triggers, we reset the 
> > connection, and ceph recovers and continues.  (For this user, the visible 
> > ceph symptoms were stuck peering, stuck recovery, or hung requests that 
> > *eventually* cleared themselves up.)
> >
> > In this case, it doesn't look like the 3.5.0-37 kernel has the old 
> > problematic patch (which first appeared in 3.6-rc1 and was fixed before 
> > 3.6 was released), but we see the exact same behavior (blocked writer, 
> > blocked reader/poller, but netstat showing bytes available on the socket), 
> > and upgrading the kernel to the current 3.8 precise package resolved the 
> > problem.  The 3.5 ubuntu kernel does have a few sendmsg patches[2] that 
> > (under the circumstances) appear suspicious.
> >
> > The one other detail in this case is that it seemed to only crop up 
> > connections involving one node in the system.
> >
> > I'm not sure where to go from here, since the user is happy to now have a 
> > working system, and I'm not sure if it is worth spending the time to 
> > reproduce the issue.  It might be simpler to just recommend users move off 
> > the 3.5 kernel.  In the meantime, though, I wanted to at least make 
> > everyone aware of the (potential) problem.
> >
> > sage
> >
> >
> > [1] http://marc.info/?l=ceph-devel&m=134540224811321&w=2
> > [2] https://launchpad.net/ubuntu/+source/linux-lts-quantal/3.5.0-37.58~precise1
> 
> I believe the suspicious commits you're referring to in the Quantal
> kernel are:
> 
> 1be374a net: Block MSG_CMSG_COMPAT in send(m)msg and recv(m)msg
> a7526eb net: Unbreak compat_sys_{send,recv}msg
> 
> Both of these commits came in through upstream stable updates and are
> clean cherry-picks.  All the upstream stable kernels seem to contain
> it.
> 
> [ Note however that most of the stable kernels have squashed these 2
>   commits in a single commit. ]
> 
> This means that, if you're correct, it is likely that the Raring
> kernel will also have this issue: 3.8.0-27.40 Raring kernel has these
> 2 commits as well.  Could you please confirm the user that reported
> this issue is running this kernel (or later)?

They are now on http://packages.ubuntu.com/precise/linux-image-3.8.0-27-generic
and the problem seems to be gone.

The previous time this came up it was a subtle side-effect from a 
seemingly unrelated patch,

 netvm: propagate page->pfmemalloc to skb
 c48a11c7ad

and was fixed by

 mm: correct page->pfmemalloc to fix deactivate_slab regression
 b121186ab

...which doesn't necessarily mean anything here except that it is easy to 
subtley break poll(2) without many users noticing quickly. My gut tells me 
that 3.5 is probably okay and one of the stable patches tweaked something, 
but it's hard to say since we haven't tried reproducing this with the 
ubuntu 3.5 kernel in our lab (only 3.5 mainline, a year ago, which had no 
problems).  We do most of our testing on the mainline kernels (without any 
stable patches) and haven't seen this since 3.6-rc3 got the fix above.  
We're about to expand testing to include the distro kernels, though, for 
exactly this reason.

Sorry, I don't really know what (if anything) should be done here, but it 
seemed like it was worth mentioning.  If we figure out more, I'll 
definitely let you know.

Thanks!
sage
