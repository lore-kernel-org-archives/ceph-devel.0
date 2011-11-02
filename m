From: Sage Weil <sage@newdream.net>
Subject: Re: BUG at fs/inode.c
Date: Wed, 2 Nov 2011 07:23:14 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1111020713070.2549@cobra.newdream.net>
References: <201110241239.13157.a.ott@m-privacy.de> <201111010923.18074.a.ott@m-privacy.de>
 <Pine.LNX.4.64.1111010907470.30839@cobra.newdream.net>
 <201111020953.45095.a.ott@m-privacy.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:37031 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753673Ab1KBOXP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Nov 2011 10:23:15 -0400
In-Reply-To: <201111020953.45095.a.ott@m-privacy.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Amon Ott <a.ott@m-privacy.de>
Cc: Yehuda Sadeh Weinraub <yehuda.sadeh@dreamhost.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, 2 Nov 2011, Amon Ott wrote:
> On Tuesday 01 November 2011 wrote Sage Weil:
> > Can you capture a larger log segment?  The hope is to catch the first
> > use-after-free, and not the subsequent side-effects.
> 
> I still have the full kern.log here from boot till BUG, cleaned it up a bit 
> (no firewall lines, RSBAC stuff) and uploaded to 
> https://download.m-privacy.de/kern-full.log.bz2
> 
> Full ceph logging had been enabled as soon as possible, after boot and before 
> mounting ceph fs.
> 
> > Also, the below patch may help us parse the output with multiple threads.

The following would also help: 4f9ea86237b8d0005f5467fe817b4f1f0955072c, 
or wip-debug-inode-refs in ceph-client.git.

Thanks!
sage
