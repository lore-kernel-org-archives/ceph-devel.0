From: Sage Weil <sage@inktank.com>
Subject: Re: erasure coding (sorry)
Date: Thu, 18 Apr 2013 13:47:54 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1304181345300.10005@cobra.newdream.net>
References: <20130418162842.0c61d1e2@dieter-t420s>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:49785 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936581Ab3DRUry (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 18 Apr 2013 16:47:54 -0400
In-Reply-To: <20130418162842.0c61d1e2@dieter-t420s>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Plaetinck, Dieter" <dieter@vimeo.com>
Cc: ceph-devel@vger.kernel.org

On Thu, 18 Apr 2013, Plaetinck, Dieter wrote:
> sorry to bring this up again, googling revealed some people don't like the subject [anymore].
> 
> but I'm working on a new +- 3PB cluster for storage of immutable files.
> and it would be either all cold data, or mostly cold. 150MB avg filesize, max size 5GB (for now)
> For this use case, my impression is erasure coding would make a lot of sense
> (though I'm not sure about the computational overhead on storing and loading objects..? outbound traffic would peak at 6 Gbps, but I can make it way less and still keep a large cluster, by taking away the small set of hot files.
> inbound traffic would be minimal)
> 
> I know that the answer a while ago was "no plans to implement erasure coding", has this changed?
> if not, is anyone aware of a similar system that does support it? I found QFS but that's meant for batch processing, has a single 'namenode' etc.

We would love to do it, but it is not a priority at the moment (things 
like multi-site replication are in much higher demand).  That of course 
doesn't prevent someone outside of Inktank from working on it :)

The main caveat is that it will be complicate.  For an initial 
implementation, the full breadth of the rados API probably wouldn't be 
support for erasure/parity encoded pools (thinkgs like rados classes and 
the omap key/value api get tricky when you start talking about parity). 
But for many (or even most) use cases, objects are just bytes, and those 
restrictions are just fine.

sage
