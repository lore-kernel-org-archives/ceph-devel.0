From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: [PATCH] Expose Ceph data location information to Hadoop
Date: Tue, 30 Nov 2010 10:32:22 -0800
Message-ID: <922E2470-F2F4-4F5B-A41A-12F233779DCF@cs.ucsc.edu>
References: <EEFC0BFD-BF42-4E7E-A905-AB7F53ECE77A@cs.ucsc.edu> <E76027BB-6C82-45D7-813A-E5B850FB5E09@cs.ucsc.edu> <666B47ED-BD76-4344-9728-C95165BD8483@cs.ucsc.edu> <Pine.LNX.4.64.1011300957080.30759@cobra.newdream.net>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-01.cse.ucsc.edu ([128.114.48.32]:52298 "EHLO
	mail-01.cse.ucsc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751202Ab0K3ScX convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Nov 2010 13:32:23 -0500
In-Reply-To: <Pine.LNX.4.64.1011300957080.30759@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: =?utf-8?Q?Alex=E2=80=8E_Nelson?= <ajnelson@cs.ucsc.edu>, Noah Watkins <jayhawk@soe.ucsc.edu>, ceph-devel@vger.kernel.org, Joe Buck <buck@soe.ucsc.edu>, Carlos Maltzahn <carlosm@soe.ucsc.edu>

> Yeah, not pretty.  A shared library wouldn't really help here either, 
> right?  And a command-line tool means additional overhead.  JNI (or 
> equivalent) calling an ioctl seems like the most appropriate tool.

I like the motivation behind the command-line tool, but agree with you on the overhead issues. The only other method for arbitrary communication between processes that comes to mind for this situation is a socket-based approach.

This could take two forms:

1) A user-space daemon to service requests from Hadoop
2) A socket between kernel and user-space to service requests.

The former is unattractive because it requires additional client setup, while the latter also poses challenges. However, If this approach seems attractive we could begin to experiment with the second option it in DebugFS to avoid ABI lock in?

One thing all solutions have in common is that the cost on the Hadoop end is a one-time cost. While overhead is important a number of inefficient lookups may easily be masked by the start-up costs associated with Hadoop's infrastructure.

> 
>>> The ioctl struct ceph_ioctl_dataloc already returns the primary copy's 
>>> object offset for an input file offset, though I think it would be a 
>>> little more useful if it included replica offsets.
>> I can submit a patch for this. Sage, I remember you mentioning that 
>> reading from replicas might pose (scalability?) problems. Any thoughts 
>> on this?
> 
> There are two things.  First, we'd need a DATALOC_V2 ioctl that would 
> return locations for all replicas of the object.  Is Hadoop smart about 
> scheduling jobs on the best replica?

Good question. I'm not sure what its scheduling policy is, but replica location is a key component of the Hadoop API, providing the information to the scheduler by default.

> Before going to the trouble, though, I want to make sure we'll really 
> benefit from all of that...

I agree. This enhancement is orthogonal to the overall design.

Thanks,
Noah

