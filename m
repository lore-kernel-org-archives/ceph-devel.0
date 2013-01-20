From: Sage Weil <sage@inktank.com>
Subject: Re: questions on networks and hardware
Date: Sun, 20 Jan 2013 11:03:17 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1301201102240.29915@cobra.newdream.net>
References: <EFFE82E1-B74B-4DAB-8801-5311FA903618@jnielsen.net> <50FC2682.3020601@widodh.nl> <50FC3CED.8000509@profihost.ag>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40902 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752221Ab3ATTDS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 20 Jan 2013 14:03:18 -0500
In-Reply-To: <50FC3CED.8000509@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: Wido den Hollander <wido@widodh.nl>, John Nielsen <lists@jnielsen.net>, ceph-devel@vger.kernel.org

On Sun, 20 Jan 2013, Stefan Priebe wrote:
> Hi,
> 
> Am 20.01.2013 18:16, schrieb Wido den Hollander:
> > > If I have "cluster network" and "public network" entries under
> > > [global] or [osd], do I still need to specify "public addr" and
> > > "cluster addr" for each OSD individually?
> > > 
> > Already answered, but no. You don't need to. The OSDs will bind to the
> > available IP in that network.
> 
> What happens if there are more than one IP available in that network?

It'll take either the first or last one returned by the kernel.. you'd 
have to check the code to know which.  If you need finer control than 
that, 'public addr' and 'cluster addr' are there :)

sage

