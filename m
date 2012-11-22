From: Sage Weil <sage@inktank.com>
Subject: Re: Hangup during scrubbing - possible solutions
Date: Thu, 22 Nov 2012 12:35:27 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1211221234020.9963@cobra.newdream.net>
References: <CABYiri-YGDCCzVD2kcJeZQy4ggWBDt0cC8TrHQxTp4tOeabQew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44782 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755542Ab2KVUf2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Nov 2012 15:35:28 -0500
In-Reply-To: <CABYiri-YGDCCzVD2kcJeZQy4ggWBDt0cC8TrHQxTp4tOeabQew@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrey Korolyov <andrey@xdel.ru>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, 22 Nov 2012, Andrey Korolyov wrote:
> Hi,
> 
> In the recent versions Ceph introduces some unexpected behavior for
> the permanent connections (VM or kernel clients) - after crash
> recovery, I/O will hang on the next planned scrub on the following
> scenario:
> 
> - launch a bunch of clients doing non-intensive writes,
> - lose one or more osd, mark them down, wait for recovery completion,
> - do a slow scrub, e.g. scrubbing one osd per 5m, inside bash script,
> or wait for ceph to do the same,
> - observe a raising number of pgs stuck in the active+clean+scrubbing
> state (they took a master role from ones which was on killed osd and
> almost surely they are being written in time of crash),
> - some time later, clients will hang hardly and ceph log introduce
> stuck(old) I/O requests.
> 
> The only one way to return clients back without losing their I/O state
> is per-osd restart, which also will help to get rid of
> active+clean+scrubbing pgs.
> 
> First of all, I`ll be happy to help to solve this problem by providing
> logs.

If you can reproduce this behavior with 'debug osd = 20' and 'debug ms = 
1' logging on the OSD, that would be wonderful!

> Second question is not directly related to this problem, but I
> have thought on for a long time - is there a planned features to
> control scrub process more precisely, e.g. pg scrub rate or scheduled
> scrub, instead of current set of timeouts which of course not very
> predictable on when to run?

Not yet.  I would be interested in hearing what kind of control/config 
options/whatever you (and others) would like to see!

Thanks-
sage
