From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: cosd multi-second stalls cause "wrongly marked me down"
Date: Wed, 23 Feb 2011 11:12:35 -0800
Message-ID: <99643591EE67457AAE61648D53093F40@gmail.com>
References: <1297891508.25491.120.camel@sale659.sandia.gov>
 <75157CFDA63D45458FC47FB7BA6CB974@gmail.com>
 <1297893011.25491.124.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1102161649560.11150@cobra.newdream.net>
 <Pine.LNX.4.64.1102161651380.11150@cobra.newdream.net>
 <1297957574.25491.152.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1102170805080.22514@cobra.newdream.net>
 <1298483538.25491.233.camel@sale659.sandia.gov>
 <460F770CEB1C499F8B87593762171483@gmail.com>
 <Pine.LNX.4.64.1102231051070.2601@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:52150 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754817Ab1BWTMi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Feb 2011 14:12:38 -0500
Received: by gxk8 with SMTP id 8so1589223gxk.19
        for <ceph-devel@vger.kernel.org>; Wed, 23 Feb 2011 11:12:37 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.1102231051070.2601@cobra.newdream.net>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Jim Schutt <jaschut@sandia.gov>, "=?utf-8?Q?ceph-devel=40vger.kernel.org?=" <ceph-devel@vger.kernel.org>


On Wednesday, February 23, 2011 at 10:54 AM, Sage Weil wrote: 
> On Wed, 23 Feb 2011, Gregory Farnum wrote:
> > I have managed to get OSDs wrongly marking each other down during 
> > startup when they're peering large numbers of PGs/pools, as they 
> > disagree on who they need to be heartbeating (due to the slow handling 
> > of new osd maps and pg creates); if you're mostly seeing OSDs get 
> > incorrectly marked down during low epochs (your original email said 
> > epoch 7) this is probably what you're finding.
> 
> FWIW, this isn't supposed to happen either.. the implementation may be 
> broken somewhat. The idea is that once an OSD starts to expect a 
> heartbeat it should tell them so. And if an OSD is told that a future 
> epoch says it should send heartbeats to node foo, then it will do so, at 
> least until it processes that epoch.
Hmmm -- I don't think they're telling the other OSDs that they're heartbeat partners! At least I didn't see anything that would make that happen. They just start expecting pings, and in some cases they will start sending them because they notice they're a local replica too, but there's nothing in those messages like "you owe me pings as of epoch x".
Are there stubs you know of that I should look at in re-implementing this behavior?

> > We still have no idea what could be causing the stall *inside* of 
> > tick(), though. :/
> 
> You mean heartbeat(), right? Yep, still no clue... :(
> 
Well the 28-second stall is inside of tick() as it arms a timer for the next tick. Heartbeat is definitely failing but nobody's quite sure why, as I recall. 
