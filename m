From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH] Expose Ceph data location information to Hadoop
Date: Tue, 30 Nov 2010 08:59:11 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1011300852460.4337@cobra.newdream.net>
References: <EEFC0BFD-BF42-4E7E-A905-AB7F53ECE77A@cs.ucsc.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57971 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754478Ab0K3Qyg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Nov 2010 11:54:36 -0500
In-Reply-To: <EEFC0BFD-BF42-4E7E-A905-AB7F53ECE77A@cs.ucsc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@cs.ucsc.edu>
Cc: ceph-devel@vger.kernel.org, Joe Buck <buck@soe.ucsc.edu>, Carlos Maltzahn <carlosm@soe.ucsc.edu>

On Mon, 29 Nov 2010, Noah Watkins wrote:
> What is a Hadoop Block in Ceph?
> ==========================
> 
> Hadoop considers blocks to be contiguous extents, however, from the 
> above example we can see that an object can have data from multiple, 
> non-consecutive, contiguous extents, thus the object itself doesn't 
> represent a fully contiguous extent.
> 
> The more natural (and general) solution is to consider the stripe unit 
> to be the _unit_ of Hadoop blocks, not entire objects. When stripe unit 
> and block size are the same the result is analogous to HDFS's treatment 
> of blocks.

Yeah, I would lean toward using the stripe unit as the "block" here.

> Design Suggestion
> ===============
> 
> I would propose moving the functionality of mapping offsets to object 
> locations into a library managed in the Ceph tree, and either 1) use JNI 
> as a thin layer to this library, or 2) scrap JNI altogether for JNA.
> 
> Either way, the motivation for moving this functionality into the Ceph 
> tree is important because from the point of view of Hadoop object/block 
> location is independent of striping strategy. Future Ceph enhancements 
> and research may use alternative striping strategies which would thus 
> have to be re-duplicated into the Hadoop code base.

Well, the ioctl interface is fixed (Linux kernel ABI rules), so there is 
no danger in relying on it.  In the end it'll be more work to create a 
separate library that just wraps the ioctls, and any change in the layout 
scheme that would motivate e.g. a new v2 ioctl would also mean updating 
the library, leaving you with the same backward compatibility issues we 
started with.  In the end whether it's an ioctl(2) call or a shared 
library call is mostly a matter of syntax; the underlying data passed by 
the interface is the same.

sage
