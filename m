From: Sage Weil <sage@inktank.com>
Subject: Re: Hit suicide timeout after adding new osd
Date: Thu, 24 Jan 2013 10:06:01 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1301241004590.13935@cobra.newdream.net>
References: <50F80C3A.9020007@mermaidconsulting.dk> <alpine.DEB.2.00.1301170916420.10574@cobra.newdream.net> <50F85FEC.7030305@mermaidconsulting.dk> <alpine.DEB.2.00.1301171402130.21470@cobra.newdream.net> <50F930EE.9070201@mermaidconsulting.dk>
 <alpine.DEB.2.00.1301181327580.8622@cobra.newdream.net> <50F9C051.7070900@mermaidconsulting.dk> <alpine.DEB.2.00.1301181342410.8622@cobra.newdream.net> <50FA6681.10507@mermaidconsulting.dk> <alpine.DEB.2.00.1301190737110.29915@cobra.newdream.net>
 <50FADE65.5050403@mermaidconsulting.dk> <alpine.DEB.2.00.1301191016320.29915@cobra.newdream.net> <50FAE8AB.5000602@mermaidconsulting.dk> <alpine.DEB.2.00.1301201613130.31658@cobra.newdream.net> <50FCE759.9070309@mermaidconsulting.dk>
 <alpine.DEB.2.00.1301202310260.29915@cobra.newdream.net> <50FFD420.7000604@mermaidconsulting.dk> <51004F2A.2010009@mermaidconsulting.dk> <alpine.DEB.2.00.1301232028170.10201@cobra.newdream.net> <51010812.6000908@mermaidconsulting.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:38109 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751893Ab3AXSGC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Jan 2013 13:06:02 -0500
In-Reply-To: <51010812.6000908@mermaidconsulting.dk>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-15?Q?Jens_Kristian_S=F8gaard?= <jens@mermaidconsulting.dk>
Cc: Stefan Priebe <s.priebe@profihost.ag>, Wido den Hollander <wido@widodh.nl>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, 24 Jan 2013, Jens Kristian S?gaard wrote:
> Hi Sage,
> 
> > Can you share the output from 'thread apply all bt' so we can see what it
> > was doing?
> 
> Yes, ofcourse!
> 
> You can download the output here:
> 
> http://bit.ly/UY7TDe

Sadly your problem is a bit different than Andrey's.  It looks like maybe 
it's just busy, its hard to tell from the snapshot in the stack traces.  
If you can enable some logs leading up to the crash, that'd be awesome.

Thanks!
sage
