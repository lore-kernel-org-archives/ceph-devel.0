From: Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH] ceph: add halt mount option support
Date: Tue, 18 Feb 2020 10:25:11 -0500
Message-ID: <d54188d2df1733bee17ad91b66c9439ee87b56e1.camel@kernel.org>
References: <20200216064945.61726-1-xiubli@redhat.com>
         <78ff80dd12d497be7a6606a60973f7e2d864e910.camel@kernel.org>
         <36e1f3a9-1688-9eb0-27d7-351a12bca85a@redhat.com>
         <4a4cfe2a5fc1de6f73fa3f557921c1ad5802add6.camel@kernel.org>
         <CAOi1vP_yGJGqkY+QLdQoruJrS3gawEC-_NqDnpucCWfXOHL-aQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726716AbgBRPZN (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 18 Feb 2020 10:25:13 -0500
In-Reply-To: <CAOi1vP_yGJGqkY+QLdQoruJrS3gawEC-_NqDnpucCWfXOHL-aQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Xiubo Li <xiubli@redhat.com>, Sage Weil <sage@redhat.com>, "Yan, Zheng" <zyan@redhat.com>, Patrick Donnelly <pdonnell@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Tue, 2020-02-18 at 15:59 +0100, Ilya Dryomov wrote:
> On Tue, Feb 18, 2020 at 1:01 PM Jeff Layton <jlayton@kernel.org> wrote:
> > On Tue, 2020-02-18 at 15:19 +0800, Xiubo Li wrote:
> > > On 2020/2/17 21:04, Jeff Layton wrote:
> > > > On Sun, 2020-02-16 at 01:49 -0500, xiubli@redhat.com wrote:
> > > > > From: Xiubo Li <xiubli@redhat.com>
> > > > > 
> > > > > This will simulate pulling the power cable situation, which will
> > > > > do:
> > > > > 
> > > > > - abort all the inflight osd/mds requests and fail them with -EIO.
> > > > > - reject any new coming osd/mds requests with -EIO.
> > > > > - close all the mds connections directly without doing any clean up
> > > > >    and disable mds sessions recovery routine.
> > > > > - close all the osd connections directly without doing any clean up.
> > > > > - set the msgr as stopped.
> > > > > 
> > > > > URL: https://tracker.ceph.com/issues/44044
> > > > > Signed-off-by: Xiubo Li <xiubli@redhat.com>
> > > > There is no explanation of how to actually _use_ this feature? I assume
> > > > you have to remount the fs with "-o remount,halt" ? Is it possible to
> > > > reenable the mount as well?  If not, why keep the mount around? Maybe we
> > > > should consider wiring this in to a new umount2() flag instead?
> > > > 
> > > > This needs much better documentation.
> > > > 
> > > > In the past, I've generally done this using iptables. Granted that that
> > > > is difficult with a clustered fs like ceph (given that you potentially
> > > > have to set rules for a lot of addresses), but I wonder whether a scheme
> > > > like that might be more viable in the long run.
> > > > 
> > > How about fulfilling the DROP iptable rules in libceph ? Could you
> > > foresee any problem ? This seems the one approach could simulate pulling
> > > the power cable.
> > > 
> > 
> > Yeah, I've mostly done this using DROP rules when I needed to test things.
> > But, I think I was probably just guilty of speculating out loud here.
> 
> I'm not sure what exactly Xiubo meant by "fulfilling" iptables rules
> in libceph, but I will say that any kind of iptables manipulation from
> within libceph is probably out of the question.
> 
> > I think doing this by just closing down the sockets is probably fine. I
> > wouldn't pursue anything relating to to iptables here, unless we have
> > some larger reason to go that route.
> 
> IMO investing into a set of iptables and tc helpers for teuthology
> makes a _lot_ of sense.  It isn't exactly the same as a cable pull,
> but it's probably the next best thing.  First, it will be external to
> the system under test.  Second, it can be made selective -- you can
> cut a single session or all of them, simulate packet loss and latency
> issues, etc.  Third, it can be used for recovery and failover/fencing
> testing -- what happens when these packets get delivered two minutes
> later?  None of this is possible with something that just attempts to
> wedge the mount and acts as a point of no return.
> 

That's a great point and does sound tremendously more useful than just
"halting" a mount like this.

That said, one of the stated goals in the tracker bug is:

"It'd be better if we had a way to shutdown the cephfs mount without any
kind of cleanup. This would allow us to have kernel clients all on the
same node and selectively "kill" them."

That latter point sounds rather hard to fulfill with iptables rules.
-- 
Jeff Layton <jlayton@kernel.org>
