From: Stefan Kleijkers <stefan@kleijkers.nl>
Subject: Re: ceph on XFS
Date: Fri, 27 Jan 2012 22:34:43 +0100
Message-ID: <4F231873.6070001@kleijkers.nl>
References: <CAO47_-8JzjxoGB_ZjVwWtdhYLJ3LoVZQyoQoSWuJ1v9W9ioSLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtpq2.gn.mail.iss.as9143.net ([212.54.34.165]:52733 "EHLO
	smtpq2.gn.mail.iss.as9143.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753570Ab2A0WLz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Fri, 27 Jan 2012 17:11:55 -0500
In-Reply-To: <CAO47_-8JzjxoGB_ZjVwWtdhYLJ3LoVZQyoQoSWuJ1v9W9ioSLg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: chb@muc.de
Cc: ceph-devel@vger.kernel.org

Hi Christian,

I just switched testing from btrfs to xfs, because I also have the 
problem with the extreme slowdown with btrfs after a short while.

The performance and stability I'm getting with xfs at the moment is very 
good.

I'm testing two setups:
- OSD per disk with XFS with two nodes and 12 disks per node. An 
intermediate server that acts as gateway, mounting the cephfs and 
exposing it with rsync daemon. Doing 20 rsyncs to different directories 
on the cephfs (backups of linux servers with about 100GB of data each).
- OSD per disk with XFS with two nodes and 12 disks per node. An 
intermediate server that acts as a gateway, connecting to 20 rbd's and 
formatted as ext3 filesystems. Those filesystems get exposed with a 
rsync daemon. Same load as with the first setup.

Both nodes have a ssd for journaling (partitioned in 12 partitions, for 
each osd).

Both setups perform really good. It's a gigabit network and with the 
first setup I get about 50MB/s average, the second setup goes faster, 
but I don't have any concrete figures at the moment.

In the past I had a lot of trouble with btrfs, it crashed a lot. But 
with the 3.2.1 kernel those crashes disappeared.

Stefan

On 01/27/2012 09:48 PM, Christian Brunner wrote:
> Hi,
>
> reading the list archives, I get the impression that XFS is the second
> best alternative to btrfs. But when I start an ceph-osd on an XFS
> volume, there is still a big warning:
>
> WARNING: not btrfs or ext3.  We don't currently support file systems other
>               than btrfs and ext3 (data=journal or data=ordered).  Data may be
>               lost in the event of a crash.
>
> I know that I can't use btrfs snapshots, but is it really that bad?
>
> I'm running a recent RHEL6.2 kernel now, that has all those wonderful
> optimizations, Dave Chinner was talking about.
>
> Thanks,
> Christian
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

