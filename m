From: Sage Weil <sage@newdream.net>
Subject: Re: Min alloc size according to media type
Date: Thu, 19 May 2016 15:20:18 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1605191515090.6221@cpach.fuggernut.com>
References: <CY1PR0201MB182075171B6FCA64CF104097854A0@CY1PR0201MB1820.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47705 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932727AbcESTUE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 May 2016 15:20:04 -0400
In-Reply-To: <CY1PR0201MB182075171B6FCA64CF104097854A0@CY1PR0201MB1820.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ramesh Chander <Ramesh.Chander@sandisk.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, 19 May 2016, Ramesh Chander wrote:
> Hi Sage,
> 
> I am doing changes in Bluestore related to minimum allocation size 
> according to ssd and hdd. This change involves:
> 
> 1. There are three min alloc sizes now:
>                 a. min_alloc_size: old one, default changed to 0
>                 b. min_alloc_size_hdd: for rotational media, default 64k
>                 c. min_alloc_size_ssd: for ssd, default 4k.
> 
> 2. Making changes in BlockDevice to maintain its own min_alloc_size. It 
> allows to maintain different min_alloc_size for different devices.
>
> 3. Making changes in allocator(stupid, bitmap) interfaces to take 
> min_alloc_size from the corresponding devices.

This makes sense if some devices are hdd and some are ssd (e.g., main vs 
db/wal), but in practice the only separation currently possible is to have 
a separate device for WAL and for rocksdb, both of which hare managed by 
bluefs and not bluestore directly.  Ane bluefs currently has a 
min_alloc_size of 1MB since all files are generally big (usually 4MB 
each), there are no random writes, etc.

Unless we want to make bluestore smart enough to push object data on a 
fast device (i.e., do ssd/hdd tiering internally), I'm not sure we need 
per-device min_alloc_size.

> I have following questions regarding this parameter and use of it in 
> bluestore:
> 
> 1. I assume this parameter is transient and does not have effect on 
> different values (say changed from 4k to 64k or vice versa) across 
> reboots or different ceph versions?
>                 Is it ondisk anywhere in metadata or in freelist manager 
>                 in direct or indirect manner? Because having on disk 
>                 presence could cause confusions by having new options 
>                 when existing users move to build with this change.

Currently it is transient everywhere, and so far I've been trying to keep 
it that way.  However, we might want to change this: if we make 
min_alloc_size fixed at mkfs time, we could possibly collapse down the 
size of the allocation bitmap(s) by a factor of 16 on HDD (1 bit per 
min_alloc_size instead of per block).  I'm not sure that it's worth it, 
though... thoughts?

> 2. While figuring out the min_alloc_size for devices, I give preferences 
> to old config parameter so that existing configs
>                 are not changed by this code change. Is this right or 
> this is not required?

Don't worry about legacy at all since bluestore has no users.  :)

sage
