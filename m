From: Sage Weil <sage@newdream.net>
Subject: Re: Two patches for ceph-client-standalone
Date: Wed, 22 Sep 2010 20:57:28 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1009222054000.14012@cobra.newdream.net>
References: <AANLkTi=zXDQyFiaqN8HGFjcxA3sY+OrQ7HBwLM+Gvo33@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44979 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752857Ab0IWDzh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 22 Sep 2010 23:55:37 -0400
In-Reply-To: <AANLkTi=zXDQyFiaqN8HGFjcxA3sY+OrQ7HBwLM+Gvo33@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Henry C Chang <henry_c_chang@tcloudcomputing.com>
Cc: ceph-devel@vger.kernel.org

On Thu, 23 Sep 2010, Henry C Chang wrote:
> Hi Sage,
> 
> There are two patches on our github for the ceph-client-standalone.
> Would you also help to take a look at them?
> 
> 1. http://github.com/tcloud/ceph-client-standalone/commit/121810874701393756dc21e4415e9ccf0dfb3b06
> 
> This is another mistake about list_* function series.

Great, fixed this to ceph-client.git.  That's the third one of these now!  
:)

> 2. http://github.com/tcloud/ceph-client-standalone/commit/2c9c3cf2a9234b6b7a2b7e7ee12441d5a82bfb69
> 
> We are using kernel 2.6.32. I am not sure whether all kernel<2.6.35
> have the same behavior.
> We hit this bug when re-exporting ceph via NFS. The NFS client can
> mount ceph successfully,
> but when copying in a file, NULL pointer exception occurs.
> 
> We found that when ceph_dir_fsync(struct file *file, struct dentry
> *dentry, int datasync) is called,
> the "file" pointer passed in is NULL. Thus, we use "dentry" to get the
> inode ptr instead of using "file".

Yeah, your fix looks good.  It should apply to all versions prior to the 
API change (.35?).  Applied this to ceph-client-standalone.git.  Compile 
tested on .27 to .35.

> BTW, could you backport recent patches in ceph-client to 
> ceph-client-standalone?

I've updated the master and master-backport branches.  The unstable branch 
includes the code refactor into multiple modules (libceph, ceph, and rbd), 
which will require some reorganization and changes to my update scripts.

Thanks!
sage

