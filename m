From: Sage Weil <sage@inktank.com>
Subject: RE: Object Write Latency
Date: Mon, 23 Sep 2013 09:19:43 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1309230916011.6797@cobra.newdream.net>
References: <3472A07E6605974CBC9BC573F1BC02E4A52724A9@PLOXCHG03.cern.ch> <alpine.DEB.2.00.1309200830040.25752@cobra.newdream.net>, <CABZ+qqnXbycX4C_brF4eiRVb0PeA4SKf2kW_d3g8RYxwD6xFDg@mail.gmail.com>
 <3472A07E6605974CBC9BC573F1BC02E4A52736BE@PLOXCHG03.cern.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:59009 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752332Ab3IWQTn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Sep 2013 12:19:43 -0400
In-Reply-To: <3472A07E6605974CBC9BC573F1BC02E4A52736BE@PLOXCHG03.cern.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Cc: Dan van der Ster <dan@vanderster.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, 23 Sep 2013, Andreas Joachim Peters wrote:
> We deployed 3 OSDs with an EXT4 using RapidDisk in-memory.
> 
> The FS does 140k/s append+sync and the latency is now:
> 
> ~1 ms for few byte objects with single replica
> ~2 ms for few byte objects three replica  (instead of 65-80ms)
> 
> This gives probably the base-line of the best you can do with the 
> current implementation.
> 
> ==> the 80ms are probably just a 'feature' of the hardware (JBOD 
> disks/controller) and we might try to find some tuning parameters to 
> improve the latency slightly.
> 
> Could you just explain how the async api functions (is_complete, 
> is_safe) map to the three states
> 
> 1) object is transferred from client to all OSDs and is present in memory there

Nothing happens yet..

> 2) object is written to the OSD journal

Client gets a COMMIT, which implies ACK

> 3) object is committed from OSD journal to the OSD filesystem

OSD now allows subsequent reads, or read/modify/write operations.

> Is it correct that the object is visible by clients only when 3) has 
> happened?

Yeah.

The ACK (operation is serialized and visible) vs COMMIT (operation is now 
durable) was conceived under the assumption that the serialized+visible 
step would be cheaper than making it durable.  This is the case for btrfs.  
Because of this, the COMMIT message implies ACK, so the client will see 
either ACK + COMMIT or COMMIT, but never COMMIT + ACK.

For ext4 and xfs, we need to do write-ahead journaling just for 
consistency, so the commit happens first.

Hope that helps!

I still think you should look at the logs for the JBOD hardware to see 
where the time is spent; it sounds like there is room for improvement.

sage

