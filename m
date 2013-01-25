From: Sage Weil <sage@inktank.com>
Subject: lagging peering wq
Date: Fri, 25 Jan 2013 09:50:07 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1301250946420.14545@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:51222 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755627Ab3AYRuH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 25 Jan 2013 12:50:07 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sam.just@inktank.com
Cc: ceph-devel@vger.kernel.org

Faidon/paravoid's cluster has a bunch of OSDs that are up, but the pg 
queries indicate they are tens of thousands of epochs behind:

      "history": { "epoch_created": 14,
          "last_epoch_started": 88174,
          "last_epoch_clean": 88174,
          "last_epoch_split": 0,
          "same_up_since": 88172,
          "same_interval_since": 88172,
          "same_primary_since": 88172,

(where the current map epoch is 102000 or thereabouts).

I think just restarting all OSDs at once will get him caught up (esp with 
a 'ceph osd set noup' block until they are done processing maps), but I 
wonder if we may want an additional check that if any PG falls more than X 
epochs behind the OSD marks it self down and catches up before coming 
in...

What do you think?

sage
