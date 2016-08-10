From: Jeff Layton <jlayton@redhat.com>
Subject: Re: [RFC PATCH] client: don't use special inode for /..
Date: Wed, 10 Aug 2016 17:52:17 -0400
Message-ID: <1470865937.2694.26.camel@redhat.com>
References: <1470846630-830-1-git-send-email-jlayton@redhat.com>
	  <CA+2bHPYjYPRn99e3nCTjED6c89MnD_Eih_27z_J1=b4_CtLqOg@mail.gmail.com>
	 <1470861005.2694.12.camel@redhat.com>
	 <alpine.DEB.2.11.1608102122450.17770@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f172.google.com ([209.85.220.172]:35555 "EHLO
	mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751979AbcHJVwW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Aug 2016 17:52:22 -0400
Received: by mail-qk0-f172.google.com with SMTP id v123so16395096qkh.2
        for <ceph-devel@vger.kernel.org>; Wed, 10 Aug 2016 14:52:21 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1608102122450.17770@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Patrick Donnelly <pdonnell@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Wed, 2016-08-10 at 21:23 +0000, Sage Weil wrote:
> On Wed, 10 Aug 2016, Jeff Layton wrote:
> > On Wed, 2016-08-10 at 16:08 -0400, Patrick Donnelly wrote:
> > > > On Wed, Aug 10, 2016 at 12:30 PM, Jeff Layton <jlayton@redhat.com>
> > > wrote:
> > > > 
> > > > The CEPH_INO_DOTDOT thing is quite strange. Under most OS (Linux
> > > > included), the parent of the root is itself. IOW, at the root, '.'
> > > > and
> > > > '..' refer to the same inode.
> > > > 
> > > > Change the ceph client to do the same, as this allows users to get
> > > > valid stat info for '..', as well as elimnating some special-
> > > > casing.
> > > > 
> > > > > Signed-off-by: Jeff Layton <jlayton@redhat.com>
> > > 
> > > Don't forget Client::_lookup:
> > > 
> > >   if (dname == "..") {
> > >     if (dir->dn_set.empty())
> > >       r = -ENOENT;
> > >     else
> > >       *target = dir->get_first_parent()->dir->parent_inode; //dirs
> > > can't be hard-linked
> > >     goto done;
> > >   }
> > > 
> > > Otherwise LGTM.
> > > 
> > 
> > 
> > Ahh, thanks. So will dir->dn_set.empty() be true at the root? If so,
> > then something like the patch below?
> > 
> > Note that this patch is not strictly necessary, but it does simplify
> > some other changes that I have queued up:
> > 
> > diff --git a/src/client/Client.cc b/src/client/Client.cc
> > index 5ab0ace4d3df..287baaf20536 100644
> > --- a/src/client/Client.cc
> > +++ b/src/client/Client.cc
> > @@ -5924,7 +5924,7 @@ int Client::_lookup(Inode *dir, const string& dname, int mask,
> >  
> >    if (dname == "..") {
> >      if (dir->dn_set.empty())
> > -      r = -ENOENT;
> > +      *target = dir;
> >      else
> >        *target = dir->get_first_parent()->dir->parent_inode; //dirs can't be hard-linked
> >      goto done;
> 
> IIRC I did the dotdot thing originally because otherwise the '..' entry at 
> the mount point in ls -al didn't point to the parent directory.  Having 
> the fs explicitly do .. at all seems pretty weird to me... it seems like 
> the VFS should be doing this.  But in any case, I'd just verify that it 
> behaves the same way a real mount does after this change.
> 
> sage


The Linux VFS will definitely already handle ".." correctly (as you end
up doing a transition to a different vfsmount). So this shouldn't
affect ceph-fuse, AFAICT.

I think this change would primarily be noticed by those using libcephfs
directly...either in ceph_readdir/ceph_lookup (and related) calls, or
during a pathwalk.

That said, Patrick's suggestion to add some tests around this makes
sense. I'll plan to spin that up so we can be clear on how the behavior
changes.

Thanks,
-- 
Jeff Layton <jlayton@redhat.com>
