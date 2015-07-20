From: Sage Weil <sage@newdream.net>
Subject: Re: [Documentation] Hardware recommandation : RAM and PGLog
Date: Mon, 20 Jul 2015 06:13:33 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1507200610310.8878@cobra.newdream.net>
References: <55ABC8E5.1030304@aevoo.fr> <55ABCB49.1080304@aevoo.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:43969 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932126AbbGTNNd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 20 Jul 2015 09:13:33 -0400
In-Reply-To: <55ABCB49.1080304@aevoo.fr>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Casier AEVOO <david.casier@aevoo.fr>
Cc: ceph-devel@vger.kernel.org

On Sun, 19 Jul 2015, David Casier AEVOO wrote:
> Hi,
> I have a question about PGLog and RAM consumption.
> 
> In the documentation, we read "OSDs do not require as much RAM for regular
> operations (e.g., 500MB of RAM per daemon instance); however, during recovery
> they need significantly more RAM (e.g., ~1GB per 1TB of storage per daemon)"
> 
> But in fact, all pg log are read in the start of ceph-osd daemon and put in
> RAM ( pg->read_state(store, bl); )
> 
> Is this normal behavior or I have a defect in my environment?

There are two tunables that control how many pg log entries we keep 
around.  When teh PG is healthy, we keep ~1000, and when the PG is 
degraded, we keep more, to expand the time window over which a recovering 
OSD will be able to do regular log-based recovery instead of a more 
expensive backfill.  This is one source of additional memory.

Others are the missing sets (lists of missing/degraded objects) and 
messages/data/state associated with objcts that are being 
recovered/copied.

Note that the numbers in teh documentation are pretty rough rules of 
thumb.  At some point it would be great to build a model for how much RAM 
the osd consumes as a function of the various configurables (pg log size, 
pg count, avg object size, etc.).

sage
