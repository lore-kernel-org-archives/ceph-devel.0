From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: Best way to store billions of files
Date: Sun, 1 Aug 2010 09:17:42 -0700
Message-ID: <AANLkTimWOWqf+61FK4DmpN+GhxZ0_3o_v+xj=mWXYqcj@mail.gmail.com>
References: <AANLkTi=YSaX9tnynEHj4rS=1wOcTrmvAds7XNnZB1sGj@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:56906 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751460Ab0HAQRp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 1 Aug 2010 12:17:45 -0400
Received: by wyb39 with SMTP id 39so2569261wyb.19
        for <ceph-devel@vger.kernel.org>; Sun, 01 Aug 2010 09:17:43 -0700 (PDT)
In-Reply-To: <AANLkTi=YSaX9tnynEHj4rS=1wOcTrmvAds7XNnZB1sGj@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Roland Rabben <roland@jotta.no>
Cc: ceph-devel@vger.kernel.org

On Sun, Aug 1, 2010 at 5:08 AM, Roland Rabben <roland@jotta.no> wrote:
> I know Ceph is not production ready yet, but from the activity on this
> mailing list things looks promising.
As you note, Ceph is definitely not production-ready yet. Part of this
means that its testing in large-scale environments is limited, so
there may be bugs or unexpected behaviors. That said:

> I am researching alternatives to GlusterFS that I am currently using.
> My need is to store billions of files (big and small), and I am trying
> to find out if there are any considerations I should make when
> planning folder structure and server config using Ceph.
>
> On my GlusterFS system things seems to slow down dramatically as I
> grow the number of files. A simple ls takes forever. So I am looking
> for alternatives.
>
> Right now my folder structrure looks like this:
>
> Users are grouped into folders, named /000, /001, ... /999 , using a hash.
> Each user has its own folder inside the numbered folders
> Inside each user-folder the users files are stored in folders named
> /000, /001, ... /999, also using a hash.
>
> Would this folder structure or the ammount of files become a problem using Ceph?
This structure *should* definitely be okay for Ceph -- it stores
dentries as part of the containing inode, and the metadata servers
make extensive use of an in-memory cache, so an ls will generally
require either zero or one on-disk lookups.

> I generally use 4U storage nodes with 36 x 1,5 TB or 2 TB SATA drives,
> 8 core CPU and 6 GB RAM. My application is write once and read many.
> What recommendations would you give with regards to setting up the
> filesystem on the storage nodes? ext3? ext4? lvm? RAID?
Again going back to the limited testing, I don't think anybody knows
what the best configuration will be with such disk-heavy nodes. But
you'll definitely want to run btrfs on storage nodes as it supports a
number of features which enable Ceph to be faster under some
circumstances and to have more reliable recovery behavior.
Speculating on the best-performance configuration is hard without
knowing your usage patterns, but: Given the limited memory
availability, I would probably create 2 or 3 btrfs volumes across all
the disks (except saving one extra disk per volume to use as a
journal), and then run one OSD per volume (with an
appropriately-configured CRUSH map to prevent replicating data onto
the same node!). If you can expand the memory above 12GB I'd probably
stuff the machine full and then run one OSD per 2GB (or maybe 1GB, but
your caching will be weaker) and partition the drives using btrfs
accordingly.

> Today I am mounting all disks as individual ext3 partitions and tying
> them together with GlusterFS. Would this work with Ceph or would you
> recommend making one large LVM volume on each storage node that you
> expose to Ceph?
This would be a bad idea with Ceph, you'll need to combine the disks
into logical volumes (but as I said, btrfs can do this). The reason
being that Ceph can only handle one directory/OSD instance and you
don't want to stuff 36 OSDs into 8 cores and 6 GB of RAM. :)
-Greg
