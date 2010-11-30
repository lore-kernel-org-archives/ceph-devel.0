From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: [PATCH] Expose Ceph data location information to Hadoop
Date: Tue, 30 Nov 2010 09:17:01 -0800
Message-ID: <3F84686D-FB7B-4D7E-A893-8FA35FF5080D@cs.ucsc.edu>
References: <EEFC0BFD-BF42-4E7E-A905-AB7F53ECE77A@cs.ucsc.edu> <Pine.LNX.4.64.1011300852460.4337@cobra.newdream.net>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-01.cse.ucsc.edu ([128.114.48.32]:36338 "EHLO
	mail-01.cse.ucsc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753752Ab0K3RRD convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Nov 2010 12:17:03 -0500
In-Reply-To: <Pine.LNX.4.64.1011300852460.4337@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org, Joe Buck <buck@soe.ucsc.edu>, Carlos Maltzahn <carlosm@soe.ucsc.edu>

> Well, the ioctl interface is fixed (Linux kernel ABI rules), so there is 
> no danger in relying on it.  In the end it'll be more work to create a 
> separate library that just wraps the ioctls, and any change in the layout 
> scheme that would motivate e.g. a new v2 ioctl would also mean updating 
> the library, leaving you with the same backward compatibility issues we 
> started with.  In the end whether it's an ioctl(2) call or a shared 
> library call is mostly a matter of syntax; the underlying data passed by 
> the interface is the same.

I agree that the stability of the ABI isn't an issue, but maybe I wasn't clear enough.

Currently the data location IOCTL is used in Hadoop to map a offset to an object location, thus it is necessary for Hadoop to generate a set of offsets that fall into distinct object boundaries in order to collect a list of object locations that should run map tasks.

The problem is that in order to generate this list of offsets, the striping strategy must be taken into consideration in Hadoop (as shown in the original version of this email). Currently this means that the logic of "ceph_calc_file_object_mapping(...)" in the client must be synchronized with the Hadoop code base, something that is unnecessary. Rather than duplicating this logic, a better solution seems to be to expand the Ceph IOCTL interface to include functionality for retrieving object locations or at the very least, a set of candidate offsets. This would allow the client to hide the striping strategy from Hadoop.

Whether or not this is an IOCTL that expands the ABI, or a user-level library that contains the striping strategy logic seems to be a decision for someone else, but the important thing is that striping strategy logic doesn't get distributed into arbitrary code bases such as Hadoop, requiring synchronization.

Thanks,
Noah