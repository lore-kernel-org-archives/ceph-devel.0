From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: cosd multi-second stalls cause "wrongly marked me down"
Date: Thu, 17 Feb 2011 08:46:14 -0700
Message-ID: <1297957574.25491.152.camel@sale659.sandia.gov>
References: <1297891508.25491.120.camel@sale659.sandia.gov>
 <75157CFDA63D45458FC47FB7BA6CB974@gmail.com>
 <1297893011.25491.124.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1102161649560.11150@cobra.newdream.net>
 <Pine.LNX.4.64.1102161651380.11150@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-three.sandia.gov ([132.175.109.17]:47083 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756656Ab1BQPqo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Feb 2011 10:46:44 -0500
In-Reply-To: <Pine.LNX.4.64.1102161651380.11150@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Gregory Farnum <gregory.farnum@dreamhost.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Sage,

On Wed, 2011-02-16 at 17:54 -0700, Sage Weil wrote:
> On Wed, 16 Feb 2011, Sage Weil wrote:
> > shouldn't affect anything.  We may have missed something.. do you have a 
> > log showing this in action?
> 
> Obviously yes, looking at your original email.  :)  At the beginning of 
> each log line we include a thread id.  What would be really helpful would 
> be to narrow down where in OSD::heartbeat_entry() and heartbeat() things 
> are blocking, either based on the existing output, or by adding additional 
> dout lines at interesting points in time.

I'll take a deeper look at my existing logs with
that in mind; let me know if you'd like me to
send you some.

I have also been looking at map_lock, as it seems
to be shared between the heartbeat and map update
threads.

Would instrumenting acquiring/releasing that lock
be helpful?  Is there some other lock that may
be more fruitful to instrument?  I can reproduce 
pretty reliably, so adding instrumentation is 
no problem.

-- Jim

> 
> sage
> 


