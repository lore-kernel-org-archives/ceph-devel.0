From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: cosd multi-second stalls cause "wrongly marked me down"
Date: Wed, 23 Feb 2011 12:27:17 -0800
Message-ID: <8CE75CCEC22A4A2F8A76180F4DB7F4ED@gmail.com>
References: <1297891508.25491.120.camel@sale659.sandia.gov>
 <75157CFDA63D45458FC47FB7BA6CB974@gmail.com>
 <1297893011.25491.124.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1102161649560.11150@cobra.newdream.net>
 <Pine.LNX.4.64.1102161651380.11150@cobra.newdream.net>
 <1297957574.25491.152.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1102170805080.22514@cobra.newdream.net>
 <1298483538.25491.233.camel@sale659.sandia.gov>
 <460F770CEB1C499F8B87593762171483@gmail.com>
 <1298489031.25491.250.camel@sale659.sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:35386 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755754Ab1BWU1V (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Feb 2011 15:27:21 -0500
Received: by yxs7 with SMTP id 7so1449800yxs.19
        for <ceph-devel@vger.kernel.org>; Wed, 23 Feb 2011 12:27:20 -0800 (PST)
In-Reply-To: <1298489031.25491.250.camel@sale659.sandia.gov>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: "=?utf-8?Q?ceph-devel=40vger.kernel.org?=" <ceph-devel@vger.kernel.org>

On Wednesday, February 23, 2011 at 11:23 AM, Jim Schutt wrote:
> > I have managed to get OSDs wrongly marking each other down during startup when they're peering large numbers of PGs/pools, as they disagree on who they need to be heartbeating (due to the slow handling of new osd maps and pg creates); if you're mostly seeing OSDs get incorrectly marked down during low epochs (your original email said epoch 7) this is probably what you're finding. 
> 
> What I've been trying to look for is heartbeat stalls after I 
> start up a bunch of clients writing. I'm really not sure why that
> original log caught one at such an early epoch - maybe there's
> two things going on?
> 
That wouldn't surprise me too much, but is something to keep in mind when observing. :)

> > We still have no idea what could be causing the stall *inside* of tick(), though. :/
> 
> I think that one was just lucky. Most of the stalls I've
> collected are between ticks.
Stalls between ticks make a lot of sense, since tick requires the osd_lock and we have some functions holding it for way too long, but as far as we can tell a stalled tick() function shouldn't break anything -- heartbeats are sent independently, and all the processing of heartbeats (where you detect down OSDs) is done inside of tick in such a way that it's not going to lose delivery of heartbeats -- that shouldn't be a problem!



