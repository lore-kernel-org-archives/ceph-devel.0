From: Sage Weil <sage@newdream.net>
Subject: Re: /sys/block and /dev and partitions
Date: Sat, 15 Aug 2015 07:28:06 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1508150727060.32106@cobra.newdream.net>
References: <55CF1F99.5050807@dachary.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:48267 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753058AbbHOO2H (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 15 Aug 2015 10:28:07 -0400
In-Reply-To: <55CF1F99.5050807@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Sat, 15 Aug 2015, Loic Dachary wrote:
> Hi,
> 
> Is there a portable and consistent way to figure out if a given /dev/XXX 
> path (for instance /dev/dm-1) is a partition of a whole device ? 
> Although checking /sys/block/dm-1/dm/name for a number at the end (like 
> mpatha1 or mpatha2) would probably work, it feels like a fragile hack. 
> Looking into /sys/block/dm-1/slaves will lead to 
> /sys/block/dm-1/slaves/dm-0 and we can check that 
> /sys/block/dm-*/subsystem is class/block. But that does not necessarily 
> mean dm-1 is a partition of dm-0, just that it's a slave of dm-0.

Take a look at is_partition in ceph-disk, whih is the best I came up with.  
Basically it checks if the device name appears as /sys/block/*/$foo...

sage
