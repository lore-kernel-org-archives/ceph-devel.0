From: Sage Weil <sage@newdream.net>
Subject: Re: The stability of OSD
Date: Sun, 27 Mar 2011 21:37:47 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1103272132240.6107@cobra.newdream.net>
References: <AANLkTinCNSuWXPQVaSOD82eXaRCtT5FKA=-0JFFTc51p@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36690 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750699Ab1C1Eez (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Mar 2011 00:34:55 -0400
In-Reply-To: <AANLkTinCNSuWXPQVaSOD82eXaRCtT5FKA=-0JFFTc51p@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sylar Shen <kimulaaa@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Mon, 28 Mar 2011, Sylar Shen wrote:
> Hi,
> I set an environment of 20 servers which include 2 MDSs, 3 MONs and 18
> OSDes(3 monitors on 18 OSDes)
> My version is 0.24.3 and OS is Fedora 14.
> There's a problem when I was doing the writing tests.
> Whether I was writing the data or not, some OSDes were randomly marked
> down and out one by one after a period of time.
> And when that happened, the whole performance soon got worse and worse.
> I checked the /var/log/ceph/osd.log but found nothing.
> So I am curious that is there anyone who has the same problem with me?
> Or maybe it's just a problem of my hardware......><

Hi Sylar,

This is/was a known problem.  There's a long thread from a couple weeks 
back with Jim Schutt debugging the issue.  We've fixed a few different 
things that have significantly improved the situation, but the heartbeats 
are still failing from time to time.

I suspect using a more recent release will be sufficient at your scale, 
either 0.25.2 or the latest 'next' branch from git (there are autobuilt 
debs for that too).  You can also increase the 'osd heartbeat grace' to 
make the system less sensitive to the transient hangs that are preventing 
the heartbeats from going out.

Please let us know what you find, either here or on #ceph.

Thanks!
sage

	

