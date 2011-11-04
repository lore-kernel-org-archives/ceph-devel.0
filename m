From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: Ceph copy-on-write
Date: Fri, 4 Nov 2011 10:10:29 -0700
Message-ID: <CAORUGqAUW4Z-+KmfBwxXTpdsF+T52HrPuQuQzcSuA9Z=UA7DyQ@mail.gmail.com>
References: <4EB35754.1040506@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:42034 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755915Ab1KDRKw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 Nov 2011 13:10:52 -0400
Received: by wwi36 with SMTP id 36so3787722wwi.1
        for <ceph-devel@vger.kernel.org>; Fri, 04 Nov 2011 10:10:51 -0700 (PDT)
In-Reply-To: <4EB35754.1040506@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Maxim Mikheev <mikhmv@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Thu, Nov 3, 2011 at 20:09, Maxim Mikheev <mikhmv@gmail.com> wrote:
> Is Ceph copy on write system?

Ceph uses btrfs's copy-on-write properties internally, for cheap
snapshots and journaling speed.

As far as I know, Ceph does not currently expose reflink-style
functionality to clients, and there's no common API either.

I created a ticket http://tracker.newdream.net/issues/1680 to track
this feature request.

> If so, I think I do something wrong.
> Files copying take too much time and disks space in my Ceph installation.
> Could you like to help me resolve my problem?

It seems you copied a 3075MB file from Ceph to Ceph, saw the free
space in df drop 3395MB, and it took 109 seconds without sync, and
you're asking why?

First of all, the cephfs df statistics are allowed to update slowly,
to improve performance. So that's not a reliable measure in the first
place. Second, the df reports the underlying space free that ceph-osd
sees, and that can be affected by other things such as journaling and
unrelated files stored on the same filesystem. Also remember that ceph
normally stores multiple copies of your data.

As for writing at 31 MB/s, that's 310 Mbit/s, and if you have an OSD
with just a single GigE network interface, the outgoing replication
data stream uses the same network link. I've seen plenty of cheap GigE
adapters max out at 600 Mbit/s, plus there's TCP and IP overhead. Lots
of disks also max out at 40 MB/s. To troubleshoot further, you'll need
to describe your cluster; how many OSDs, what kind of hardware and
networking, what kind of performance do you see from the disks when
accessed directly.
