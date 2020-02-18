From: Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH] ceph: add halt mount option support
Date: Tue, 18 Feb 2020 07:01:52 -0500
Message-ID: <4a4cfe2a5fc1de6f73fa3f557921c1ad5802add6.camel@kernel.org>
References: <20200216064945.61726-1-xiubli@redhat.com>
         <78ff80dd12d497be7a6606a60973f7e2d864e910.camel@kernel.org>
         <36e1f3a9-1688-9eb0-27d7-351a12bca85a@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:49886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726292AbgBRMBy (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 18 Feb 2020 07:01:54 -0500
In-Reply-To: <36e1f3a9-1688-9eb0-27d7-351a12bca85a@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xiubo Li <xiubli@redhat.com>, idryomov@gmail.com
Cc: sage@redhat.com, zyan@redhat.com, pdonnell@redhat.com, ceph-devel@vger.kernel.org

On Tue, 2020-02-18 at 15:19 +0800, Xiubo Li wrote:
> On 2020/2/17 21:04, Jeff Layton wrote:
> > On Sun, 2020-02-16 at 01:49 -0500, xiubli@redhat.com wrote:
> > > From: Xiubo Li <xiubli@redhat.com>
> > > 
> > > This will simulate pulling the power cable situation, which will
> > > do:
> > > 
> > > - abort all the inflight osd/mds requests and fail them with -EIO.
> > > - reject any new coming osd/mds requests with -EIO.
> > > - close all the mds connections directly without doing any clean up
> > >    and disable mds sessions recovery routine.
> > > - close all the osd connections directly without doing any clean up.
> > > - set the msgr as stopped.
> > > 
> > > URL: https://tracker.ceph.com/issues/44044
> > > Signed-off-by: Xiubo Li <xiubli@redhat.com>
> > There is no explanation of how to actually _use_ this feature? I assume
> > you have to remount the fs with "-o remount,halt" ? Is it possible to
> > reenable the mount as well?  If not, why keep the mount around? Maybe we
> > should consider wiring this in to a new umount2() flag instead?
> > 
> > This needs much better documentation.
> > 
> > In the past, I've generally done this using iptables. Granted that that
> > is difficult with a clustered fs like ceph (given that you potentially
> > have to set rules for a lot of addresses), but I wonder whether a scheme
> > like that might be more viable in the long run.
> > 
> How about fulfilling the DROP iptable rules in libceph ? Could you 
> foresee any problem ? This seems the one approach could simulate pulling 
> the power cable.
> 

Yeah, I've mostly done this using DROP rules when I needed to test things.
But, I think I was probably just guilty of speculating out loud here.

I think doing this by just closing down the sockets is probably fine. I
wouldn't pursue anything relating to to iptables here, unless we have
some larger reason to go that route.

-- 
Jeff Layton <jlayton@kernel.org>
