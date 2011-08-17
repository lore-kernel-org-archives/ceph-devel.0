From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: RBD write-performance
Date: Wed, 17 Aug 2011 11:25:18 -0700
Message-ID: <CAORUGqB0pViC9uyRAMym_NZe70_ZJA2iAAUzcN+W5NeCYsHTvg@mail.gmail.com>
References: <CAO47_-9r5BgLkcn2SWriS64P5FgkHrT4Oy1jZfN7s0c36O4zMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f170.google.com ([209.85.210.170]:43355 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751798Ab1HQSZi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Aug 2011 14:25:38 -0400
Received: by iye16 with SMTP id 16so2355312iye.1
        for <ceph-devel@vger.kernel.org>; Wed, 17 Aug 2011 11:25:38 -0700 (PDT)
In-Reply-To: <CAO47_-9r5BgLkcn2SWriS64P5FgkHrT4Oy1jZfN7s0c36O4zMA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: chb@muc.de
Cc: ceph-devel@vger.kernel.org

On Wed, Aug 17, 2011 at 04:25, Christian Brunner <chb@muc.de> wrote:
> We are using ceph exclusively as a storage backend for our KVM-hosting
> environment.

Neat!

> The number of virtual machines has increased now, but the
> machines are idle most of the time. However the OSes of the VMs tend
> to do regular small writes on the disks (I suspect journal commits).
>
> As we don't have a lot of disks (only 16 at the moment), this adds up
> to a high number of write IOPS on the OSD disks with a negligible
> throughput.
>
> What we have in our OSDs are very fast SSD-disks for the ceph journal
> and I wonder if it would be possible, to delay writes on the disks,
> until a number of IOPS has been collected in the journal. I think this
> would improve the situation a lot.
>
> Are there any tuning parameters we could use? What would be your suggestion?

Have you looked at "noatime" and "relatime" mount options for your
vms? That might avoid the unnecessary journal commits, in the first
place.

OSD journaling behavior differs a bit for btrfs vs others, but my
understanding is this:

OSD records writes to the journal, and then writes to the actual disk.
The OS already buffers those writes, and as far as I know Ceph doesn't
do any operation coalescing itself; that is, if the journal says to
update X with value 42, and then update X with value 34, those two
writes get both done to disk. The OSD will sync the writes every now
and then, and once that sync completes, mark that part of the journal
as complete. OS buffering may catch & combine the writes there, and
that I see is what would help with your IO operation count.

So increasing the sync interval sounds like the way to go. This will
make your journal consume more space, but it sounds like your SSDs can
take it. The relevant tunables would be

src/common/config.cc:382:  OPTION(filestore_max_sync_interval,
OPT_DOUBLE, 5),    // seconds
src/common/config.cc:383:  OPTION(filestore_min_sync_interval,
OPT_DOUBLE, .01),  // seconds

which you should be able to just put in ceph.conf.

You might also want to look at whatever kernel-level options you have
for tuning the page cache, most likely under /proc/sys/vm, to make
sure the OS actually buffers & combines the writes within that sync
interval.
