From: Sage Weil <sage@newdream.net>
Subject: Re: {pg_num} auto-tuning project
Date: Mon, 6 Nov 2017 03:32:31 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1711060328560.15257@piezo.novalocal>
References: <c6f3197f-2f17-efd2-778e-a95efdd1809f@cse.iitk.ac.in>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-67808201-1509939153=:15257"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from tragedy.dreamhost.com ([66.33.205.236]:33427 "EHLO
        tragedy.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751568AbdKFDce (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sun, 5 Nov 2017 22:32:34 -0500
In-Reply-To: <c6f3197f-2f17-efd2-778e-a95efdd1809f@cse.iitk.ac.in>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: bhavishya <bhavishya@cse.iitk.ac.in>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-67808201-1509939153=:15257
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Mon, 6 Nov 2017, bhavishya wrote:
> Hi,
> I'm resending this since last one failed due to html-subpart.
> 
> I started to work on {pg_num} autotuning project, needed your advice on some
> aspects:
> 
> 1)I'll add `pybind/module.py` which uses {pg_calc} formula to calculate
> {pg_num}. But for this I'll need the parameters required for {pg_calc}
> formaula...to get them...what should I do:
> 
> --> Use get('pg_summary')['all'] ...but where can I find the complete mapping 
> of  'pg_summary'?
> --> In OSDMonitor.cc I did found the ALLCHOICES map but it didn't had the all
> parameters.
> --> Anywhere else I should look?

To support hte balancer module I added a module interface that gives 
you the mappings for all PGs in a pool.  Is this what you're after?  
(map_pool_pgs_up()).  I would think that all you really care about is the 
pool metadata (how many pgs per pool) vs the OSD count and how much data 
is stored.  That is all available via the osdmap itself or the by-pool 
stats.

To see what is currently exposed to mgr modules you can look at 
get_python() in PyModules.cc.

sage

--8323329-67808201-1509939153=:15257--
