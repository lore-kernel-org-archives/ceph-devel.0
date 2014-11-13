From: Andrew Shewmaker <agshew@gmail.com>
Subject: Re: [PATCH 0/6] blkin (LTTng + Zipkin) tracing
Date: Thu, 13 Nov 2014 10:56:21 -0700
Message-ID: <20141113175621.GA14141@localhost>
References: <20141112231929.GA6892@localhost>
 <alpine.DEB.2.00.1411122125070.24889@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:60002 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933383AbaKMR4Y (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 13 Nov 2014 12:56:24 -0500
Received: by mail-pd0-f170.google.com with SMTP id z10so15058244pdj.29
        for <ceph-devel@vger.kernel.org>; Thu, 13 Nov 2014 09:56:24 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1411122125070.24889@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

On Thu, Nov 13, 2014 at 08:14:48AM -0800, Sage Weil wrote:
> On Wed, 12 Nov 2014, Andrew Shewmaker wrote:
<snip>
> > In general, Blkin implements the tracing semantics described in the Dapper
> > paper http://static.googleusercontent.com/media/research.google.com/el/pubs/archive/36356.pdf
> > in order to trace the causal relationships between the different
> > processing phases that an IO request may trigger. The goal is an end-to-end
> > visualisation of the request's route in the system, accompanied by information
> > concerning latencies in each processing phase. Thanks to LTTng this can happen
> > with a minimal overhead and in realtime. In order to visualize the results Blkin 
> > was integrated with Twitter's Zipkin http://twitter.github.io/zipkin/
> > (which is a tracing system entirely based on Dapper).
> > 
> > These patches can also be found in https://github.com/agshew/ceph/tree/wip-blkin
> 
> This looks great!  Do you mind opening a github pull request from that 
> branch?  It's a bit more convenient for capturing review.

I'll do that, but first I need to make changes to autoconf/automake
for blkin. It isn't actually building.

I had been going down the road of treating it simply 
as a separate package from ceph, then decided to include it as a 
submodule. My branch only built on my system because I had already
installed blkin separately.

<snip>
> > In the immediate future I plan to:
> > 
> >  - push a wip-blkin branch to github.com/ceph and take advantage of gitbuilder test/qa
> >  - move the changes forward to ceph:master
> >  - add Andreas' tracepoints https://github.com/ceph/ceph/pull/2877 using Blkin
> >    and investigate how easy it is to select the level of tracing detail
> > 
> > Questions:
> > 
> > 1. Did I split the patches into sensible groups?
> 
> 1 could be broken into the build changes and the msg/optracker code.  It 
> looks like it unconditionally links against zipkin-cpp now, which we 
> probably don't want.  Unless blkin is statically linked or something, but 
> I don't see anything in the patch that would do that yet.  In any case, 
> having the build stuff in a separate patch helps.

Right. Makes sense. I'll split that out for version 2.

 
> The split for the rest looks fine.  Need to look at the changes to osd 
> init carefully as it is a bit delicate.
> 
> > 2. How low is LTTng's overhead? Is it entirely eliminated when not enabled?
> > 
> > Do we need to take advantage of something like the Linux kernel's CONFIG_DYNAMIC_FTRACE
> > trick, where a special mcount() function is converted back and forth between 
> > a NOP and trace calls? See http://lwn.net/Articles/365835/ for a little more 
> > detail.
> 
> I always assumed that lttng was doing something like this, but I don't see 
> a clear explanation of what an inactive tracepoint looks like anywhere..

Yeah, I suppose they must, but I couldn't find a nice short
explanation either. LWN has a couple of articles that don't go deeply
into it. At most, they mention the use of asm gotos
(http://lwn.net/Articles/491543/).
