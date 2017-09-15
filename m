From: Sage Weil <sage@newdream.net>
Subject: Re: snapshots
Date: Fri, 15 Sep 2017 17:37:15 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1709151734310.16664@piezo.novalocal>
References: <CAKRxpuukift+7ovzeDnTbNtAzKM6=sBEmoQyLbQUebLJ9rwCQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:39087 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751185AbdIORhS (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Sep 2017 13:37:18 -0400
In-Reply-To: <CAKRxpuukift+7ovzeDnTbNtAzKM6=sBEmoQyLbQUebLJ9rwCQQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Two Spirit <twospirit6905@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Fri, 15 Sep 2017, Two Spirit wrote:
> few questions

I'm assuming you're talking about CephFS snapshots here:

> 1) Is the idea of snapshotting about 100TB of data doable with Ceph?

You can snapshot the entire file system (petabytes) if you like.

> 2) How long would such a task take? Are we talking seconds, minutes,
> hours, days, weeks?

Seconds (if that).

> 3) what does "stop i/o" mean. Does the filesystem unavailable to the
> user during the snapshot time, or is this administratively unavailable
> to the user, or does ceph stop io somewhere while in parallel the data
> can be read/written to?

There's no IO stoppage.  Clients essentially mark a barrier in their 
writeback caches so that previously buffered writes are contained in the 
snapshot and new writes are not.  How long it takes for that data to be 
flushed and stable/durable on OSDs depends on how big your client caches 
are, but that does not cause any io stoppage or gap in availability for 
users of the file system.

sage
