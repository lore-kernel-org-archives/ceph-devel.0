From: Sage Weil <sage@newdream.net>
Subject: Re: Bug #1047 reproduced
Date: Fri, 27 Jan 2012 06:50:40 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1201270648060.25956@cobra.newdream.net>
References: <201112010937.37642.a.ott@m-privacy.de>
 <CAF3hT9BrL8WJbG2cgDADfSZk02HWwi4Q2MgK_yu6fiDSyZrwRg@mail.gmail.com>
 <201112291230.59323.a.ott@m-privacy.de> <201201271523.54502.a.ott@m-privacy.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:53506 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751589Ab2A0Oul (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 27 Jan 2012 09:50:41 -0500
In-Reply-To: <201201271523.54502.a.ott@m-privacy.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Amon Ott <a.ott@m-privacy.de>
Cc: Gregory Farnum <gregory.farnum@dreamhost.com>, ceph-devel@vger.kernel.org

On Fri, 27 Jan 2012, Amon Ott wrote:
> On Thursday 29 December 2011 wrote Amon Ott:
> > I finally got the test cluster freed up for more Ceph testing.
> >
> > On Friday 23 December 2011 wrote Gregory Farnum:
> > > Unfortunately there's not enough info in this log either. If you can
> > > reproduce it with "mds debug = 20" and put that log somewhere, it
> > > ought to be enough to work out what's going on, though. Sorry. :(
> > > -Greg
> >
> > Here is what MDS logs with debug 20. No idea if it really helps. The
> > cluster is still in the broken state, should I try to reproduce with a
> > recreated ceph fs and debug 20? This could be GBs of logs.
> 
> Update: I recreated the Ceph FS with release 0.40. It broke only because of a 
> btrfs bug hitting two of the four nodes (after ca. one day of heavy load) and 
> recovered without problems when the nodes were back. Then I recreated with 
> ext4 as osd storage area and have not managed to break it within four days, 
> two of these under heavy load.
> 
> This means that this bug is probably fixed. It might be related to the 
> automatic reconnect of mds, which avoids meta data inconsistencies. :)

Yeah, I suspect that the problem is related to the MDS journal replay and 
the two-phase-commit stuff going on with the anchor table updates.  I 
think we should keep this open until we can do MDS restart thrashing 
against a heavy link workload.

Unless there was something you found/fixed before, Greg?

Thanks for keeping an eye on this, Amon!

sage
