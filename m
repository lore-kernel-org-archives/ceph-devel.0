From: Sage Weil <sage@newdream.net>
Subject: Re: Possible bug when getting batched xattrs
Date: Fri, 17 Oct 2014 07:02:53 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1410170659530.10837@cobra.newdream.net>
References: <5440E131.2020501@cern.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:59801 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751846AbaJQOCx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 17 Oct 2014 10:02:53 -0400
In-Reply-To: <5440E131.2020501@cern.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Joaquim Rocha <joaquim.rocha@cern.ch>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Fri, 17 Oct 2014, Joaquim Rocha wrote:
> Hi,
> 
> I need to get a list of xattrs from one object (so I'm batching them in one
> ObjectReadOperation) but I don't know in advance if all of those xattrs exist.
> 
> I was expecting to figure out the ones that don't exist from the return code
> of each getxattr call but I have however noticed that as soon one nonexistent
> xattr is processed, its return code gets correctly set to -ENODATA but the
> remaining xattrs are never checked. And what is worse, the remaining getxattr
> op's return codes get assigned to 0.
> 
> I am attaching a small test case I've quickly written that proves the case. (I
> am using Ceph 0.80.5)
> 
> Could you confirm that this is not the intended behavior (that all read op's
> calls should be processed)?

This is by design.

What you want is the 

    void set_op_flags(ObjectOperationFlags flags);

method on the ObjectOperation, and the OP_FAILOK flag.  That will set a 
bit on the last op (getxattr) you added that will make processing continue 
even if it got an error.  Then you'll get the behavior you were 
looking for.

sage
