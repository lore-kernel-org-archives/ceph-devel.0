From: Sage Weil <sage@newdream.net>
Subject: Re: block device journal durability
Date: Wed, 16 Jun 2010 10:03:56 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1006161000170.12761@cobra.newdream.net>
References: <4C18E3C4.5030303@mcs.anl.gov>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42390 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755879Ab0FPRDH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Jun 2010 13:03:07 -0400
In-Reply-To: <4C18E3C4.5030303@mcs.anl.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Phil Carns <carns@mcs.anl.gov>
Cc: ceph-devel@vger.kernel.org

On Wed, 16 Jun 2010, Phil Carns wrote:
> I noticed that Ceph issues a warning if it detects that you are using a raw
> block device as the journal and write caching is enabled on that device.
> 
> When it opens the block device file, however, the FileJournal is using
> O_DIRECT|O_SYNC.  In recent kernels, syncing a block device file actually
> triggers a proper write barrier operation
> (http://lxr.linux.no/linux+v2.6.34/fs/block_dev.c#L420).  The barrier
> operation is also supported on MD and LVM now as well if you happen to have a
> journal on a multi-disk volume.
>
> Does this mean that if you have a new enough kernel, and a block device that
> understands barriers, that you can safely leave the write cache enabled for
> the journal device?  It seems that way to me, but I wanted to make sure that I
> am not missing a more subtle issue related to how Ceph performs its
> journaling.

You're correct.  The only concern is that the data is safely on disk when 
the write returns, and it sounds like recent kernels issue the barriers to 
make that happen.  Depending on how recent that behavior is, we can 
probably either remove the warning entirely, or try to guess based on 
kernel version.

> Kudos on the user-friendly warning messages in Ceph in general, by the way.

Thanks!
sage

