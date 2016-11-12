From: Jeff Layton <jlayton@redhat.com>
Subject: Re: handling MDS permission check failures in cap updates (was:
 [RFC PATCH 07/10] ceph: update cap message struct version to 9)
Date: Fri, 11 Nov 2016 20:16:36 -0500
Message-ID: <1478913396.28905.14.camel@redhat.com>
References: <alpine.DEB.2.11.1611072121100.29278@piezo.us.to>
                                 <CAJ4mKGZ8hJ8183Nj8vtexswRcqN4Ye8Qoqtrav6-GCs2d3hmgw@mail.gmail.com>
                                 <alpine.DEB.2.11.1611072318290.29278@piezo.us.to>
                         <1478868317.2482.23.camel@redhat.com>
                 <alpine.DEB.2.11.1611111445310.29579@piezo.us.to>
                 <1478876433.2482.32.camel@redhat.com>
                 <alpine.DEB.2.11.1611111506070.29579@piezo.us.to>
         <1478878749.2482.38.camel@redhat.com>
         <alpine.DEB.2.11.1611111556480.29579@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f182.google.com ([209.85.220.182]:34110 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966097AbcKLBQl (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 11 Nov 2016 20:16:41 -0500
Received: by mail-qk0-f182.google.com with SMTP id q130so39634169qke.1
        for <ceph-devel@vger.kernel.org>; Fri, 11 Nov 2016 17:16:40 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1611111556480.29579@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, "Yan, Zheng" <ukernel@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>, Ilya Dryomov <idryomov@gmail.com>

On Fri, 2016-11-11 at 16:02 +0000, Sage Weil wrote:
> On Fri, 11 Nov 2016, Jeff Layton wrote:
> > On Fri, 2016-11-11 at 15:07 +0000, Sage Weil wrote:
> > > On Fri, 11 Nov 2016, Jeff Layton wrote:
> > > > On Fri, 2016-11-11 at 14:48 +0000, Sage Weil wrote:
> > > > > On Fri, 11 Nov 2016, Jeff Layton wrote:
> > > > > > On Mon, 2016-11-07 at 23:21 +0000, Sage Weil wrote:
> > > > > > > On Mon, 7 Nov 2016, Gregory Farnum wrote:
> > > > > > > > On Mon, Nov 7, 2016 at 1:21 PM, Sage Weil <sweil@redhat.com> wrote:
> > > > > > > > > On Mon, 7 Nov 2016, Jeff Layton wrote:
> > > > > > > > >> On Mon, 2016-11-07 at 20:09 +0000, Sage Weil wrote:
> > > > > > > > >> > On Mon, 7 Nov 2016, Gregory Farnum wrote:
> > > > > > > > >> > > On Mon, Nov 7, 2016 at 10:39 AM, Jeff Layton <jlayton@redhat.com> wrote:
> > > > > > > > >> > > > On Mon, 2016-11-07 at 14:36 +0000, Sage Weil wrote:
> > > > > > > > >> > > >> On Mon, 7 Nov 2016, Jeff Layton wrote:
> > > > > > > > >> > > >> > On Mon, 2016-11-07 at 14:05 +0000, Sage Weil wrote:
> > > > > > > > >> > > >> > > On Mon, 7 Nov 2016, Jeff Layton wrote:
> > > > > > > > >> > > >> > > > On Mon, 2016-11-07 at 16:43 +0800, Yan, Zheng wrote:
> > > > > > > > >> > > >> > > > > On Fri, Nov 4, 2016 at 8:57 PM, Jeff Layton <jlayton@redhat.com> wrote:
> > > > > > > > >> > > >> > > > > >
> > > > > > > 
> > > > > > > [okay, time to prune this a bit]
> > > > > > > 
> > > > > > > > >> It still seems to me like that should just be a check for superuser
> > > > > > > > >> status. Something like:
> > > > > > > > >>
> > > > > > > > >>       if (mask & MAY_CHOWN) {
> > > > > > > > >>       // only root can chown
> > > > > > > > >>         if (i->match.uid != 0 || caller_uid != 0)
> > > > > > > > >>           continue;
> > > > > > > > >>         }
> > > > > > > > >>       }
> > > > > > > > >>
> > > > > > > > >> i.e. only allow chown if the capability has a uid of 0 and the
> > > > > > > > >> caller_uid is also 0.
> > > > > > > > >>
> > > > > > > > >> I don't think we want to ever grant an unprivileged user the ability to
> > > > > > > > >> chown, do we?
> > > > > > > > >
> > > > > > > > > Ah, yep.  Except that the Locker.cc caller needs to be fixed to only ask
> > > > > > > > > for MAY_CHOWN if the uid is changing.  Right now it's only passing
> > > > > > > > > MAY_WRITE which looks wrong too...
> > > > > > > > 
> > > > > > > > Don't we want to let users chown between their own UIDs? A POSIX
> > > > > > > > superuser — ie root — really has very little meaning in terms of CephX
> > > > > > > > permissions. But it's perfectly legitimate for a tenant with 3 users
> > > > > > > > to chmod files between those 3. :/
> > > > > > > 
> > > > > > > Maybe, but it'd be a different kind of check though, because it depends on 
> > > > > > > multiple caps in order to permit the operation.  So we'd need a couple 
> > > > > > > function-global bools like chown_src_allowed and chown_dst_allowed or 
> > > > > > > something like that.
> > > > > > > 
> > > > > > > I'm not sure it would work even then, though, because on the client the 
> > > > > > > user would still have to sudo chown ... to get past the client kernel's 
> > > > > > > checks (I assume?).
> > > > > > > 
> > > > > > > 
> > > > > > 
> > > > > > Not necessarily. Most kernel filesystems call setattr_prepare, which is
> > > > > > where the CAP_CHOWN check happens, but (e.g.) NFS doesn't call it as it
> > > > > > always delegates the permission checking for setattr to the server.
> > > > > > 
> > > > > > Looks like both the in-kernel and Ceph client and FUSE always call that
> > > > > > function, so CAP_CHOWN permissions are always checked client-side there.
> > > > > > Still, with libcephfs a program need not deal with the kernel at all, so
> > > > > > you can't really rely on that.
> > > > > 
> > > > > In the libcephfs case it's still doing the Client.cc checks, though, 
> > > > > right?  Both the Linux VFS (on ceph.ko) and Client.cc are implementing 
> > > > > client-side checks...
> > > > > 
> > > > 
> > > > Only if fuse_default_permissions is set (which is a misnomer since it
> > > > affects more than just ceph-fuse). It's not set by default, but probably
> > > > should be.
> > > > 
> > > > 
> > > > > > Isn't this potentially silent metadata corruption? You could end up with
> > > > > > a program that issues an ownership change that appears to work, only to
> > > > > > find later that it got reverted because the mds decided it didn't want
> > > > > > to apply it once the caps got updated.
> > > > > > 
> > > > > > I think the simplest solution would be to just not issue exclusive caps
> > > > > > at all if you aren't prepared to accept cached updates from the client
> > > > > > for the corresponding metadata. Those clients would get shared caps
> > > > > > only. So, you could have clients to which you allow Fx caps, but only
> > > > > > As?
> > > > > 
> > > > > That would be safe, but it would kill performance for any user writing 
> > > > > files and restricted to a particular user by their caps.  I think it's 
> > > > > definitely worth maintaining the Client code do the checks so that 
> > > > > unpermitted updates aren't dropped... which, if I'm not mistaken, 
> > > > > is already in place.
> > > > > 
> > > > 
> > > > I don't see why that would kill performance. chown/chgrp/chmod would all
> > > > come under Auth caps, whereas read/write (which is where we really care
> > > > about performance) come under File caps.
> > > > 
> > > > chown/chgrp/chmod are all pretty rare in most workloads, so having to
> > > > call the mds to apply them in those cases doesn't seem like a heavy
> > > > burden.
> > > 
> > > It's tar xf that I'm worried about.. that'll do a create following by 
> > > chmod, maybe chown, and then file write, which are currently all flushed 
> > > async, and would now turn synchronous.
> > > 
> > 
> > Good point, that workload would suck there.
> > 
> > > But AFAICS it's not needed, since both the kernel and userspace clients 
> > > are doing the client-side check...
> > > 
> > > 
> > 
> > Erm...that's just it though...all the client is doing is enforcing
> > normal POSIX permissions, but those don't necessarily align exactly with
> > the ceph user permissions.
> > 
> > Can we end up in a situation where the POSIX permissions would allow
> > root to chown, but then the client ends up not being able to do it
> > because root's permissions are limited?
> > 
> > If not, do we need the client to try and enforce those as well? 
> 
> Ah, right.  The 'sudo chown ...' case is the trivial example, I think.
> 
> We've tried to keep the capabilities opaque to the client until now, and I 
> think that's still probably the right choice... I wouldn't want to 
> deal with it in the kernel case.
> 
> Even if the async metadata update returned an error to the client, they'd 
> only see it on, say, fsync (or maybe close, sometimes).  I don't think 
> that's particularly helpful.
> 
> Perhaps we could communicate a few "imporant" flags to the client about 
> it's permissions.  In this case, a flag indicating there are restrictions 
> on uid/gid, so that any inode updates touching those fields should be done 
> synchronously...
> 
> Or, we could separate out the authlock caps into two locks, one with 
> uid/gid and one with mode.  This is a case where it's actually harmful to 
> conflate them.
> 

That seems like it would be the cleanest solution. Then you could just
not hand out exclusive caps for the uid/gid to those clients. Mode
changes could still be cached. 

That's a bit more work to engineer though, and it's probably also worth
thinking about whether we need to move other metadata to different caps
as well.

On a slightly related note, in hindsight the btime might have been
better under xattr caps. It's probably not too late for that if we want
to make that change since kraken hasn't shipped yet, and the kernel
patches are on hold.

> Are there cases where a mode change would have to be validated by the MDS?  
> Like, setting the setuid bit or something?  I don't think we are doing 
> anything special on the MDS side there, but maybe we should be?
> 
> 

Yeah. Probably the MDS ought to clear the setuid and setgid bits
whenever there is an ownership change (user or group). POSIX requires
that, IIRC.

I'll look over the code to make sure we aren't already doing that and
open a bug if not.

-- 
Jeff Layton <jlayton@redhat.com>
