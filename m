From: Sage Weil <sage@newdream.net>
Subject: Re: New Defects reported by Coverity Scan for ceph
Date: Thu, 30 Oct 2014 09:08:04 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1410300906580.13322@cobra.newdream.net>
References: <54523af1eb459_316c130b32050623@scan.coverity.com.mail>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45863 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758415AbaJ3QIF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Oct 2014 12:08:05 -0400
In-Reply-To: <54523af1eb459_316c130b32050623@scan.coverity.com.mail>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: scan-admin@coverity.com
Cc: ceph-devel@vger.kernel.org

On Thu, 30 Oct 2014, scan-admin@coverity.com wrote:
> 
> Hi,
> 
> Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.
> 
> 1 new defect(s) introduced to ceph found with Coverity Scan.
> 25 defect(s), reported by Coverity Scan earlier, were marked fixed in the recent build analyzed by Coverity Scan.
> 
> New defect(s) Reported-by: Coverity Scan
> Showing 1 of 1 defect(s)
> 
> 
> ** CID 1250262:  Dereference after null check  (FORWARD_NULL)
> /osdc/Objecter.cc: 2062 in Objecter::_calc_target(Objecter::op_target_t *, bool)()
> 
> 
> ________________________________________________________________________________________________________
> *** CID 1250262:  Dereference after null check  (FORWARD_NULL)
> /osdc/Objecter.cc: 2062 in Objecter::_calc_target(Objecter::op_target_t *, bool)()
> 2056         if (ret == -ENOENT) {
> 2057           t->osd = -1;
> 2058           return RECALC_OP_TARGET_POOL_DNE;
> 2059         }
> 2060       }
> 2061     
> >>>     CID 1250262:  Dereference after null check  (FORWARD_NULL)
> >>>     Dereferencing null pointer "pi".
> 2062       int min_size = pi->min_size;
> 2063       unsigned pg_num = pi->get_pg_num();
> 2064       int up_primary, acting_primary;
> 2065       vector<int> up, acting;
> 2066       osdmap->pg_to_up_acting_osds(pgid, &up, &up_primary,
> 2067     			       &acting, &acting_primary);

opened #9944

