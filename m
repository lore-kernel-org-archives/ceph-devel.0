From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [ceph-users] Kernel RBD hang on OSD Failure
Date: Tue, 8 Dec 2015 11:35:46 +0100
Message-ID: <CAOi1vP-Aw4oWV6eC2h7ZkW87FycnBm0XjMMo0T2updLDjMNULQ@mail.gmail.com>
References: <CAKeiORSsNQ-LOWQ0heLZQkekN_mwYQ81XSXfdJe-R1eP1Osz1w@mail.gmail.com>
	<CA+z5DswarP0KHomWJocCxT29W1-kyzV2RhDOg7tc-0_DV0D1Kg@mail.gmail.com>
	<CAAsTndwa95Vxeri=DOckQEiSfMQ04VBKvVbzdVhZw0dke1WgEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:38720 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932347AbbLHKft (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Dec 2015 05:35:49 -0500
Received: by wmec201 with SMTP id c201so23931502wme.1
        for <ceph-devel@vger.kernel.org>; Tue, 08 Dec 2015 02:35:47 -0800 (PST)
In-Reply-To: <CAAsTndwa95Vxeri=DOckQEiSfMQ04VBKvVbzdVhZw0dke1WgEQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tom Christensen <pavera@gmail.com>
Cc: "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Dec 8, 2015 at 10:57 AM, Tom Christensen <pavera@gmail.com> wrote:
> We aren't running NFS, but regularly use the kernel driver to map RBDs and
> mount filesystems in same.  We see very similar behavior across nearly all
> kernel versions we've tried.  In my experience only very few versions of the
> kernel driver survive any sort of crush map change/update while something is
> mapped.  In fact in the last 2 years I think I've only seen this work on 1
> kernel version unfortunately its badly out of date and we can't run it in
> our environment anymore, I think it was a 3.0 kernel version running on
> ubuntu 12.04.  We have just recently started trying to find a kernel that
> will survive OSD outages or changes to the cluster.  We're on ubuntu 14.04,
> and have tried 3.16, 3.19.0-25, 4.3, and 4.2 without success in the last
> week.  We only map 1-3 RBDs per client machine at a time but we regularly
> will get processes stuck in D state which are accessing the filesystem
> inside the RBD and will have to hard reboot the RBD client machine.  This is
> always associated with a cluster change in some way, reweighting OSDs,
> rebooting an OSD host, restarting an individual OSD, adding OSDs, and
> removing OSDs all cause the kernel client to hang.  If no change is made to
> the cluster, the kernel client will be happy for weeks.

There are a couple of known bugs in the remap/resubmit area, but those
are supposedly corner cases (like *all* the OSDs going down and then
back up, etc).  I had no idea it was that severe and goes that back.
Apparently triggering it requires a heavier load, as we've never seen
anything like that in our tests.

For unrelated reasons, remap/resubmit code is getting entirely
rewritten for kernel 4.5, so, if you've been dealing with this issue
for the last two years (I don't remember seeing any tickets listing
that many kernel versions and not mentioning NFS), I'm afraid the best
course of action for you would be to wait for 4.5 to come out and try
it.  If you'd be willing to test out an early version on one of more of
your client boxes, I can ping you when it's ready.

I'll take a look at 3.0 vs 3.16 with an eye on remap code.  Did you
happen to try 3.10?

It sounds like you can reproduce this pretty easily.  Can you get it to
lock up and do:

# cat /sys/kernel/debug/ceph/*/osdmap
# cat /sys/kernel/debug/ceph/*/osdc
$ ceph status

and bunch of times?  I have a hunch that kernel client simply fails to
request enough of new osdmaps after the cluster topology changes under
load.

Thanks,

                Ilya
