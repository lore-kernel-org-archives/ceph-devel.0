From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH] Expose Ceph data location information to Hadoop
Date: Tue, 30 Nov 2010 10:10:37 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1011300957080.30759@cobra.newdream.net>
References: <EEFC0BFD-BF42-4E7E-A905-AB7F53ECE77A@cs.ucsc.edu>
 <E76027BB-6C82-45D7-813A-E5B850FB5E09@cs.ucsc.edu>
 <666B47ED-BD76-4344-9728-C95165BD8483@cs.ucsc.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36144 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754162Ab0K3SGC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Nov 2010 13:06:02 -0500
In-Reply-To: <666B47ED-BD76-4344-9728-C95165BD8483@cs.ucsc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@cs.ucsc.edu>
Cc: =?utf-8?Q?Alex=E2=80=8E_Nelson?= <ajnelson@cs.ucsc.edu>, Noah Watkins <jayhawk@soe.ucsc.edu>, ceph-devel@vger.kernel.org, Joe Buck <buck@soe.ucsc.edu>, Carlos Maltzahn <carlosm@soe.ucsc.edu>

On Tue, 30 Nov 2010, Noah Watkins wrote:
> > After writing this code, I do like seeing the words "scrap" and "JNI" 
> > so close in the same sentence.  That's more up to the Hadoop 
> > community, though; I don't know how well-accepted JNA is in their code 
> > base.
> One solution might be a lazily populated sysfs interface for retrieving 
> object information for a given file, circumventing the problem Java has 
> calling IOCTLs. But that's another conversation.

Yeah, not pretty.  A shared library wouldn't really help here either, 
right?  And a command-line tool means additional overhead.  JNI (or 
equivalent) calling an ioctl seems like the most appropriate tool.

> > The ioctl struct ceph_ioctl_dataloc already returns the primary copy's 
> > object offset for an input file offset, though I think it would be a 
> > little more useful if it included replica offsets.
> I can submit a patch for this. Sage, I remember you mentioning that 
> reading from replicas might pose (scalability?) problems. Any thoughts 
> on this?

There are two things.  First, we'd need a DATALOC_V2 ioctl that would 
return locations for all replicas of the object.  Is Hadoop smart about 
scheduling jobs on the best replica?

The second part is be able to read from them.  In general, sending any/all 
reads to a random replica does bad things to your cache.  In principle, 
it's possible, though, at least when a file is only opened for read (at 
that point all replicas are known consistent on disk).  Someone suggested 
on IRC a while back that in such a case we have a check to read from a 
non-primary replica if that replica happens to be on the local node.  That 
sort of optimization would work in this case.  A number of changes in the 
OSD and client will be needed, but nothing too invasive (I think!).

Before going to the trouble, though, I want to make sure we'll really 
benefit from all of that...

sage
