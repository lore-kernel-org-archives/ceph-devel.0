From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: Ceph on just two nodes being clients - reasonable?
Date: Wed, 19 Jan 2011 09:55:27 -0800
Message-ID: <AANLkTikFWk_p0=c1_o__2EmPS7t-=Ua68cLWGNS9badB@mail.gmail.com>
References: <4D36BDF9.4030404@wpkg.org>
	<1295437286.2255.25.camel@wido-desktop>
	<4D36D5B3.4040601@wpkg.org>
	<AANLkTimHi64ZB5_AY1_eQu5abHB+S+bvcSShL_NE3Me0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:41936 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753208Ab1ASRz2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Jan 2011 12:55:28 -0500
Received: by fxm20 with SMTP id 20so1144239fxm.19
        for <ceph-devel@vger.kernel.org>; Wed, 19 Jan 2011 09:55:27 -0800 (PST)
In-Reply-To: <AANLkTimHi64ZB5_AY1_eQu5abHB+S+bvcSShL_NE3Me0@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregf@hq.newdream.net>
Cc: Tomasz Chmielewski <mangoo@wpkg.org>, Wido den Hollander <wido@widodh.nl>, ceph-devel@vger.kernel.org

On Wed, Jan 19, 2011 at 7:57 AM, Gregory Farnum <gregf@hq.newdream.net> wrote:

> However, there is a serious issue with running clients and servers on
> one machine, which may or may not be a problem depending on your use
> case: Deadlock becomes a significant possibility. This isn't a problem
> we've come up with a good solution for, unfortunately, but imagine
> you're writing a lot of files to Ceph. Ceph dutifully writes them and
> the kernel dutifully caches them. You also have a lot of write
> activity so the Ceph kernel client is doing local caching. Then the
> kernel comes along and says "I'm low on memory! Flush stuff to disk!"
> and the kernel client tries to flush it out...which involves creating
> another copy of the data in memory on the same machine. Uh-oh!
> Now if you use the FUSE client this won't be an issue, but your
> performance also won't be so good. :/

If you knew what the maximum memory consumption for the daemons would
be, you could use mlock to lock all those pages into memory (make them
unswappable.) Then you could use rlimit to ensure that if the daemon
ever tried to allocate more than that, it would be killed.

That would prevent the scenario you outlined above where there is not
enough memory to flush the page cache. Of course, to do this, we would
need to reduce memory consumption and make it deterministic for this
to be feasible.

cheers,
Colin
