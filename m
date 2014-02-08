From: Sage Weil <sage@inktank.com>
Subject: Re: wip-libcephfs-firefly-rb
Date: Sat, 8 Feb 2014 15:36:52 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1402081535530.17892@cobra.newdream.net>
References: <256713015.152.1391817730841.JavaMail.root@thunderbeast.private.linuxbox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33646 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751170AbaBHXgx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 8 Feb 2014 18:36:53 -0500
In-Reply-To: <256713015.152.1391817730841.JavaMail.root@thunderbeast.private.linuxbox.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Matt W. Benjamin" <matt@linuxbox.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hey Matt, Casey,

This is great news!  Please let me know as soon as the rebase is ready and 
there is a pull-request so I get this run through the test suite.  This is 
the last week before the firefly freeze and it would be great to get this 
libcephfs API update into that release.

sage

On Fri, 7 Feb 2014, Matt W. Benjamin wrote:

> Hi Sage and Ceph devs,
> 
> Casey over here root-caused and we believe fixed the refcounting problem on our wip-libcephfs branch, and
> a rebase to firefly is in progress.
> 
> The fix is on wip-libcephfs-firefly-rb :
> 
> """
> fuse: fix for missing ll_ref on create
> when the 'Inode **outp' argument was added to ll_create(), it was
> changed to only take the ll_ref if outp was not NULL. fuse_ll_create()
> was calling ll_create() with outp=NULL, and subsequently calling
> fuse_reply_create() (which causes fuse to increment the lookup count)
> without registering the initial ll_ref
> 
> this patch adds a dummy inode pointer i2 to the ll_create() call to
> claim our initial reference
> 
> Signed-off-by: Casey Bodley <casey@linuxbox.com>
> """
> 
> We're still finishing up the rebase, but I expect to have one tested by some time tomorrow am.
> 
> Thanks,
> 
> Matt
> 
> -- 
> Matt Benjamin
> The Linux Box
> 206 South Fifth Ave. Suite 150
> Ann Arbor, MI  48104
> 
> http://linuxbox.com
> 
> tel.  734-761-4689 
> fax.  734-769-8938 
> cel.  734-216-5309 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
