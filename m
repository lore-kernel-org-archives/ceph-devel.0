From: Sage Weil <sage@inktank.com>
Subject: Re: wip-libcephfs-rebased-v65 ready for pull
Date: Thu, 11 Jul 2013 11:50:59 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1307111149050.5149@cobra.newdream.net>
References: <289628364.92.1373483961468.JavaMail.root@thunderbeast.private.linuxbox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44246 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756475Ab3GKSu7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 11 Jul 2013 14:50:59 -0400
In-Reply-To: <289628364.92.1373483961468.JavaMail.root@thunderbeast.private.linuxbox.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Matt W. Benjamin" <matt@linuxbox.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

I've rebased this on master, and cherry-picked the fixes from Ilya on top.  
The exception is the xattr changes, which turned out to be an MDS bug 
turned by up the unit test.

Is there a particular need for this to be in dumpling?  I'm inclined to 
delay a release to avoid potentially destabliizing things this late in the 
game.

Thanks!
sage


On Wed, 10 Jul 2013, Matt W. Benjamin wrote:

> Hi,
> 
> We tracked down the refcount issue found Sat., and have rebased/pushed wip-libcephfs-rebased-v65
> with the fix.
> 
> Thanks!
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
