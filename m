From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: building Ceph on various architectures
Date: Sun, 27 Feb 2011 19:42:24 -0800
Message-ID: <ACE7B038C1A34D9A88CDFFDBABDA2D87@gmail.com>
References: <1298720478.16174.14.camel@julia.gcs.org.hu>
 <C0A35234378B4D3A90BDEF41E55AF4A3@gmail.com>
 <1298749221.16174.29.camel@julia.gcs.org.hu>
 <E3D560F92CD249D4B2D590A54614CA08@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:42001 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752329Ab1B1Dmb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 27 Feb 2011 22:42:31 -0500
Received: by gxk8 with SMTP id 8so1372939gxk.19
        for <ceph-devel@vger.kernel.org>; Sun, 27 Feb 2011 19:42:30 -0800 (PST)
In-Reply-To: <E3D560F92CD249D4B2D590A54614CA08@gmail.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, Laszlo Boszormenyi <gcs@debian.hu>

On Saturday, February 26, 2011 at 11:52 AM, Gregory Farnum wrote:
On Saturday, February 26, 2011 at 11:40 AM, Laszlo Boszormenyi wrote: 
> > On Sat, 2011-02-26 at 10:28 -0800, Gregory Farnum wrote:
> > > This looks like an error that came up (and got fixed) on Ubuntu several months ago:
> > > https://bugs.launchpad.net/ubuntu/+source/ceph/+bug/635388
> >  Yes, it looks similar. But please note two things. The counterpart of
> > #635388 in Ubuntu is #597193 [1] in Debian. It was fixed on the 20th of
> > September, last year. Also, that bugs was:
> > 'AO_fetch_and_sub1_write' was not declared in this scope
> > Compared to this one:
> > 'AO_fetch_and_add_write' was not declared in this scope
> > 
> > I don't say it completely different, but doesn't look the exact same.
> 
> Ah, I didn't notice that -- I'll look into it more closely! 
>  I looked at this a bit more and there's nothing really obvious jumping out at me, but I do have a few observations/questions: 
1) It looks to me like this is the same error of definitions as previously. AO_fetch_and_sub1_write, AO_fetch_and_add_write, etc are in both bugs. (This is to be expected, since the most probable cause of atomic-ops issues are problems with definition chaining.)
2) I notice that this is in the compile output: "Kernel: Linux 2.6.31-rc9 armel (armv5tel)"
Does that mean it's building on an arm v5 machine?
I wonder if maybe there's an issue there -- my knowledge of the ARM architecture is extremely limited (basically just tracking issues like this down) but from what I've read there were some changes which could account for a bug like this. Notably, atomic-ops for arm depends on the "__arm__" preprocessor variable being defined, which I'd expect to be defined for any version but maybe isn't.

So, does anybody out there have more experience with ARM or the atomic-ops package? I can email the atomic-ops people but I'd like to make sure we aren't doing something odd ourselves!
-Greg



