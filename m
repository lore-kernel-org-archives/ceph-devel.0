From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: Ceph on just two nodes being clients - reasonable?
Date: Wed, 19 Jan 2011 13:09:58 -0800
Message-ID: <AANLkTi=r5+wKgZ8yoDkFU2LM7_-+JZ-PKagTQ4wkhUV2@mail.gmail.com>
References: <4D36BDF9.4030404@wpkg.org>
	<1295437286.2255.25.camel@wido-desktop>
	<4D36D5B3.4040601@wpkg.org>
	<AANLkTimHi64ZB5_AY1_eQu5abHB+S+bvcSShL_NE3Me0@mail.gmail.com>
	<AANLkTikFWk_p0=c1_o__2EmPS7t-=Ua68cLWGNS9badB@mail.gmail.com>
	<20110119200349.GA753@dreamer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:62198 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753885Ab1ASVKA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Jan 2011 16:10:00 -0500
Received: by fxm20 with SMTP id 20so1336083fxm.19
        for <ceph-devel@vger.kernel.org>; Wed, 19 Jan 2011 13:09:59 -0800 (PST)
In-Reply-To: <20110119200349.GA753@dreamer>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: Gregory Farnum <gregf@hq.newdream.net>, Tomasz Chmielewski <mangoo@wpkg.org>, Wido den Hollander <wido@widodh.nl>, ceph-devel@vger.kernel.org

On Wed, Jan 19, 2011 at 12:03 PM, Tommi Virtanen
<tommi.virtanen@dreamhost.com> wrote:
> On Wed, Jan 19, 2011 at 09:55:27AM -0800, Colin McCabe wrote:
>> If you knew what the maximum memory consumption for the daemons would
>> be, you could use mlock to lock all those pages into memory (make them
>> unswappable.) Then you could use rlimit to ensure that if the daemon
>> ever tried to allocate more than that, it would be killed.
>
> The classic nfs loopback mount deadlock is less about how much memory
> the daemons are grabbing via malloc etc, and more about the buffer
> cache management in kernel.

My understanding is that nfsd tries to allocate memory, which turns
out to be impossible because the page cache is occupying that memory,
and requires nfsd to drain.

I guess the question you are asking is whether nfsd just doing I/O
requires kernel memory that might not be available. I'm not entirely
sure about the answer to that. Unfortunately, none of those links has
any information on the subject (I had high hopes for the lkml one, but
it was about an unrelated race in NFS).

Colin
