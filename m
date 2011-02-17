From: Sage Weil <sage@newdream.net>
Subject: Re: cosd multi-second stalls cause "wrongly marked me down"
Date: Wed, 16 Feb 2011 16:54:41 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1102161651380.11150@cobra.newdream.net>
References: <1297891508.25491.120.camel@sale659.sandia.gov>
 <75157CFDA63D45458FC47FB7BA6CB974@gmail.com> <1297893011.25491.124.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1102161649560.11150@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57234 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755768Ab1BQAxW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Feb 2011 19:53:22 -0500
In-Reply-To: <Pine.LNX.4.64.1102161649560.11150@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: Gregory Farnum <gregory.farnum@dreamhost.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, 16 Feb 2011, Sage Weil wrote:
> shouldn't affect anything.  We may have missed something.. do you have a 
> log showing this in action?

Obviously yes, looking at your original email.  :)  At the beginning of 
each log line we include a thread id.  What would be really helpful would 
be to narrow down where in OSD::heartbeat_entry() and heartbeat() things 
are blocking, either based on the existing output, or by adding additional 
dout lines at interesting points in time.

sage
