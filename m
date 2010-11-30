From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH] Expose Ceph data location information to Hadoop
Date: Tue, 30 Nov 2010 11:01:17 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1011301049590.30759@cobra.newdream.net>
References: <EEFC0BFD-BF42-4E7E-A905-AB7F53ECE77A@cs.ucsc.edu>
 <E76027BB-6C82-45D7-813A-E5B850FB5E09@cs.ucsc.edu>
 <666B47ED-BD76-4344-9728-C95165BD8483@cs.ucsc.edu>
 <Pine.LNX.4.64.1011300957080.30759@cobra.newdream.net>
 <922E2470-F2F4-4F5B-A41A-12F233779DCF@cs.ucsc.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:53421 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751117Ab0K3S4l (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Nov 2010 13:56:41 -0500
In-Reply-To: <922E2470-F2F4-4F5B-A41A-12F233779DCF@cs.ucsc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@cs.ucsc.edu>
Cc: =?utf-8?Q?Alex=E2=80=8E_Nelson?= <ajnelson@cs.ucsc.edu>, Noah Watkins <jayhawk@soe.ucsc.edu>, ceph-devel@vger.kernel.org, Joe Buck <buck@soe.ucsc.edu>, Carlos Maltzahn <carlosm@soe.ucsc.edu>

On Tue, 30 Nov 2010, Noah Watkins wrote:
> > Yeah, not pretty.  A shared library wouldn't really help here either, 
> > right?  And a command-line tool means additional overhead.  JNI (or 
> > equivalent) calling an ioctl seems like the most appropriate tool.
> 
> I like the motivation behind the command-line tool, but agree with you 
> on the overhead issues. The only other method for arbitrary 
> communication between processes that comes to mind for this situation is 
> a socket-based approach.
> 
> This could take two forms:
> 
> 1) A user-space daemon to service requests from Hadoop
> 2) A socket between kernel and user-space to service requests.
> 
> The former is unattractive because it requires additional client setup, 
> while the latter also poses challenges. However, If this approach seems 
> attractive we could begin to experiment with the second option it in 
> DebugFS to avoid ABI lock in?

Well, if the goal is just to get something working to test, then I would 
use JNI and use the ioctl; whether it can go upstream easily isn't 
relevant.  If the goal is something that can go upstream, then it 
needs a stable ABI, and debugfs isn't really a solution there either.  

Are we sure JNI is a real problem?  It really seems like the right tool 
for the job.  Greg seems to remember them asking who would maintain the 
(non-java) JNI bits, but even if that's us and not them (which is probably 
the way to go anyway), I don't see that that's a problem.

> >>> The ioctl struct ceph_ioctl_dataloc already returns the primary copy's 
> >>> object offset for an input file offset, though I think it would be a 
> >>> little more useful if it included replica offsets.
> >> I can submit a patch for this. Sage, I remember you mentioning that 
> >> reading from replicas might pose (scalability?) problems. Any thoughts 
> >> on this?
> > 
> > There are two things.  First, we'd need a DATALOC_V2 ioctl that would 
> > return locations for all replicas of the object.  Is Hadoop smart about 
> > scheduling jobs on the best replica?
> 
> Good question. I'm not sure what its scheduling policy is, but replica 
> location is a key component of the Hadoop API, providing the information 
> to the scheduler by default.

Let's start with just providing the primary replica, at least until we 
find out whether hadoop takes advantage of additional ones (does HDFS read 
from the local non-primary replica?).

sage


> 
> > Before going to the trouble, though, I want to make sure we'll really 
> > benefit from all of that...
> 
> I agree. This enhancement is orthogonal to the overall design.
> 
> Thanks,
> Noah
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

