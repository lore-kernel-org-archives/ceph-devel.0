From: "Matt W. Benjamin" <matt@linuxbox.com>
Subject: Re: wip-libcephfs-firefly-rb
Date: Sat, 8 Feb 2014 19:27:28 -0500 (EST)
Message-ID: <344869287.15.1391905648502.JavaMail.root@thunderbeast.private.linuxbox.com>
References: <alpine.DEB.2.00.1402081535530.17892@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from aa.linuxbox.com ([69.128.83.226]:1446 "EHLO aa.linuxbox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751287AbaBIA1c (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 8 Feb 2014 19:27:32 -0500
In-Reply-To: <alpine.DEB.2.00.1402081535530.17892@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

It looks to me like the rebase was already done--I thought Casey needed me to finish that up,
but everything just built for me.

Matt

----- "Sage Weil" <sage@inktank.com> wrote:

> Hey Matt, Casey,
> 
> This is great news!  Please let me know as soon as the rebase is ready
> and 
> there is a pull-request so I get this run through the test suite. 
> This is 
> the last week before the firefly freeze and it would be great to get
> this 
> libcephfs API update into that release.
> 
> sage
> 
> On Fri, 7 Feb 2014, Matt W. Benjamin wrote:
> 
> > Hi Sage and Ceph devs,
> > 
> > Casey over here root-caused and we believe fixed the refcounting
> problem on our wip-libcephfs branch, and
> > a rebase to firefly is in progress.
> > 
> > The fix is on wip-libcephfs-firefly-rb :
> > 
> > """
> > fuse: fix for missing ll_ref on create
> > when the 'Inode **outp' argument was added to ll_create(), it was
> > changed to only take the ll_ref if outp was not NULL.
> fuse_ll_create()
> > was calling ll_create() with outp=NULL, and subsequently calling
> > fuse_reply_create() (which causes fuse to increment the lookup
> count)
> > without registering the initial ll_ref
> > 
> > this patch adds a dummy inode pointer i2 to the ll_create() call to
> > claim our initial reference
> > 
> > Signed-off-by: Casey Bodley <casey@linuxbox.com>
> > """
> > 
> > We're still finishing up the rebase, but I expect to have one tested
> by some time tomorrow am.
> > 
> > Thanks,
> > 
> > Matt
> > 
> > -- 
> > Matt Benjamin
> > The Linux Box
> > 206 South Fifth Ave. Suite 150
> > Ann Arbor, MI  48104
> > 
> > http://linuxbox.com
> > 
> > tel.  734-761-4689 
> > fax.  734-769-8938 
> > cel.  734-216-5309 
> > --
> > To unsubscribe from this list: send the line "unsubscribe
> ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Matt Benjamin
The Linux Box
206 South Fifth Ave. Suite 150
Ann Arbor, MI  48104

http://linuxbox.com

tel.  734-761-4689 
fax.  734-769-8938 
cel.  734-216-5309 
