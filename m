From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH v2 0/5] ceph: fixes for nfs export
Date: Fri, 7 Mar 2014 07:03:35 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1403070657430.24219@cobra.newdream.net>
References: <1394183077-399-1-git-send-email-zheng.z.yan@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42517 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752302AbaCGPDg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 7 Mar 2014 10:03:36 -0500
In-Reply-To: <1394183077-399-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: ceph-devel@vger.kernel.org

On Fri, 7 Mar 2014, Yan, Zheng wrote:
> Changes since v1:
>  make ceph_fh_to_parent() use LOOKUPPARENT to find parent dentry.
>  if LOOKUPPARENT fails, retry finding the dentry that corresponds
>  to the 'parent_ino'

Okay, all of these changes finally make sense to me now (Thanks, Zheng and 
Christoph).

My only concern now is that the way that get_name is using LOOKUPINO feels 
like it is overloading the existing operation in an awkward way.  Normally 
LOOKUPINO is used when we have an ino but no reference/cap, and returns 
just the cap for the ino.  LOOKUPPARENT works similarly now where it 
returns just a cap for the parent directory but no connecting dentry; that 
makes sense now too.

In the case of get_name, though, if I am following, we have both a cap on 
the directory and the child inode and just need the connecting dentry.  It 
seems like we are better off with a new MDS op that does exactly that 
instead of making LOOKUPINO's behavior change wildly due to a flag (as in

https://github.com/ceph/ceph/commit/3cb6168b0285acfa39c1895bc4dcf6fee408ae4b#diff-eecf840e09d7481f7b8f415789852c7dR2386

).  We should make the client get_name handle EOPNOTSUPP by translating 
to ESTALE, probably, in case the MDS is old.

This a bit more work, but I think it'll keep the semantics for all of 
these ops cleaner.  What do you think?

(And sorry I'm still catching up here!  This would have been more useful 
feedback 2 days ago.)

sage
