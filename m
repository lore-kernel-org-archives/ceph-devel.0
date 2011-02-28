From: Laszlo Boszormenyi <gcs@debian.hu>
Subject: Re: building Ceph on various architectures
Date: Mon, 28 Feb 2011 07:23:39 +0100
Message-ID: <1298874219.12041.14.camel@julia.gcs.org.hu>
References: <1298720478.16174.14.camel@julia.gcs.org.hu>
	 <C0A35234378B4D3A90BDEF41E55AF4A3@gmail.com>
	 <1298749221.16174.29.camel@julia.gcs.org.hu>
	 <E3D560F92CD249D4B2D590A54614CA08@gmail.com>
	 <ACE7B038C1A34D9A88CDFFDBABDA2D87@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.routers.hu ([212.40.96.82]:47647 "EHLO mail.routers.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750802Ab1B1GXk (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 28 Feb 2011 01:23:40 -0500
Received: from localhost (localhost [127.0.0.1])
	by mail.routers.hu (Postfix) with ESMTP id 8C4F4B4A3C
	for <ceph-devel@vger.kernel.org>; Mon, 28 Feb 2011 07:47:32 +0100 (CET)
Received: from mail.routers.hu ([127.0.0.1])
	by localhost (sum.routers.hu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R93li13d2LxG for <ceph-devel@vger.kernel.org>;
	Mon, 28 Feb 2011 07:47:32 +0100 (CET)
Received: from [192.168.0.100] (kabelnet-248-67.parisat.hu [91.147.248.67])
	by mail.routers.hu (Postfix) with ESMTPA id 6AB44B4A2F
	for <ceph-devel@vger.kernel.org>; Mon, 28 Feb 2011 07:47:32 +0100 (CET)
In-Reply-To: <ACE7B038C1A34D9A88CDFFDBABDA2D87@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On Sun, 2011-02-27 at 19:42 -0800, Gregory Farnum wrote:
> On Saturday, February 26, 2011 at 11:52 AM, Gregory Farnum wrote:
> On Saturday, February 26, 2011 at 11:40 AM, Laszlo Boszormenyi wrote: 
> > > On Sat, 2011-02-26 at 10:28 -0800, Gregory Farnum wrote:
> > > > This looks like an error that came up (and got fixed) on Ubuntu several months ago:
> > > > https://bugs.launchpad.net/ubuntu/+source/ceph/+bug/635388
> > >  Yes, it looks similar. But please note two things. The counterpart of
> > > #635388 in Ubuntu is #597193 [1] in Debian. It was fixed on the 20th of
> > > September, last year. Also, that bugs was:
> > > 'AO_fetch_and_sub1_write' was not declared in this scope
> > > Compared to this one:
> > > 'AO_fetch_and_add_write' was not declared in this scope
> > > 
> > > I don't say it completely different, but doesn't look the exact same.
> > 
> > Ah, I didn't notice that -- I'll look into it more closely! 
> >  I looked at this a bit more and there's nothing really obvious jumping out at me, but I do have a few observations/questions: 
> 1) It looks to me like this is the same error of definitions as previously. AO_fetch_and_sub1_write, AO_fetch_and_add_write, etc are in both bugs. (This is to be expected, since the most probable cause of atomic-ops issues are problems with definition chaining.)
 Well, can be. As I see, the original bug was fixed in Debian as
well[1].

> 2) I notice that this is in the compile output: "Kernel: Linux 2.6.31-rc9 armel (armv5tel)"
> Does that mean it's building on an arm v5 machine?
> I wonder if maybe there's an issue there -- my knowledge of the ARM architecture is extremely limited (basically just tracking issues like this down) but from what I've read there were some changes which could account for a bug like this. Notably, atomic-ops for arm depends on the "__arm__" preprocessor variable being defined, which I'd expect to be defined for any version but maybe isn't.
 I have to run and will have time only in the afternoon (CET). Until
then I can give you only pointers. The email list of ARM porters:
http://lists.debian.org/debian-arm/ . It's not moderated, so you can
post there. IRC can be faster, you can find #debian-arm on
irc.debian.org .

HTH,
Laszlo/GCS
[1] http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=597193

