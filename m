From: Sage Weil <sage@newdream.net>
Subject: Re: questions about pg membership
Date: Thu, 2 Dec 2010 11:37:37 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1012021130260.1982@cobra.newdream.net>
References: <AANLkTin8d5xMoqvjt8YcS6NrCTEB=-L2Tyx4_96TckZd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:41807 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757709Ab0LBTc4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Dec 2010 14:32:56 -0500
In-Reply-To: <AANLkTin8d5xMoqvjt8YcS6NrCTEB=-L2Tyx4_96TckZd@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Henry C Chang <henry_c_chang@tcloudcomputing.com>
Cc: ceph-devel@vger.kernel.org

On Thu, 2 Dec 2010, Henry C Chang wrote:
> Hi Sage,
> 
> I have some questions about the pg membership.
> 
> Suppose I have a ceph cluster of 3 osds (osd0, osd1, osd2) and the
> replication number is 2. I observed that if osd2 failed and became
> down and out, one pg's acting osds would changed from [0,2] to [1,0].
> 
> Does it mean that the primary of the pg changed from osd0 to osd1?

Yeah.  Normally that shouldn't happen, though.  If you know the osdmap 
epochs during which you saw those two mappings, can you send the map files 
and the pgid for me to look at?  You can dump a specific epoch with

 ceph osd dump <epoch> -o /tmp/foo

and calculate a pg mapping using a specific map file with

 osdmaptool --test-map-gp 1.123 /tmp/foo

You can also see the current pg mapping with

 ceph pg map 1.123

but unfortunately (iirc) that command doesn't let you specify an older 
epoch (it probably should!).

> If
> the client wants to access the object in the pg at that time, would
> the client's request be blocked until osd1 has acquired the missing
> object from osd0?
> 
> If so, is there any way (e.g. a crush rule?) to choose osd0 as the new
> primary since it was the replica and had the object already? Then, it
> should be able to shorten the time the client has to wait.

The client's request is blocked in a couple of ways.  First, when the pg 
mapping changes, the client resends the request to the (same or different) 
primary osd.  This is primarily for simplicity; it used to be smarter 
about not resending if the primary didn't change but it was complicating 
the code at a time when we were trying to make things really stable.  That 
can be fixed later with a protocol feature bit.

On reads, the primary has to have the object in question.  On writes, all 
replicas need to have the object before modifying it.  In those cases, the 
request waits on the primary while recovery on that happens (immediately).  
There's not much way around that, unfortunately, although the write case 
might possibly be optimized some as it currently waits for things to flush 
to the fs and that maybe avoidable in certain cases.

The primary changing nodes is more of a concern, though; the rest is small 
optimizations.  Let's figure out why the mapping is changing like that!

sage

