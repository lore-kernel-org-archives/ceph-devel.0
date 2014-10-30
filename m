From: scan-admin@coverity.com
Subject: New Defects reported by Coverity Scan for ceph
Date: Thu, 30 Oct 2014 06:19:45 -0700
Message-ID: <54523af1eb459_316c130b32050623@scan.coverity.com.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from scanrelay.coverity.com ([209.249.196.67]:59882 "EHLO
	scanrelay.coverity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759278AbaJ3NTq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Oct 2014 09:19:46 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi,

Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

1 new defect(s) introduced to ceph found with Coverity Scan.
25 defect(s), reported by Coverity Scan earlier, were marked fixed in the recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 1 of 1 defect(s)


** CID 1250262:  Dereference after null check  (FORWARD_NULL)
/osdc/Objecter.cc: 2062 in Objecter::_calc_target(Objecter::op_target_t *, bool)()


________________________________________________________________________________________________________
*** CID 1250262:  Dereference after null check  (FORWARD_NULL)
/osdc/Objecter.cc: 2062 in Objecter::_calc_target(Objecter::op_target_t *, bool)()
2056         if (ret == -ENOENT) {
2057           t->osd = -1;
2058           return RECALC_OP_TARGET_POOL_DNE;
2059         }
2060       }
2061     
>>>     CID 1250262:  Dereference after null check  (FORWARD_NULL)
>>>     Dereferencing null pointer "pi".
2062       int min_size = pi->min_size;
2063       unsigned pg_num = pi->get_pg_num();
2064       int up_primary, acting_primary;
2065       vector<int> up, acting;
2066       osdmap->pg_to_up_acting_osds(pgid, &up, &up_primary,
2067     			       &acting, &acting_primary);


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, http://scan.coverity.com/projects/25?tab=overview

To unsubscribe from the email notification for new defects, http://scan5.coverity.com/cgi-bin/unsubscribe.py



