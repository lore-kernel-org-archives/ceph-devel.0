From: Sage Weil <sage@newdream.net>
Subject: Re: Backfill
Date: Fri, 11 Sep 2015 05:57:42 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1509110556430.7527@cobra.newdream.net>
References: <BLU175-W33B6417CFB278EA9EC4092DF500@phx.gbl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:58836 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752130AbbIKM5n (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 11 Sep 2015 08:57:43 -0400
In-Reply-To: <BLU175-W33B6417CFB278EA9EC4092DF500@phx.gbl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: GuangYang <yguang11@outlook.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "sjust@redhat.com" <sjust@redhat.com>

On Thu, 10 Sep 2015, GuangYang wrote:
> Today I played around recovery and backfill of a Ceph cluster (by 
> manually bringing some OSDs down/out), and got one question regards to 
> the current flow:
> 
> Does backfill push everything to the backfill target regardless what the 
> backfill target already has? The scenario is like - acting set of the PG 
> is [1, 2, 3], and 3 went down (at which point it already had some data) 
> and stayed down for a sustained period (but not marked out), during 
> which time there were sustained WRITE to the PG. At some point 3 went 
> back up, and it is not sufficient to recovery via PG log, so the PG 
> needed to be backfilled and 3 is the target. Does 1 needs to push 
> everything (last_backfill starts with MIN) to 3? It seems so to me as I 
> don't see some round trip to negotiate what each OSD has and do an 
> incremental push (as recovery does), but it would be nice to get confirm 
> :)

No.  Backfill iterates over objects on the source and destination and 
only pushes objects that are missing or out of date (and deletes ones 
that shouldn't be there).  This is all in ReplicatedPG::recover_backfill() 
(though it's not the easiest read).

sage
