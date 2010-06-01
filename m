From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH] ceph: fix d_subdirs ordering problem
Date: Tue, 1 Jun 2010 11:45:41 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1006011143020.14408@cobra.newdream.net>
References: <AANLkTikAPg1pVfpnH_BSQFyQn2BzUNiGB3tVC2104Ts1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:51596 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751364Ab0FASp2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 1 Jun 2010 14:45:28 -0400
In-Reply-To: <AANLkTikAPg1pVfpnH_BSQFyQn2BzUNiGB3tVC2104Ts1@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Henry C Chang <henry_c_chang@tcloudcomputing.com>
Cc: ceph-devel@vger.kernel.org

On Tue, 1 Jun 2010, Henry C Chang wrote:
> We misused list_move_tail() to order the dentry in d_subdirs.
> This will screw up the d_subdirs order.
> 
> This bug can be reliably reproduced by:
> 1. mount ceph fs.
> 2. on ceph fs, git clone git://ceph.newdream.net/git/ceph.git
> 3. Run autogen.sh in ceph directory.
> (Note: Errors only occur at the first time you run autogen.sh.)

This is one of those where it's surprising it worked before as well as it 
did... :)  

Thanks!
sage


> 
> Signed-off-by: Henry C Chang <henry_c_chang@tcloudcomputing.com>
> ---
>  inode.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/inode.c b/inode.c
> index a81b8b6..72903a1 100644
> --- a/inode.c
> +++ b/inode.c
> @@ -827,7 +827,7 @@ static void ceph_set_dentry_offset(struct dentry *dn)
> 
>         spin_lock(&dcache_lock);
>         spin_lock(&dn->d_lock);
> -       list_move_tail(&dir->d_subdirs, &dn->d_u.d_child);
> +       list_move(&dn->d_u.d_child, &dir->d_subdirs);
>         dout("set_dentry_offset %p %lld (%p %p)\n", dn, di->offset,
>              dn->d_u.d_child.prev, dn->d_u.d_child.next);
>         spin_unlock(&dn->d_lock);
> --
> 1.6.5.2
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
