From: Sage Weil <sweil@redhat.com>
Subject: Re: Ceph & non-root
Date: Fri, 19 Jun 2015 18:22:42 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1506191820150.15686@cobra.newdream.net>
References: <5584463E.3090003@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34012 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753535AbbFTBWp (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 19 Jun 2015 21:22:45 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (Postfix) with ESMTPS id 330F92DC40F
	for <ceph-devel@vger.kernel.org>; Sat, 20 Jun 2015 01:22:45 +0000 (UTC)
In-Reply-To: <5584463E.3090003@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Milan Broz <mbroz@redhat.com>
Cc: Boris Ranto <branto@redhat.com>, ceph-devel@vger.kernel.org

[copying ceph-devel]

On Fri, 19 Jun 2015, Milan Broz wrote:
> Hi Sage,
> 
> we are trying to test what still need to be done
> to run ceph daemons with enforcing selinux and also
> under user ceph (I still prefer to test these two together).
> 
> And there is one problem which will need some more deep
> logic changes.
> 
> I am using ceph-deploy, which run everything as root.
> 
> There are initial operations, like ceph-mon --mkfs
> that create files as root, so following daemon running under
> ceph user cannot access them.
> 
> And we do not we want to modify ceph-deploy, I guess.
> 
> So how to solve these problems -  the only way to setup
> user is through --setuser & --setgroup now.
> 
> Shouldn't be this in ceph.conf (so ceph-deploy will run
> almost without change)?
> (There will more such things, probably create-keys etc.)
> 
> Suid but is not a good idea, it is usually security nightmare,
> Set group bit on directory is not enough (but it could be fixed perhaps).

I think a requirement is that, by default, with new packages, everything 
is user ceph, without requiring the user to make ceph.conf changes.  We 
are effectively changing the 'user' option's default value in ceph.conf 
from root to ceph (although I'm not sure it is honored :).

How about this: ceph-deploy checks whether /var/lib/ceph is owned by root 
or by ceph, and executes the mkfs step as either root or ceph based on 
that?
 
> We already have OSD block partitions owned by ceph user
> (this is easy udev rule modification) and some rules in rpm
> for testing but the above is something which must be fixed
> by design...

Oh, excellent!  This was my biggest concern.

sage
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
