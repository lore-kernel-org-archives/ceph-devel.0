From: Sage Weil <sweil@redhat.com>
Subject: Re: cephfs root_squash, multitenancy
Date: Fri, 13 Feb 2015 15:35:58 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1502131141170.3035@cobra.newdream.net>
References: <alpine.DEB.2.00.1502130457540.3131@cobra.newdream.net> <CAC6JEv8ACd+udEODdbBUEfAXv03w=OjFEVdrPHsp57Z8svSQ5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49596 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752071AbbBMXgB (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 13 Feb 2015 18:36:01 -0500
In-Reply-To: <CAC6JEv8ACd+udEODdbBUEfAXv03w=OjFEVdrPHsp57Z8svSQ5w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@gregs42.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, 13 Feb 2015, Gregory Farnum wrote:
> On Fri, Feb 13, 2015 at 5:05 AM, Sage Weil <sweil@redhat.com> wrote:
> > Got this from JJ:
> >
> >> The SA expanded on this by stating that there are basically three main
> >> scenarios here:
> >>
> >> 1) We trust the UID/GID in a controlled environment. In which case we
> >> can safely rely on the POSIX permissions. As long as root_squash is
> >> available this would be fine.
> >
> > I think adding a root_squash option to client/Client.cc and the ceph.ko
> > should be pretty easy...
> >
> >> 2) Multi-tenant systems. In these cases being able to create keyrings
> >> which limit access to specified directories would be ideal.
> >
> > This is mainly enforcing uid/gid and mount path in MDSAuthCap, and not
> > unlike what we'll need for OpenStack Manila.  I think it's something like
> >
> >  1- establish mount root inode ref when session is opened/authenticated
> >  2- verify in reply path that any inode we reference is beneath that point
> >  3- special case inodes in stray directory, hopefully in some secure-ish
> > way based on where they lived previously.  (not sure how this'll work...)
> 
> This concerns me:
> 1) We have nothing to control access to raw objects, so there is some
> security against accidents here, but not against malicious code users.

Yeah.  There's no complete solution without both pieces, but one of them 
has to come first.

> 2) Path verification is going to be tricky to handle with symlinks and
> things. Moving it into the reply path as you discuss makes one set of
> decisions on that (I'm not sure how flexibly?)

Symlinks at least are easy: they are resolved on the client side in the 
VFS (above ceph-fuse/libcephfs or ceph.ko).  As far as the file system is 
concerned symlinks are just a special type of file with a max size of 
PATH_MAX.

Remote links will be the tricky ones.  It would be nice if this was a 
simple check in the rdlock_* etc helpers in Server.cc but for hard links 
it would be one step past that.  On the other hand, it may make sense 
that if there is a hard link you get to see the file... in which case the 
hard part will actually making sure that we allow it if the dentry is 
inside the allowed subtree.

I said reply path before but now up-front checks in Server.cc seem more 
sensible.  :/ I need to spend some more time reading the code.

> 3) Cleanup in the case of failed requests would be pretty difficult ?
> we don't want to take away caps from other clients if the permissions
> check failed, we have to "disappear" any which we were planning to
> give out with the denied request, etc. And much of that work (eg the
> cap revocation) happens well before the client gets any kind of reply,
> for instance gathering data for stats. :(

Yeah :(.  I'm hoping the checks can happen up-front (i.e., mostly in 
Server.cc) before we touch any of the cap state.  I think that would make 
the denial case pretty simple...

> That doesn't make any of these problems intractable, but I don't think
> it's going to be a quick patch series and it will require a lot of
> testing with new mechanisms that don't exist yet.

Yep!  It'll mean a whole new set of mount tests with different mds caps 
that'll be pretty tedious to put together.  We could also go wild and 
inject hand-crafted messages over the wire, but the open-by-ino calls we 
put in place a while back would be an easier place to start.

sage
