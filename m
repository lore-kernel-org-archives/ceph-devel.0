From: Sage Weil <sage@inktank.com>
Subject: Re: Hit suicide timeout after adding new osd
Date: Thu, 17 Jan 2013 14:03:43 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1301171402130.21470@cobra.newdream.net>
References: <50F80C3A.9020007@mermaidconsulting.dk> <50F80EFF.7020803@widodh.nl> <50F80FA0.5010504@profihost.ag> <50F819B8.4070004@widodh.nl> <50F81A9F.2090104@profihost.ag> <alpine.DEB.2.00.1301170916420.10574@cobra.newdream.net>
 <50F85FEC.7030305@mermaidconsulting.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36846 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752293Ab3AQWDo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Jan 2013 17:03:44 -0500
In-Reply-To: <50F85FEC.7030305@mermaidconsulting.dk>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-15?Q?Jens_Kristian_S=F8gaard?= <jens@mermaidconsulting.dk>
Cc: Stefan Priebe <s.priebe@profihost.ag>, Wido den Hollander <wido@widodh.nl>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Jens-

On Thu, 17 Jan 2013, Jens Kristian S?gaard wrote:
> Hi Sage,
> 
> > The fix for this is in v0.56.1, so I think you are seeing something else.
> > If this is something you can reproduce with 'debug osd = 10' or 20 and
> > 'debug ms = 1', that would be extremely helpful!
> 
> I have set the debug level and restarted the osd. It initialized for about an
> hour and then crashed after 5 minutes with the same error message.
> 
> You can download the full logs here:
> 
> http://bit.ly/WbcSQp
> 
> Thanks for your help!

Unfortunately I can't see what the thread gets stuck doing after it stops 
doing work (at an apparently normal point).  Is there any chance you can 
attach to it with gdb as soon as the log slows down and the initial 
timeout messages appear?  Or check the core file and see what thread 
7fd8c1ff3700 is up to?

Also, 'debug tp = 20' would narrow things down slightly.

Thanks!
sage

