From: Jeff Layton <jlayton@redhat.com>
Subject: Re: [RFC PATCH] client: don't use special inode for /..
Date: Wed, 10 Aug 2016 16:30:05 -0400
Message-ID: <1470861005.2694.12.camel@redhat.com>
References: <1470846630-830-1-git-send-email-jlayton@redhat.com>
	 <CA+2bHPYjYPRn99e3nCTjED6c89MnD_Eih_27z_J1=b4_CtLqOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f182.google.com ([209.85.220.182]:34324 "EHLO
	mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932985AbcHJUaK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Aug 2016 16:30:10 -0400
Received: by mail-qk0-f182.google.com with SMTP id p186so55522144qkd.1
        for <ceph-devel@vger.kernel.org>; Wed, 10 Aug 2016 13:30:09 -0700 (PDT)
In-Reply-To: <CA+2bHPYjYPRn99e3nCTjED6c89MnD_Eih_27z_J1=b4_CtLqOg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Patrick Donnelly <pdonnell@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Wed, 2016-08-10 at 16:08 -0400, Patrick Donnelly wrote:
> On Wed, Aug 10, 2016 at 12:30 PM, Jeff Layton <jlayton@redhat.com>
> wrote:
> > 
> > The CEPH_INO_DOTDOT thing is quite strange. Under most OS (Linux
> > included), the parent of the root is itself. IOW, at the root, '.'
> > and
> > '..' refer to the same inode.
> > 
> > Change the ceph client to do the same, as this allows users to get
> > valid stat info for '..', as well as elimnating some special-
> > casing.
> > 
> > Signed-off-by: Jeff Layton <jlayton@redhat.com>
> 
> Don't forget Client::_lookup:
> 
>   if (dname == "..") {
>     if (dir->dn_set.empty())
>       r = -ENOENT;
>     else
>       *target = dir->get_first_parent()->dir->parent_inode; //dirs
> can't be hard-linked
>     goto done;
>   }
> 
> Otherwise LGTM.
> 


Ahh, thanks. So will dir->dn_set.empty() be true at the root? If so,
then something like the patch below?

Note that this patch is not strictly necessary, but it does simplify
some other changes that I have queued up:

diff --git a/src/client/Client.cc b/src/client/Client.cc
index 5ab0ace4d3df..287baaf20536 100644
--- a/src/client/Client.cc
+++ b/src/client/Client.cc
@@ -5924,7 +5924,7 @@ int Client::_lookup(Inode *dir, const string& dname, int mask,
 
   if (dname == "..") {
     if (dir->dn_set.empty())
-      r = -ENOENT;
+      *target = dir;
     else
       *target = dir->get_first_parent()->dir->parent_inode; //dirs can't be hard-linked
     goto done;


-- 
Jeff Layton <jlayton@redhat.com>
