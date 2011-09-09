From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: questions of pg scrub
Date: Thu, 8 Sep 2011 17:35:46 -0700
Message-ID: <CAF3hT9CxANXA4M79QsXKuipWDN_rOE4WKoq=t9U1Wd8-iVPbGg@mail.gmail.com>
References: <CABAwU-Zfvy_Un1YQirpiDhontLDPi4DRjJDBK=Z4KutA2dpOOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:61131 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757450Ab1IIAfr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Sep 2011 20:35:47 -0400
Received: by gxk21 with SMTP id 21so607432gxk.5
        for <ceph-devel@vger.kernel.org>; Thu, 08 Sep 2011 17:35:46 -0700 (PDT)
In-Reply-To: <CABAwU-Zfvy_Un1YQirpiDhontLDPi4DRjJDBK=Z4KutA2dpOOw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

[resend to list]

2011/9/7 huang jun <hjwsm1989@gmail.com>:
> hi,all
> Recently,i read the source code of PG scrub.The ceph periodically
> shed_scrub if the system load is not too high. And adminstrator can
> manually scrub the specified OSD or PG using cmds.
> but many questions come along with me when i got thourgh .
> why did ceph need scrub?
> what scrub used for?
Scrubbing is intended to do a few things. First, any large storage
system needs to periodically look at the data it's holding in order to
make sure the data stays safe -- that the underlying hardware is still
working (and the sectors are good), that cosmic rays haven't flipped
bits, etc. Right now, Ceph's scrubbing is primitive: it only looks at
the file sizes and a few other metadata attributes, and compares them
to the ones it thinks the file should have and to what other storage
nodes have. Eventually, it will be a great deal more involved than
that, though!
> because the OSD use three threads to handle the scrub transactions,
> maybe it has a great effect on the stablity or performance of ceph?
Well, background scrubbing (which the OSDs do automatically) is
careful to only initiate scrubs when it won't impact users. If the
administrator starts a scrub, it might. The number of threads involved
isn't going to cause a problem, though -- they're used for synchronous
IO and don't create a lot of CPU usage.
-Greg
