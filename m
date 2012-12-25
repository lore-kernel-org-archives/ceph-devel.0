From: Sage Weil <sage@inktank.com>
Subject: Re: automatic repair of inconsistent pg?
Date: Mon, 24 Dec 2012 22:54:49 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1212242252040.32156@cobra.newdream.net>
References: <50D908FA.7010907@profihost.ag>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42830 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751295Ab2LYGyu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Dec 2012 01:54:50 -0500
In-Reply-To: <50D908FA.7010907@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, 25 Dec 2012, Stefan Priebe wrote:
> Hello list,
> 
> today i got the following ceph status output:
> 2012-12-25 02:57:00.632945 mon.0 [INF] pgmap v1394388: 7632 pgs: 7631
> active+clean, 1 active+clean+inconsistent; 151 GB data, 307 GB used, 5028 GB /
> 5336 GB avail
> 
> 
> i then grepped the inconsistent pg by:
> # ceph pg dump - | grep inconsistent
> 3.ccf   10      0       0       0       41037824        155930  155930
> active+clean+inconsistent       2012-12-25 01:51:35.318459 6243'2107
> 6190'9847       [14,42] [14,42] 6243'2107       2012-12-25 01:51:35.318436
> 6007'2074       2012-12-23 01:51:24.386366
> 
> and initiated a repair:
> #  ceph pg repair 3.ccf
> instructing pg 3.ccf on osd.14 to repair
> 
> The log output then was:
> 2012-12-25 02:56:59.056382 osd.14 [ERR] 3.ccf osd.42 missing
> 1c602ccf/rbd_data.4904d6b8b4567.0000000000000b84/head//3
> 2012-12-25 02:56:59.056385 osd.14 [ERR] 3.ccf osd.42 missing
> ceb55ccf/rbd_data.48cc66b8b4567.0000000000001538/head//3
> 2012-12-25 02:56:59.097989 osd.14 [ERR] 3.ccf osd.42 missing
> dba6bccf/rbd_data.4797d6b8b4567.00000000000015ad/head//3
> 2012-12-25 02:56:59.097991 osd.14 [ERR] 3.ccf osd.42 missing
> a4deccf/rbd_data.45f956b8b4567.00000000000003d5/head//3
> 2012-12-25 02:56:59.098022 osd.14 [ERR] 3.ccf repair 4 missing, 0 inconsistent
> objects
> 2012-12-25 02:56:59.098046 osd.14 [ERR] 3.ccf repair 4 errors, 4 fixed
> 
> Why doesn't ceph repair this automatically? Ho could this happen at all?

We just made some fixes to repair in next (it was broken sometime between 
~0.53 and 0.55).  The latest next should repair it.  In general we don't 
repair automatically lest we inadvertantly propagate bad data or paper 
over a bug.

As for the original source of the missing objects... I'm not sure.  There 
were some fixed races related to backfill that could lead to an object 
being missed, but Sam would know more about how likely that actually is.

sage
