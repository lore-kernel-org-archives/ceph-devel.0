From: Sage Weil <sweil@redhat.com>
Subject: Re: Fwd: question about client's cluster aware
Date: Thu, 25 Sep 2014 07:13:57 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1409250707340.6593@cobra.newdream.net>
References: <CAPaK2r-ToTheCfmjfi1K-Ss=yOoo1MD8pHJ+Ghs0n549+sAEiA@mail.gmail.com> <CAPaK2r9DQ2b-3V=RUQg4UD7zaSHdtMcWp5qQPwNuOmY12UK66w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:38775 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751595AbaIYON6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Sep 2014 10:13:58 -0400
In-Reply-To: <CAPaK2r9DQ2b-3V=RUQg4UD7zaSHdtMcWp5qQPwNuOmY12UK66w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: yue longguang <yuelongguang@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hi Yue,

On Thu, 25 Sep 2014, yue longguang wrote:
> ---------- Forwarded message ----------
> From: yue longguang <yuelongguang@gmail.com>
> Date: Tue, Sep 23, 2014 at 5:53 PM
> Subject: question about client's cluster aware
> To: ceph-devel@vger.kernel.org
> 
> 
> hi,all
> 
> my question is from my test.
> let's take a example.   object1(4MB)--> pg 0.1 --> osd 1,2,3,p1
> 
> when client is writing object1, during the write , osd1 is down. let
> suppose 2MB is writed.
> 1.
>    when the connection to osd1 is down, what does client do?  ask
> monitor for new osdmap? or only the pg map?

For a client that is mostly idle and has only a single IO in progress to 
the failed machine, it will wait for N seconds before asking the monitor 
for an updated OSDMap.  Usually, though, it will get that incremental map 
update/diff from another OSD in the cluster.  Any time the client sends a 
request to any OSD, that OSD will share map incrementals/diffs if it has a 
newer map.  So for a cluster with say 100 OSDs, say 99% of the time it 
will fine out about the failure from another OSD.

> 2.
>   now client gets a newer map , continues the write , the primary osd
> should be osd2.  the rest 2MB is writed out.

The client will resend any request that hasn't been acked to the new 
primary.  If it was a single 2MB write, tha tmeans it will resend the 
whole write.  If it was two 1MB writes, it will resend whichever 
portions haven't been acked (probably both, if the failure happened 
mid-write).

>  now what does ceph do to integrate the two part data? and to promise
> that replicas is enough?

If the new primary has that writ eon disk already (because it had 
completed the write before it crashed) it will reply immediately-- 
operations have unique IDs are are idempotent.  If it hasn't seen 
the write yet, it will do it then.

> 3.
>  where is the code.  Be sure to tell me where the code is?

osdc/Objecter.cc scan_requests() is where we decide what to resend 
(specifically look where we call recalc_target).

You'll find hte dup request check either in OSD.cc handle_op or in 
ReplicatedPG.cc do_request.  The map sharing code is in OSD.cc in 
_share_map_incoming (or something like that).

Hope that helps!
sage
