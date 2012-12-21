From: Sage Weil <sage@inktank.com>
Subject: Re: mon not marking dead osds down and slow streaming write
 performance
Date: Thu, 20 Dec 2012 16:37:14 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1212201633590.16508@cobra.newdream.net>
References: <CABf87Xk54Q-SP2258MsXDVKAo2TgjOw8xds2f9W=XxmgdSRFTA@mail.gmail.com> <alpine.DEB.2.00.1212201046050.16508@cobra.newdream.net> <CABf87XmB9qgusXdSgfPD9qnDtMuCyFtWk_tyX8h8=fSZGs6=Ag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:56475 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751344Ab2LUAhP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 20 Dec 2012 19:37:15 -0500
In-Reply-To: <CABf87XmB9qgusXdSgfPD9qnDtMuCyFtWk_tyX8h8=fSZGs6=Ag@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Michael Chapman <michael.chapman@anu.edu.au>
Cc: ceph-devel@vger.kernel.org

On Fri, 21 Dec 2012, Michael Chapman wrote:
> I'll remove them properly. Thanks for your help. Do you have any
> suggestions on the second (mon IO) issue I'm seeing?

Whoops, missed it:

> >> A second issue I have been having is that my reads+writes are very
> >> bursty, going from 8MB/s to 200MB/s when doing a dd from a physical
> >> client over 10GbE. It seems to be waiting on the mon most of the time,
> >> and iostat shows long io wait times for the disk the mon is using. I
> >> can also see it writing ~40MB/s constantly to disk in iotop, though I
> >> don't know if this is random or sequential. I see a lot of waiting for
> >> sub ops which I thought might be a result of the io wait.
> >>
> >> Is that a normal amount of activity for a mon process? Should I be
> >> running the mon processes off more than just a single sata disk to
> >> keep up with ~30 OSD processes?

Is the ceph-mon daemon running on its own disk (or /), separate from the 
osds?  My first guess is that this is could be a sync(2) issue.  The 
ceph-mon daemon is running on teh same host as some of the osds?  If you 
have an older kernel (pre-3.0), or you are running argonaut and have an 
old glibc, there is no syncfs(2) syscall, and multiple osds can drag 
each other down by doing lots of commits.  That often leads to the 
bursty writes.

Having the osd journals stored as files also contributes.  Using a 
separate partition (or, idealy, part of an SSD or caching raid array) 
helps quite a bit.

In general, 30 osds is very small, and should cause no significant monitor 
load.  But the monitor is doing lots of fsync(), which can interfere with 
other workloads if its on the same disk.

sage
