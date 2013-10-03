From: Sage Weil <sage@inktank.com>
Subject: a couple hot/cold classification storage papers
Date: Thu, 3 Oct 2013 13:21:29 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1310031248350.6800@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45360 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754884Ab3JCUV3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Oct 2013 16:21:29 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 323C280079
	for <ceph-devel@vger.kernel.org>; Thu,  3 Oct 2013 13:21:29 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 102DB80079
	for <ceph-devel@vger.kernel.org>; Thu,  3 Oct 2013 13:21:29 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

http://131.107.65.14/pubs/176690/ColdDataClassification-icde2013-cr.pdf

 - identify hot/cold records for an in-memory database
 - in-memory lru is discarded ot of hand due to overhead
 - they do a simple log (or log a sample of say 10% of accesses) an 
present various algorithms for estimating K hottests items from that.
 - their 'backward' algorithm scans the log in reverse chronological 
order.  once it figures out no further items can be found that compete 
with what is hottest so far it can terminate early.
 - they seem to assume that every record is in the log, or that anything 
not in the log is already known cold and not of interest.  so, not quite 
the same problem as us unless we log for all time.

Thought: 
 We could only trim a hitset/bloom filter/whatever once every hash key 
 that appears in that set but not later sets has been demoted/purged.  In 
 our case, that could mean:

  - initial pass that enumerates all object and pushes untouched stuff (as 
    we've previosly discussed)
  - thereafter, the agent scans from 0..2^32 and enumerates any hash 
    values appearing in the oldest sets but not newer ones and only pushes those 
    down.

 Not sure how tractable that might be.  If we explicitly listed object 
 names in each hitset it would certainly work.

---

http://dmclab.hanyang.ac.kr/wikidata/ssd/2012_ssd_seminar/MSST_2011/HotDataIdentification_DongchulPark_MSST_2011.pdf

 - identify hot data in an SSD
 - bloom filters because DRAM is precious (and mostly needed for FTL)
 - round-robin set of bloom filters
  - estimate both frequency (how many bf's does it appear in) and recency 
    (oldest/newest access)

Thoughts:
 - Any DRAM not spent on hot/cold tracking is spent on caching, which 
   improves performance.
 - We could use counting bloom filters.  Although that may not be that 
   useful if we have multiple bins and can count how many bins accesses
   appear in.


