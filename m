From: Sage Weil <sage@newdream.net>
Subject: Re: Client reconnect failing: reader gets bad tag
Date: Thu, 5 May 2011 12:19:23 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1105051215050.26811@cobra.newdream.net>
References: <4DC1D2CA.3060708@sandia.gov>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:51848 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750950Ab1EETSt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 May 2011 15:18:49 -0400
In-Reply-To: <4DC1D2CA.3060708@sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, 4 May 2011, Jim Schutt wrote:
> Hi,
> 
> I'm seeing clients having trouble reconnecting after timed-out
> requests.  When they get in this state, sometimes they manage
> to reconnect after several attempts; sometimes they never seem
> to be able to reconnect.

Hmm, the interesting line is

> 2011-05-04 16:00:59.710971 7f15d6948940 -- 172.17.40.30:6806/12583 >>
> 172.17.40.49:0/302440129 pipe(0x213fa000 sd=91 pgs=430 cs=1 l=1).reader bad
> tag 0

That _should_ mean the server side (osd) closes out the connection 
immediately, which should generate a disconnect error on the client and an 
immediate reconnect.  So it's strange that you're also seeing timeouts.

Of course, we should be getting bad tags anyway, so something else is 
clearly wrong and may be contributing to both problems.  

How easy is this to reproduce?  It's right after a fresh connection, so 
the number of possibly offending code paths is pretty small, at least!

There is client side debugging to turn on, but it's very chatty.  Maybe 
you can just enable a few key lines, like the connect handshake ones, and 
any point where we queue/send a tag.  It's a bit tedious to enable 
the individual dout lines in messenger.c, sadly, but unless you have a 
very fast netconsole or something that's probably the only way to go...

sage
