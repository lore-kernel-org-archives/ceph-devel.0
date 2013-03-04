From: Sage Weil <sage@inktank.com>
Subject: Re: When ceph synchronizes journal to disk?
Date: Mon, 4 Mar 2013 08:32:44 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1303040831470.12663@cobra.newdream.net>
References: <513343D8.8050402@cs.utah.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:51113 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757973Ab3CDQcp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Mar 2013 11:32:45 -0500
In-Reply-To: <513343D8.8050402@cs.utah.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xing Lin <xinglin@cs.utah.edu>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Sun, 3 Mar 2013, Xing Lin wrote:
> Hi,
> 
> There were some discussions about this before on the mailing list but I am
> still confused with this. I thought Ceph would flush data from the journal to
> disk when either the journal is full or when the time to do synchronization is
> due. In my test experiment, I used 24 osds(one osd for each disk). I used a 10
> GB tmpfs file as the journal disk for each osd. Then for testing, I delayed
> the synchronization between the journal and disk on purpose. I increased the
> 'journal min sync interval' to be 60 s and 'journal max sync interval' to be
> 300 s. Then I created a rbd and then started a 4M sequential write workload
> with fio for 30 seconds. I was expecting that no IO should happen to disks,
> unless we have filled 240 GB data (10G*24). However, 'iostat' showed there was
> data
> started to be written into disks (at about 20 MB/s per disk), right after I
> started the sequential workload. Could someone help to explain this situation?

Are you using btrfs?  In that case, the journaling is parallel to the fs 
workload because the btrfs snapshots provide us with a stable checkpoint 
we can replay from.  In contrast, for non-btrfs file systems we need to do 
writeahead journaling.

sage


> Thanks,
> 
> I am running 0.48.2. The related configuration is as follows.
> -----------------
> [osd]
>         osd journal size = 10000
>         osd journal = /dev/shm/journal/$name-journal
>         journal dio = false
>         filestore xattr use omap = true
> 
>         # The maximum interval in seconds for synchronizing the filestore.
>         filestore min sync interval = 60
>         filestore max sync interval = 300
> -------------
> 
> Xing
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
