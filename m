From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: osd crash during resync
Date: Tue, 24 Jan 2012 13:13:58 -0800
Message-ID: <CAF3hT9CMxL6eQMgNebdMifZ9CgcVGHNPhqV30Auh+on9HBKefQ@mail.gmail.com>
References: <4F1EFCFA.3060607@tuxadero.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:61516 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755844Ab2AXVN6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 24 Jan 2012 16:13:58 -0500
Received: by iacb35 with SMTP id b35so5868913iac.19
        for <ceph-devel@vger.kernel.org>; Tue, 24 Jan 2012 13:13:58 -0800 (PST)
In-Reply-To: <4F1EFCFA.3060607@tuxadero.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: martin@tuxadero.com
Cc: ceph-devel@vger.kernel.org

On Tue, Jan 24, 2012 at 10:48 AM, Martin Mailand <martin@tuxadero.com> wrote:
> Hi,
> today I tried the btrfs patch mentioned on the btrfs ml. Therefore I
> rebooted osd.0 with a new kernel and created a new btrfs on the osd.0, than
> I took the osd.0 into the cluster. During the the resync of osd.0 osd.2 and
> osd.3 crashed.
> I am not sure, if the crashes happened because I played with osd.0, or if
> they are bugs.

These are OSD-level issues not caused by btrfs, so your new kernel
definitely didn't do it. It's probably fallout from the backfill
changes that got merged in last week. I created new bugs to track
them: http://tracker.newdream.net/issues/1982 (1983, 1984). Sam and
Josh are going wild on some other issues that we've turned up and
these have been added to the queue as soon as somebody qualified can
get to them. :)
-Greg
