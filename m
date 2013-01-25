From: Gregory Farnum <greg@inktank.com>
Subject: Re: lagging peering wq
Date: Fri, 25 Jan 2013 10:01:33 -0800
Message-ID: <FCA7E277340B4E18BB343E80E78D3E13@inktank.com>
References: <alpine.DEB.2.00.1301250946420.14545@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f47.google.com ([209.85.210.47]:46192 "EHLO
	mail-da0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756793Ab3AYSBj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 25 Jan 2013 13:01:39 -0500
Received: by mail-da0-f47.google.com with SMTP id s35so278436dak.20
        for <ceph-devel@vger.kernel.org>; Fri, 25 Jan 2013 10:01:38 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1301250946420.14545@cobra.newdream.net>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>, sam.just@inktank.com
Cc: ceph-devel@vger.kernel.org

On Friday, January 25, 2013 at 9:50 AM, Sage Weil wrote:
> Faidon/paravoid's cluster has a bunch of OSDs that are up, but the pg 
> queries indicate they are tens of thousands of epochs behind:
> 
> "history": { "epoch_created": 14,
> "last_epoch_started": 88174,
> "last_epoch_clean": 88174,
> "last_epoch_split": 0,
> "same_up_since": 88172,
> "same_interval_since": 88172,
> "same_primary_since": 88172,
> 
> (where the current map epoch is 102000 or thereabouts).
> 
> I think just restarting all OSDs at once will get him caught up (esp with 
> a 'ceph osd set noup' block until they are done processing maps), but I 
> wonder if we may want an additional check that if any PG falls more than X 
> epochs behind the OSD marks it self down and catches up before coming 
> in...
> 
> What do you think?

Sam's explained to me why this "shouldn't" happen (since events for each PG get queued on every map update), so it sounds like it would be better to prevent the mess (e.g., add some basic fairness to the PG work queue dispatchers in order to prevent any PG from falling so far behind), rather than trying to clean the mess up.
-Greg

