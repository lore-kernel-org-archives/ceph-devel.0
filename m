From: Sage Weil <sage@newdream.net>
Subject: Re: Quering since when a PG is inactive
Date: Wed, 9 Dec 2015 05:50:44 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1512090549400.12816@cobra.newdream.net>
References: <5667DE37.4080502@42on.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:38711 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753131AbbLINuo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Dec 2015 08:50:44 -0500
In-Reply-To: <5667DE37.4080502@42on.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi Wido!

On Wed, 9 Dec 2015, Wido den Hollander wrote:
> Hi,
> 
> I'm working on a patch in PGMonitor.cc that sets the state to HEALTH_ERR
> if >= X PGs are stuck non-active.
> 
> This works for me now, but I would like to add a timer that a PG has to
> be inactive for more than Y seconds.
> 
> The PGMap contains "last_active" and "last_clean", but these timestamps
> are never updated. So I can't query for last_active =< (now() - 300) for
> example.
> 
> On a idle test cluster I have a PG for example:
> 
> "last_active": "2015-12-09 02:32:31.540712",
> 
> It's currently 08:53:56 here, so I can't check against last_active.
> 
> What would a good way be to see for how long a PG has been inactive?

It sounds like maybe the current code is subtley broken:

	https://github.com/ceph/ceph/blob/master/src/osd/PG.cc#L2566

The last_active/clean etc should be fresh within 
osd_pg_stat_report_interval_max seconds...

sage
