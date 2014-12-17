From: Sage Weil <sage@newdream.net>
Subject: Re: CephFS hangs when writing 10GB files in loop
Date: Wed, 17 Dec 2014 08:40:38 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1412170839370.1008@cobra.newdream.net>
References: <5491B0E1.7050203@42on.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:60575 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750790AbaLQQkj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Dec 2014 11:40:39 -0500
In-Reply-To: <5491B0E1.7050203@42on.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Wed, 17 Dec 2014, Wido den Hollander wrote:
> Hi,
> 
> Today I've been playing with CephFS and the morning started great with
> CephFS playing along just fine.
> 
> Some information first:
> - Ceph 0.89
> - Linux kernel 3.18
> - Ceph fuse 0.89
> - One Active MDS, one Standby
> 
> This morning I could write a 10GB file like this using the kclient:
> $ dd if=/dev/zero of=10GB.bin bs=1M count=10240 conv=fsync
> 
> That gave me 850MB/sec (all 10G network) and I could read the same file
> again with 610MB/sec.
> 
> After writing to it multiple times it suddenly started to hang.
> 
> No real evidence on the MDS (debug mds set to 20) or anything on the
> client. That specific operation just blocked, but I could still 'ls' the
> filesystem in a second terminal.
> 
> The MDS was showing in it's log that it was checking active sessions of
> clients. It showed the active session of my single client.
> 
> The client renewed it's caps and proceeded.
> 
> I currently don't have any logs, but I'm just looking for a direction to
> be pointed towards.

Hmm.  Try

 cat /sys/kernel/debug/ceph/*/mdsc
 cat /sys/kernel/debug/ceph/*/osdc

to see requests in flight (you may need to mount -t debugfs none 
/sys/kernel/debug first).  What kernel version?

sage
