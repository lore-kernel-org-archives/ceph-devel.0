From: Sage Weil <sage@newdream.net>
Subject: Re: architecture questions - OSD layout
Date: Thu, 21 Jul 2011 09:15:53 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1107210858450.5868@cobra.newdream.net>
References: <CALFpzo74hRFUis0-P+ekPuC5eqa1AbM4aEimB+zO=cU-mgpjsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:55462 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751471Ab1GUQMN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Jul 2011 12:12:13 -0400
In-Reply-To: <CALFpzo74hRFUis0-P+ekPuC5eqa1AbM4aEimB+zO=cU-mgpjsw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Marcus Sorensen <shadowsor@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hi Marcus-

The two basic configurations:

 - OSD per disk (or smaller set of disks)
   - pro: effeciently utilize disks
   - pro: isolate software faults
   - con: recovery copies objects over network from other nodes
 - OSD per node + raid
   - pro: most disk failure do not translate to osd failure
   - pro: recovery is intra-node; does not incur any network traffic
   - con: you pay lose a few disks to parity
   - con: some fault isolation is lost (raid controller or daemon can fail)
   - con: some performance isolation is lost

The recovery tradeoff is a bit of a simplification, actually.  RAID 
recovery walks the entire disk platter.  Ceph recovery copies just 
objects, and it's N:N instead of N:1.  If a raid disk fails, the 
controller will walk the entire platter on every disk in the set to 
rebuild.  OTOH, if a Ceph osd fails, maybe ~100 nodes will copy 1/100th of 
the lost data to ~100 other nodes (fail-in-place).  Or if/when the disk is 
replaced, those ~100 nodes will copy back to the original location.
 
The other thing to keep in mind is the math.  When it comes down to it, 
for an installation of any size, 2x replication is pretty dangerous 
because any double fault may result in some data loss.  (We should 
probably just make 3x the default.)  But RAID can mitigate that somewhat.  
Instead of replicating across individual disks (with are not terribly 
reliable), you can replicate across RAID5/6 pools of disks, which are very 
reliable, which means you can probably get away with 2x at scale _if_ you 
have some confidence in your ability to nurse an ailing raid set to health 
for the purposes of recovery.

On Wed, 20 Jul 2011, Marcus Sorensen wrote:
> I don't really see us pooling individual drives via btrfs into raid1
> or raid10 for redundancy, between that and the hit on object
> replication we'd lose too much capacity.

I'd wait until the raid5/6 modes in btrfs are merged and stable (probably 
another year or two).

> Also, I'd assume losing the OSD journal is a recoverable event? Just
> thinking about whether the SSD should be RAID-1, or going the other
> direction if ramdisk would be acceptable.

Losing a journal is fully recoverable if you're using btrfs.  The OSD's 
data just warps a bit further back in time to the last consistency point.  
(There is a small risk currently that the pg logs will be too aggressively 
trimmed to efficiently rejoin the cluster at that point, but it's an easy 
fix.)

> Have I gone on long enough yet? :-)  In short, the usage scenario
> we're toying with might be summed up as follows: We'd like to optimize
> for cluster stability and capacity, data loss is undesirable of
> course, but acceptable so long as the cluster itself can continue
> functioning and not bring everything to its knees (clients and all) if
> objects are lost. At this point we'll just have to try a few things,
> not knowing how failure scenarios might be expected to play out, but I
> thought I'd send out this request for comments.

You probably want 3x replication (or higher reliability) on metadata, and 
2x on file data.  The system does not like losing random pieces of the 
namespace metadata; that's hard to cope with.  Losing random bits of 
file data, on the other hand, does not impact the system's internal 
integrity... just the user.

sage
