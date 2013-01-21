From: Sage Weil <sage@inktank.com>
Subject: Re: Hit suicide timeout after adding new osd
Date: Sun, 20 Jan 2013 23:11:43 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1301202310260.29915@cobra.newdream.net>
References: <50F80C3A.9020007@mermaidconsulting.dk> <50F80EFF.7020803@widodh.nl> <50F80FA0.5010504@profihost.ag> <50F819B8.4070004@widodh.nl> <50F81A9F.2090104@profihost.ag> <alpine.DEB.2.00.1301170916420.10574@cobra.newdream.net> <50F85FEC.7030305@mermaidconsulting.dk>
 <alpine.DEB.2.00.1301171402130.21470@cobra.newdream.net> <50F930EE.9070201@mermaidconsulting.dk> <alpine.DEB.2.00.1301181327580.8622@cobra.newdream.net> <50F9C051.7070900@mermaidconsulting.dk> <alpine.DEB.2.00.1301181342410.8622@cobra.newdream.net>
 <50FA6681.10507@mermaidconsulting.dk> <alpine.DEB.2.00.1301190737110.29915@cobra.newdream.net> <50FADE65.5050403@mermaidconsulting.dk> <alpine.DEB.2.00.1301191016320.29915@cobra.newdream.net> <50FAE8AB.5000602@mermaidconsulting.dk>
 <alpine.DEB.2.00.1301201613130.31658@cobra.newdream.net> <50FCE759.9070309@mermaidconsulting.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45949 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751365Ab3AUHLn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 Jan 2013 02:11:43 -0500
In-Reply-To: <50FCE759.9070309@mermaidconsulting.dk>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-15?Q?Jens_Kristian_S=F8gaard?= <jens@mermaidconsulting.dk>
Cc: Stefan Priebe <s.priebe@profihost.ag>, Wido den Hollander <wido@widodh.nl>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, 21 Jan 2013, Jens Kristian S?gaard wrote:
> Hi Sage,
> 
> > If you have the core from the second instance of the heartbeat timeout, from
> > the wip-pg-removal branch, please post the 'thread apply all bt' output.
> 
> Here's the thread stack traces:
> 
> http://bit.ly/XrGeca
> 
> And here's the logs (debug=20) from same crash:
> 
> http://bit.ly/WyltfU

Followed up on IRC, but for everyone else's benefit:

I think the problem now is just that 'osd target transaction size' is too 
big (default is 300).  Recommended 50.. let's see how that goes.  Even 
smaller (20 or 25) would probably be fine.

Let me know how it goes!

Thanks-
sage
