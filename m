From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: Using other filesystems than btrfs with Ceph
Date: Fri, 11 Jun 2010 09:26:48 -0700
Message-ID: <AANLkTin6wleXQVepvMACh8JMr5sa1g4neVXD_Voi7rYT@mail.gmail.com>
References: <hutgsk$oh4$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:35942 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755699Ab0FKQeG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 11 Jun 2010 12:34:06 -0400
Received: by gye5 with SMTP id 5so837448gye.19
        for <ceph-devel@vger.kernel.org>; Fri, 11 Jun 2010 09:34:03 -0700 (PDT)
In-Reply-To: <hutgsk$oh4$1@dough.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Peter Niemayer <niemayer@isg.de>
Cc: ceph-devel@vger.kernel.org

On Fri, Jun 11, 2010 at 7:23 AM, Peter Niemayer <niemayer@isg.de> wrote:
> Is there some documentation/discussion on the pro's and con's of using
> other filesystems with Ceph?
Unfortunately, I can't seem to find anything.

> Also, the documentation in the Wiki does not mention what would need
> to be configured differently if another filesystem was to be used -
> what would I have to use instead of "btrfs devs = /dev/sdy"?
You can look at the ceph.conf file produced by the vstart script for a
non-btrfs example -- just use
osd data = path
osd journal = path2
osd journal size = [# in MB]

> The reason why I ask is that the application I would like to test-run
> on a minimal Ceph-cluster runs much faster when using XFS than btrfs.
> Also, XFS is not quite as young&experimental as btrfs, so if there is
> no specific benefit from using btrfs, it would be a reasonable choice
> to use the much longer matured XFS for now.
Well, it's possible that you could improve Ceph's performance in
certain workloads by using different underlying filesystems, but in
general Ceph's interfaces and protocols are going to matter a lot
more, and btrfs works very well with it. The fact that XFS is faster
than btrfs in your workload doesn't necessarily mean that Ceph on XFS
will be faster than Ceph on btrfs for your job.

That said, btrfs is most beneficial when you engage in snapshotting,
or have to handle recoveries. Ceph makes use of a number of ioctls to
ensure consistency and provide speed when running on btrfs; on other
filesystems snapshots will be much slower, and OSDs will be more
likely to lose data in the case of a power failure or similar problem.
If these aren't big problems for you, you can run Ceph on whatever fs
you like.

-Greg
