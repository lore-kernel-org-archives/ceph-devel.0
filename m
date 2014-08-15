From: Sage Weil <sweil@redhat.com>
Subject: Re: any reason why multiple ranged-reads not currently supported in
 rados-java?
Date: Fri, 15 Aug 2014 08:40:35 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1408150839460.966@cobra.newdream.net>
References: <CAAmmvixquAW-s5td03UpnEhFDWujAWServHgehKzrYHRs+dsBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:39903 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750954AbaHOPkf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Aug 2014 11:40:35 -0400
In-Reply-To: <CAAmmvixquAW-s5td03UpnEhFDWujAWServHgehKzrYHRs+dsBg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Daniel Hsueh <dchsueh@alumni.uwaterloo.ca>
Cc: ceph-devel@vger.kernel.org, wido@widodh.nl

On Fri, 15 Aug 2014, Daniel Hsueh wrote:
> Hello,
> 
> I'm looking at the Java librados JNA-based API, and note that ranged
> reads (rados_create_read_op, rados_release_read_op,
> rados_read_op_read, rados_read_op_operate) are not currently
> accessible to a Java program.
>
> Are there any difficulties in implementing access to these calls?  If
> it is straightforward, I'll implement them myself and contribute back
> to the github repository.

My guess is this was just an oversight.  A patch / pull request wiring 
this up would be awesome.

Thanks!
sage
