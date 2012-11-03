From: Gregory Farnum <greg@inktank.com>
Subject: Re: active MDS and disk write cache
Date: Sat, 3 Nov 2012 18:43:03 +0100
Message-ID: <CAPYLRzihO1_oQT7_weXhbmUEqKdVOGC+20DrZNy+=D+G2g5cjA@mail.gmail.com>
References: <50915991.3030906@genome.wustl.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:59849 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751138Ab2KCRnH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 3 Nov 2012 13:43:07 -0400
Received: by mail-ia0-f174.google.com with SMTP id y32so3374476iag.19
        for <ceph-devel@vger.kernel.org>; Sat, 03 Nov 2012 10:43:03 -0700 (PDT)
In-Reply-To: <50915991.3030906@genome.wustl.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Matt Weil <mweil@genome.wustl.edu>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

I suspect "mon force standby active" is your problem:
http://ceph.com/wiki/Standby-replay_modes#mon_force_standby_active

Try disabling that?

On Wed, Oct 31, 2012 at 6:02 PM, Matt Weil <mweil@genome.wustl.edu> wrote:
> I have a system with a bunch or ram that I want to remain the active MDS but
> still have a backup.
>
> This config doesn't seem to be working.  I can make linuscs92 the active by
> stopping and starting the mds on linuscs95. It would be nice for linuscs92
> to be the active from the start.
>
> [mds.linuscs95]
>         host = linuscs95
>         mds standby replay = true
>         mds standby for name = linuscs92
>
> Also about disk write cache.
>
> If the Data center, servers and storage units are backed by redundant power
> sources, Batteries and a generator.  Is the concern for data loss less?

As long as your disk caches respect write flushing and ordering
commands, everything should be safe regardless of whether they're
battery-backed or not. :)
-Greg
