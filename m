From: Sage Weil <sage@newdream.net>
Subject: Re: Question about recovery vs backfill priorities
Date: Thu, 1 Dec 2016 22:10:33 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1612012158570.2097@piezo.novalocal>
References: <3b219d94-431d-0a4f-e656-826003028a9d@corp.ovh.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-284103546-1480630235=:2097"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42359 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750919AbcLAWKh (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Dec 2016 17:10:37 -0500
In-Reply-To: <3b219d94-431d-0a4f-e656-826003028a9d@corp.ovh.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-2?Q?Bart=B3omiej_=A6wi=EAcki?= <bartlomiej.swiecki@corp.ovh.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-284103546-1480630235=:2097
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi Bartek,

On Thu, 1 Dec 2016, Bartłomiej Święcki wrote:
> We're currently being hit by an issue with cluster recovery. The cluster size
> has been significantly extended (~50% new OSDs) and started recovery.
> During recovery there was a HW failure and we ended up with some PGS in peered
> state with size < min_size (inactive).
> Those peered PGs are waiting for backfill but the cluster still prefers
> recovery of recovery_wait PGs - in our case this could be even few hours
> before all recovery is finished (we're speeding up recovery up to limits to
> get the downtime as short as possible). Those peered PGs are blocked during
> this time and the whole cluster just struggles to operate at a reasonable
> level.
> 
> We're running hammer 0.94.6 there and from the code it looks like recovery
> will always have higher priority (jewel seems similar).
> Documentation only says that log-based recovery must finish before backfills.
> Is this requirement needed for data consistency or something else?

For a given single PG, it will do it's own log recovery (to bring acting 
OSDs fully up to date) before starting backfill, but between PGs there's 
no dependency.

> Ideally we'd like it to be this order: undersized inactive (size < min_size)
> recovery_wait => undersized inactive (size < min_size) wait_backfill =>
> degraded recovery_wait => degraded wait_backfill => remapped wait_backfill.
> Changing priority calculation doesn't seem to be that hard but would it end up
> with inconsistent data?

We could definitely improve this, yeah.  The prioritization code is based 
around PG::get_{recovery,backfill}_priority(), and the 
OSD_{RECOVERY,BACKFILL}_* #defines in PG.h.  It currently assumes (log) 
recovery is always higher priority than backfill, but as you say we can do 
better.  As long as everything maps into a 0..255 priority value it should 
be fine.

Getting the undersized inactive bumped to the top should be a simple tweak 
(just force a top-value priority in that case)...

sage
--8323329-284103546-1480630235=:2097--
