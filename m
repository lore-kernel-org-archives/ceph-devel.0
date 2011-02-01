From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: Long time to start the ceph osd and mount
Date: Tue, 1 Feb 2011 13:24:10 -0800
Message-ID: <AANLkTinEJQC40mAdysTL_qZ+t0toHkJp=AbyBvJ2-rKC@mail.gmail.com>
References: <AANLkTikmrQWpYL6PhqB9w29jD=TKQQ1-U5sr0JNe=x=r@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:45771 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752950Ab1BAVYN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 1 Feb 2011 16:24:13 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 93784C063
	for <ceph-devel@vger.kernel.org>; Tue,  1 Feb 2011 13:24:12 -0800 (PST)
Received: from mail-ew0-f46.google.com (mail-ew0-f46.google.com [209.85.215.46])
	by mail.hq.newdream.net (Postfix) with ESMTP id 4132227DE8
	for <ceph-devel@vger.kernel.org>; Tue,  1 Feb 2011 13:24:12 -0800 (PST)
Received: by ewy5 with SMTP id 5so3461788ewy.19
        for <ceph-devel@vger.kernel.org>; Tue, 01 Feb 2011 13:24:10 -0800 (PST)
In-Reply-To: <AANLkTikmrQWpYL6PhqB9w29jD=TKQQ1-U5sr0JNe=x=r@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: DongJin Lee <dongjin.lee@auckland.ac.nz>
Cc: ceph-devel@vger.kernel.org

On Mon, Jan 31, 2011 at 9:01 PM, DongJin Lee <dongjin.lee@auckland.ac.nz> wrote:
> I'm using the unstable version dated 20th-Jan.
>
> When I was starting up multiple OSDs, e.g., 3 or more.
> iostat shows, after the start, the OSDs utilizes to 100% themselves
> (there's not much of traffic going on)
>
> If I tried to mount during this time, it fails; 'can't read superblock'
> So I have to wait until all of the OSDs become 0% utilized.
It looks like this is just because of how many PGs you have. With
almost 6200 PGs it's going to take a while for them all to go through
peering, and the initial peering process needs to complete before
you'll be able to do anything. If your OSDs have spare CPU/memory
during this time, you can let them peer more PGs simultaneously by
adjusting the osd_recovery* options. These are listed in the config.h
file and I believe you'll want to increase osd_recovery_threads and
osd_recovery_max_active.

> I made sure before restarting ceph (using 'stop.sh all'), the the OSDs
> are empty (deleted all files, remount clean), as well as cephlog
> directories, anymore to clean.
You mean you wanted a fresh ceph install? In that case you need to run
mkcephfs again (not just manually delete files), or your OSDs are
going to think that there's data they should have and lost. That would
also make startup take much longer.

> Also, Is there a way to increase some pagelimit or disk IO to max out
> the performance? any known issue?
> For example, just using 2 SSDs at 1x normal (no)replication, I can max
> out the link (using dd), including all the way to 6 (all maxed) , but
> when set at 2x, no increase I see, and slowly increases to max link
> speed by 6 SSDs.
> The SSDs are already fast enough to do all kinds of replication IO
> workloads, and so I don't understand given that there's virtually no
> CPU bottleneck I see.
> It seems that there's a clear bottleneck somewhere in the system, more
> like a system configuration issue.? I don't see MDS/MON use any
> significant amount of process or memory.
I'm not sure I quite understand your setup here. You mean that without
replication you can max out a client's network connection using any
number of OSDs, but with replication you need to get up to 6 OSDs
before you max out the client's network connection?
