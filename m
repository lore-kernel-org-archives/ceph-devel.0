From: Sage Weil <sweil@redhat.com>
Subject: Re: Multiple OSDs suicide because of client issues?
Date: Mon, 23 Nov 2015 11:32:02 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1511231131000.11017@cobra.newdream.net>
References: <CAANLjFqL82wLfrYDD-LNgctWR=MpHWJ=PxfQJ8g2Ntbv8fgu2g@mail.gmail.com> <CAJ4mKGb5F+cuUKdU6PHs47sed9ZCb+qEnNDvxfuxB=vFyDx96A@mail.gmail.com> <CAANLjFo=vCsny5=JW1wYiQk5S=oXdtVd0OzXEC=uTGgmDO9ydA@mail.gmail.com> <CAJ4mKGbYrDOpiEJiMKZwHaEHGrZT=b58GjzYg4x35U1XtDbDWg@mail.gmail.com>
 <CAANLjFpn+MGw4cY7aZarLuXgiVznovaJGXY2wtXwMmm8n24Qsw@mail.gmail.com> <CAJ4mKGaA=OnH3XPM=m5JE+1Rwc38gsmwrJv3FP1MCY5qO1nYrg@mail.gmail.com> <CAANLjFoyAyDrxoGLTdPwzRN12ffqkHqNeXgBZBmG+s7i02WBCw@mail.gmail.com> <CAJ4mKGawUUwAB7DC6uWf=6xVGpeg=ac3PB1wx2_3msDPCYDkOw@mail.gmail.com>
 <CAANLjFq-eqTy4XN_YTMyS0M2h4Smo1GNSmuqL+FuDAZDG3yXGg@mail.gmail.com> <alpine.DEB.2.00.1511231110530.11017@cobra.newdream.net> <CAANLjFrU0aDV44u7srskMOCHvFaHYEG4kdxnhxH_MMxW6S9Mfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60424 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750914AbbKWTcF (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 23 Nov 2015 14:32:05 -0500
In-Reply-To: <CAANLjFrU0aDV44u7srskMOCHvFaHYEG4kdxnhxH_MMxW6S9Mfw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Robert LeBlanc <robert@leblancnet.us>
Cc: Gregory Farnum <gfarnum@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Mon, 23 Nov 2015, Robert LeBlanc wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA256
> 
> Is there a way through the admin socket or inject args that can tell
> the OSD process to dump the in memory logs without crashing? Do you

Yep, 'ceph daemon osd.NN log dump'.

> have an idea of the overhead? From the code it looks like it is always
> evaluated, just depends on if it is stored in memory or dumped to
> disk. I'm trying to figure out an issue with dout() right now in the
> code I'm working on (invalid use of static member) and I'm trying to
> understand how it works.

What's the error and problematic line?

sage
