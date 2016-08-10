From: Sage Weil <sweil@redhat.com>
Subject: Re: [RFC PATCH] client: don't use special inode for /..
Date: Wed, 10 Aug 2016 21:23:54 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1608102122450.17770@piezo.us.to>
References: <1470846630-830-1-git-send-email-jlayton@redhat.com>  <CA+2bHPYjYPRn99e3nCTjED6c89MnD_Eih_27z_J1=b4_CtLqOg@mail.gmail.com> <1470861005.2694.12.camel@redhat.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-78647880-1470864236=:17770"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49556 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750796AbcHJVX5 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 10 Aug 2016 17:23:57 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9468880085
	for <ceph-devel@vger.kernel.org>; Wed, 10 Aug 2016 21:23:56 +0000 (UTC)
In-Reply-To: <1470861005.2694.12.camel@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@redhat.com>
Cc: Patrick Donnelly <pdonnell@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-78647880-1470864236=:17770
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 10 Aug 2016, Jeff Layton wrote:
> On Wed, 2016-08-10 at 16:08 -0400, Patrick Donnelly wrote:
> > On Wed, Aug 10, 2016 at 12:30 PM, Jeff Layton <jlayton@redhat.com>
> > wrote:
> > > 
> > > The CEPH_INO_DOTDOT thing is quite strange. Under most OS (Linux
> > > included), the parent of the root is itself. IOW, at the root, '.'
> > > and
> > > '..' refer to the same inode.
> > > 
> > > Change the ceph client to do the same, as this allows users to get
> > > valid stat info for '..', as well as elimnating some special-
> > > casing.
> > > 
> > > Signed-off-by: Jeff Layton <jlayton@redhat.com>
> > 
> > Don't forget Client::_lookup:
> > 
> >   if (dname == "..") {
> >     if (dir->dn_set.empty())
> >       r = -ENOENT;
> >     else
> >       *target = dir->get_first_parent()->dir->parent_inode; //dirs
> > can't be hard-linked
> >     goto done;
> >   }
> > 
> > Otherwise LGTM.
> > 
> 
> 
> Ahh, thanks. So will dir->dn_set.empty() be true at the root? If so,
> then something like the patch below?
> 
> Note that this patch is not strictly necessary, but it does simplify
> some other changes that I have queued up:
> 
> diff --git a/src/client/Client.cc b/src/client/Client.cc
> index 5ab0ace4d3df..287baaf20536 100644
> --- a/src/client/Client.cc
> +++ b/src/client/Client.cc
> @@ -5924,7 +5924,7 @@ int Client::_lookup(Inode *dir, const string& dname, int mask,
>  
>    if (dname == "..") {
>      if (dir->dn_set.empty())
> -      r = -ENOENT;
> +      *target = dir;
>      else
>        *target = dir->get_first_parent()->dir->parent_inode; //dirs can't be hard-linked
>      goto done;

IIRC I did the dotdot thing originally because otherwise the '..' entry at 
the mount point in ls -al didn't point to the parent directory.  Having 
the fs explicitly do .. at all seems pretty weird to me... it seems like 
the VFS should be doing this.  But in any case, I'd just verify that it 
behaves the same way a real mount does after this change.

sage
--8323329-78647880-1470864236=:17770--
