From: Sage Weil <sage@inktank.com>
Subject: New Defects reported by Coverity Scan for ceph (fwd)
Date: Tue, 22 Apr 2014 08:26:09 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1404220825570.10034@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1788417767-1398180369=:10034"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:41421 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932638AbaDVP0K (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Apr 2014 11:26:10 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 116AA80069
	for <ceph-devel@vger.kernel.org>; Tue, 22 Apr 2014 08:26:10 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id D9A7C80069
	for <ceph-devel@vger.kernel.org>; Tue, 22 Apr 2014 08:26:09 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1788417767-1398180369=:10034
Content-Type: TEXT/PLAIN; charset=US-ASCII


--557981400-1788417767-1398180369=:10034
Content-Type: MESSAGE/RFC822; CHARSET=US-ASCII
Content-ID: <alpine.DEB.2.00.1404220825580.10034@cobra.newdream.net>
Content-Description: Forwarded Message
Content-Disposition: inline

Return-Path: <scan-admin@coverity.com>
X-Original-To: sage@cobra.newdream.net
Delivered-To: sage@cobra.newdream.net
Received: from destro.newdream.net (destro.newdream.net [66.33.216.68])
	by cobra.newdream.net (Postfix) with ESMTP id D7AC080466
	for <sage@cobra.newdream.net>; Tue, 22 Apr 2014 07:13:09 -0700 (PDT)
Received: by destro.newdream.net (Postfix)
	id D5135120996; Tue, 22 Apr 2014 07:13:09 -0700 (PDT)
Delivered-To: sage@destro.newdream.net
Received: from madmax.dreamhost.com (caiajhbdcbdj.dreamhost.com
	[208.97.132.139])
	by destro.newdream.net (Postfix) with ESMTP id D2101120992
	for <sage@newdream.net>; Tue, 22 Apr 2014 07:13:09 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by madmax.dreamhost.com (Postfix) with ESMTP id B812AFD6CE9
	for <sage@newdream.net>; Tue, 22 Apr 2014 07:13:09 -0700 (PDT)
X-DH-Virus-Scanned: Debian amavisd-new at madmax.dreamhost.com
X-Spam-Flag: NO
X-Spam-Score: 0
X-Spam-Level: 
X-Spam-Status: No, score=x tagged_above=-999 required=999 WHITELISTED tests=[]
	autolearn=unavailable
Received: from terminator.dreamhost.com ([208.97.132.17])
	by localhost (madmax.dreamhost.com [208.97.132.139]) (amavisd-new,
	port 10024) with ESMTP id tSS6+oFcfbEm for <sage@newdream.net>;
	Tue, 22 Apr 2014 07:13:09 -0700 (PDT)
Received: from scanrelay.coverity.com (scanrelay.coverity.com [209.249.196.67])
	by terminator.dreamhost.com (Postfix) with ESMTP id 1BF112884064
	for <sage@newdream.net>; Tue, 22 Apr 2014 07:13:07 -0700 (PDT)
Received: from localhost.localdomain ([208.69.177.215]) by
	scanrelay.coverity.com with Microsoft SMTPSVC(7.5.7601.17514);
	Tue, 22 Apr 2014 07:14:05 -0700
Date: Tue, 22 Apr 2014 07:13:05 -0700
From: scan-admin@coverity.com
Message-ID: <535678f165c82_2069a3406c928f3@209.249.196.67.mail>
Subject: New Defects reported by Coverity Scan for ceph
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Apr 2014 14:14:05.0749 (UTC)
	FILETIME=[1EA5BE50:01CF5E35]
To: undisclosed-recipients:;
X-Spambayes-Classification: ham; 0.00



Hi,


Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

Defect(s) Reported-by: Coverity Scan
Showing 4 of 4 defect(s)


** CID 1204293:  Buffer not null terminated  (BUFFER_SIZE_WARNING)
/mds/MDS.cc: 1714 in MDS::respawn()()

** CID 1204294:  Resource leak  (RESOURCE_LEAK)
/osd/ReplicatedPG.cc: 980 in ReplicatedPG::do_pg_op(std::tr1::shared_ptr<OpRequest>)()

** CID 1204295:  Uninitialized scalar field  (UNINIT_CTOR)
/osd/osd_types.h: 2716 in ObjectContext::RWState::RWState()()

** CID 1204296:  Uninitialized scalar field  (UNINIT_CTOR)
/osdc/Objecter.h: 1165 in Objecter::Op::Op(const object_t &, const object_locator_t &, std::vector<OSDOp, std::allocator<OSDOp>> &, int, Context *, Context *, unsigned long *)()
/osdc/Objecter.h: 1165 in Objecter::Op::Op(const object_t &, const object_locator_t &, std::vector<OSDOp, std::allocator<OSDOp>> &, int, Context *, Context *, unsigned long *)()


________________________________________________________________________________________________________
*** CID 1204293:  Buffer not null terminated  (BUFFER_SIZE_WARNING)
/mds/MDS.cc: 1714 in MDS::respawn()()
1708         char buf[PATH_MAX];
1709         char *cwd = getcwd(buf, sizeof(buf));
1710         assert(cwd);
1711         dout(1) << " cwd " << cwd << dendl;
1712     
1713         /* Fall back to a best-effort: just running in our CWD */
>>>     CID 1204293:  Buffer not null terminated  (BUFFER_SIZE_WARNING)
>>>     Calling strncpy with a maximum size argument of 4096 bytes on destination array "exe_path" of size 4096 bytes might leave the destination string unterminated.
1714         strncpy(exe_path, orig_argv[0], sizeof(exe_path));
1715       }
1716     
1717       dout(1) << " exe_path " << exe_path << dendl;
1718     
1719       unblock_all_signals(NULL);

________________________________________________________________________________________________________
*** CID 1204294:  Resource leak  (RESOURCE_LEAK)
/osd/ReplicatedPG.cc: 980 in ReplicatedPG::do_pg_op(std::tr1::shared_ptr<OpRequest>)()
974     	    // FIXME: EC not supported yet
975     	    result = -EOPNOTSUPP;
976     	    break;
977     	  }
978     	  if (is_unreadable_object(oid)) {
979     	    wait_for_unreadable_object(oid, op);
>>>     CID 1204294:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "filter" going out of scope leaks the storage it points to.
980     	    return;
981     	  }
982     	  result = osd->store->read(coll, oid, 0, 0, osd_op.outdata);
983     	}
984           }
985           break;

________________________________________________________________________________________________________
*** CID 1204295:  Uninitialized scalar field  (UNINIT_CTOR)
/osd/osd_types.h: 2716 in ObjectContext::RWState::RWState()()
2710         /// if set, restart backfill when we can get a read lock
2711         bool backfill_read_marker;
2712     
2713         /// if set, requeue snaptrim on lock release
2714         bool snaptrimmer_write_marker;
2715     
>>>     CID 1204295:  Uninitialized scalar field  (UNINIT_CTOR)
>>>     Non-static class member "snaptrimmer_write_marker" is not initialized in this constructor nor in any functions that it calls.
2716         RWState() : state(RWNONE), count(0), backfill_read_marker(false) {}
2717         bool get_read(OpRequestRef op) {
2718           if (get_read_lock()) {
2719     	return true;
2720           } // else
2721           waiters.push_back(op);

________________________________________________________________________________________________________
*** CID 1204296:  Uninitialized scalar field  (UNINIT_CTOR)
/osdc/Objecter.h: 1165 in Objecter::Op::Op(const object_t &, const object_locator_t &, std::vector<OSDOp, std::allocator<OSDOp>> &, int, Context *, Context *, unsigned long *)()
1159     	out_handler[i] = NULL;
1160     	out_rval[i] = NULL;
1161           }
1162     
1163           if (target.base_oloc.key == o)
1164     	target.base_oloc.key.clear();
>>>     CID 1204296:  Uninitialized scalar field  (UNINIT_CTOR)
>>>     Non-static class member "used_replica" is not initialized in this constructor nor in any functions that it calls.
1165         }
1166         ~Op() {
1167           while (!out_handler.empty()) {
1168     	delete out_handler.back();
1169     	out_handler.pop_back();
1170           }
/osdc/Objecter.h: 1165 in Objecter::Op::Op(const object_t &, const object_locator_t &, std::vector<OSDOp, std::allocator<OSDOp>> &, int, Context *, Context *, unsigned long *)()
1159     	out_handler[i] = NULL;
1160     	out_rval[i] = NULL;
1161           }
1162     
1163           if (target.base_oloc.key == o)
1164     	target.base_oloc.key.clear();
>>>     CID 1204296:  Uninitialized scalar field  (UNINIT_CTOR)
>>>     Non-static class member "used_replica" is not initialized in this constructor nor in any functions that it calls.
1165         }
1166         ~Op() {
1167           while (!out_handler.empty()) {
1168     	delete out_handler.back();
1169     	out_handler.pop_back();
1170           }


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, http://scan.coverity.com/projects/25?tab=Overview

To unsubscribe from the email notification for new defects, http://scan5.coverity.com/cgi-bin/unsubscribe.py




--557981400-1788417767-1398180369=:10034--
