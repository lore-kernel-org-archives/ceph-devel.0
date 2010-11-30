From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: [PATCH] Expose Ceph data location information to Hadoop
Date: Tue, 30 Nov 2010 11:04:59 -0800
Message-ID: <97159B5A-4B38-4251-B376-8033C8A5E599@cs.ucsc.edu>
References: <EEFC0BFD-BF42-4E7E-A905-AB7F53ECE77A@cs.ucsc.edu> <E76027BB-6C82-45D7-813A-E5B850FB5E09@cs.ucsc.edu> <666B47ED-BD76-4344-9728-C95165BD8483@cs.ucsc.edu> <Pine.LNX.4.64.1011300957080.30759@cobra.newdream.net> <922E2470-F2F4-4F5B-A41A-12F233779DCF@cs.ucsc.edu> <Pine.LNX.4.64.1011301049590.30759@cobra.newdream.net>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-01.cse.ucsc.edu ([128.114.48.32]:38513 "EHLO
	mail-01.cse.ucsc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756181Ab0K3TFL convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Nov 2010 14:05:11 -0500
In-Reply-To: <Pine.LNX.4.64.1011301049590.30759@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: =?utf-8?Q?Alex=E2=80=8E_Nelson?= <ajnelson@cs.ucsc.edu>, Noah Watkins <jayhawk@soe.ucsc.edu>, ceph-devel@vger.kernel.org, Joe Buck <buck@soe.ucsc.edu>, Carlos Maltzahn <carlosm@soe.ucsc.edu>

> Are we sure JNI is a real problem?  It really seems like the right tool 
> for the job.  Greg seems to remember them asking who would maintain the 
> (non-java) JNI bits, but even if that's us and not them (which is probably 
> the way to go anyway), I don't see that that's a problem.

Yeh, it's sort of a wash. A nice goal would be to have a patch that allowed Hadoop to not require any additional components (i.e. JNI packages) from the Ceph repository. Given that the Ceph infrastructure will be installed anyway in the case of Hadoop, it's a bit of a toss up.

-n

> Let's start with just providing the primary replica, at least until we 
> find out whether hadoop takes advantage of additional ones (does HDFS read 
> from the local non-primary replica?).

I believe that Hadoop will schedule a map job on at a local replica for load balancing, or to duplicate the work when a map is running slowly. Joe, can you confirm this?

