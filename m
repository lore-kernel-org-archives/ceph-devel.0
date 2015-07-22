From: Sage Weil <sage@newdream.net>
Subject: Re: Inactive PGs should trigger a HEALTH_ERR state
Date: Wed, 22 Jul 2015 06:00:08 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1507220558480.8878@cobra.newdream.net>
References: <55AF6C3F.3060505@42on.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:55844 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754259AbbGVNAK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 22 Jul 2015 09:00:10 -0400
In-Reply-To: <55AF6C3F.3060505@42on.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Wed, 22 Jul 2015, Wido den Hollander wrote:
> Hi,
> 
> I was just testing with a cluster on VMs and I noticed that
> undersized+degraded+peering PGs do not trigger a HEALTH_ERR state. Why
> is that?
> 
> In my opinion any PG which is not active+? should trigger a HEALTH_ERR
> state since I/O is blocking at that point.
> 
> Is that a sane thing to do or am I missing something?

IIRC they trigger a WARN state until they are 'stuck' inactive, at which 
point they trigger an ERR state.  The idea is that it is totally normal 
for PGs to be in an inactive state for short periods due to normal cluster 
churn--it's only problematic if they get stuck there.

sage
