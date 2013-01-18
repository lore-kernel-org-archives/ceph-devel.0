From: Sage Weil <sage@inktank.com>
Subject: Re: Hit suicide timeout after adding new osd
Date: Fri, 18 Jan 2013 13:44:25 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1301181342410.8622@cobra.newdream.net>
References: <50F80C3A.9020007@mermaidconsulting.dk> <50F80EFF.7020803@widodh.nl> <50F80FA0.5010504@profihost.ag> <50F819B8.4070004@widodh.nl> <50F81A9F.2090104@profihost.ag> <alpine.DEB.2.00.1301170916420.10574@cobra.newdream.net> <50F85FEC.7030305@mermaidconsulting.dk>
 <alpine.DEB.2.00.1301171402130.21470@cobra.newdream.net> <50F930EE.9070201@mermaidconsulting.dk> <alpine.DEB.2.00.1301181327580.8622@cobra.newdream.net> <50F9C051.7070900@mermaidconsulting.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:50237 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751885Ab3ARVoZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 18 Jan 2013 16:44:25 -0500
In-Reply-To: <50F9C051.7070900@mermaidconsulting.dk>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-15?Q?Jens_Kristian_S=F8gaard?= <jens@mermaidconsulting.dk>
Cc: Stefan Priebe <s.priebe@profihost.ag>, Wido den Hollander <wido@widodh.nl>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, 18 Jan 2013, Jens Kristian S?gaard wrote:
> Hi,
> 
> > Getting closer.. it looks like someone is blocked with map_lock held, or
> > leaked the lock.  Can you do a 'thread apply all bt' with that same core
> > file/process?
> 
> Sure, here's the result:

Ah, I think it's the PG removal workqueue being unfriendly.  Annoyingly I 
made a kludge around this for another cluster hitting it and then forgot 
to get it integrated.  Can you give wip-pg-removal a go and see if that 
resolves the problem?

It's building right now.. packages should show up shortly on 
gitbuilder.ceph.com once it goes green here

	http://ceph.com/gitbuilder.cgi

Thanks!
sage
