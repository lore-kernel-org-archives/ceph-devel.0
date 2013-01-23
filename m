From: Sage Weil <sage@inktank.com>
Subject: Re: Hit suicide timeout after adding new osd
Date: Wed, 23 Jan 2013 05:13:38 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1301230510060.17536@cobra.newdream.net>
References: <50F80C3A.9020007@mermaidconsulting.dk> <50F80FA0.5010504@profihost.ag> <50F819B8.4070004@widodh.nl> <50F81A9F.2090104@profihost.ag> <alpine.DEB.2.00.1301170916420.10574@cobra.newdream.net> <50F85FEC.7030305@mermaidconsulting.dk>
 <alpine.DEB.2.00.1301171402130.21470@cobra.newdream.net> <50F930EE.9070201@mermaidconsulting.dk> <alpine.DEB.2.00.1301181327580.8622@cobra.newdream.net> <50F9C051.7070900@mermaidconsulting.dk> <alpine.DEB.2.00.1301181342410.8622@cobra.newdream.net>
 <50FA6681.10507@mermaidconsulting.dk> <alpine.DEB.2.00.1301190737110.29915@cobra.newdream.net> <50FADE65.5050403@mermaidconsulting.dk> <alpine.DEB.2.00.1301191016320.29915@cobra.newdream.net> <50FAE8AB.5000602@mermaidconsulting.dk>
 <alpine.DEB.2.00.1301201613130.31658@cobra.newdream.net> <50FCE759.9070309@mermaidconsulting.dk> <alpine.DEB.2.00.1301202310260.29915@cobra.newdream.net> <50FFD420.7000604@mermaidconsulting.dk> <50FFD6F9.1010705@widodh.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47813 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750797Ab3AWNNi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Jan 2013 08:13:38 -0500
In-Reply-To: <50FFD6F9.1010705@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: =?ISO-8859-15?Q?Jens_Kristian_S=F8gaard?= <jens@mermaidconsulting.dk>, Stefan Priebe <s.priebe@profihost.ag>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, 23 Jan 2013, Wido den Hollander wrote:
> On 01/23/2013 01:14 PM, Jens Kristian S?gaard wrote:
> > Hi Sage,
> > 
> > > I think the problem now is just that 'osd target transaction size' is
> > > too big (default is 300).  Recommended 50.. let's see how that goes.
> > > Even smaller (20 or 25) would probably be fine.
> > 
> 
> Going through the code and reading that this solved it for Jens, could this
> issue be traced back to less powerful CPUs?
> 
> I've seen this on Atom and Fusion platforms which both don't excel in their
> computing power.
> 
> From what I read is that the OSD by default does 300 transactions and then
> commits them? If the CPU is to slow to handle all the work timeouts can occur
> because it can't do all the transactions inside the set window?
> 
> By lowering the number of transactions it sends out a heartbeat more often
> thus keeping itself alive.
> 
> Correct?

In this case, it controls how many operations we stuff into an atomic 
transaction when doing something big (like deleting an entire PG).  The 
speed is as much about the storage as the CPU, although I'm sure a small 
CPU helps slow things down.  The thread needs to be able to do those N 
unlinks (or whatever) within the heartbeat interval or else the OSD will 
consider the thread stuck and zap itself.

I think 300 was just a silly initial value... Te default is now either 30 
or 50.

sage


> 
> Wido
> 
> > I set it to 50, and that seems to have solved all my problems.
> > 
> > After a day or so my cluster got to a HEALTH_OK state again. It has been
> > running for a few days now without any crashes!
> > 
> > Thanks for all your help!
> > 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
