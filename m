From: Sage Weil <sage@inktank.com>
Subject: New Defects reported by Coverity Scan for ceph (fwd)
Date: Fri, 6 Jun 2014 08:54:47 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1406060854430.31587@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1588950225-1402070087=:31587"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:43823 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751276AbaFFPys (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Jun 2014 11:54:48 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id EB90380446
	for <ceph-devel@vger.kernel.org>; Fri,  6 Jun 2014 08:54:47 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id C09AF80446
	for <ceph-devel@vger.kernel.org>; Fri,  6 Jun 2014 08:54:47 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1588950225-1402070087=:31587
Content-Type: TEXT/PLAIN; charset=US-ASCII


--557981400-1588950225-1402070087=:31587
Content-Type: MESSAGE/RFC822; CHARSET=US-ASCII
Content-ID: <alpine.DEB.2.00.1406060854440.31587@cobra.newdream.net>
Content-Description: Forwarded Message
Content-Disposition: inline

Return-Path: <scan-admin@coverity.com>
X-Original-To: sage@cobra.newdream.net
Delivered-To: sage@cobra.newdream.net
Received: from destro.newdream.net (destro.newdream.net [66.33.216.68])
	by cobra.newdream.net (Postfix) with ESMTP id E677780060
	for <sage@cobra.newdream.net>; Fri,  6 Jun 2014 06:23:27 -0700 (PDT)
Received: by destro.newdream.net (Postfix)
	id E534712094E; Fri,  6 Jun 2014 06:23:27 -0700 (PDT)
Delivered-To: sage@destro.newdream.net
Received: from madmax.dreamhost.com (caiajhbdcbdj.dreamhost.com
	[208.97.132.139])
	by destro.newdream.net (Postfix) with ESMTP id DA2491209E3
	for <sage@newdream.net>; Fri,  6 Jun 2014 06:23:27 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by madmax.dreamhost.com (Postfix) with ESMTP id D70B4FD77AB
	for <sage@newdream.net>; Fri,  6 Jun 2014 06:23:27 -0700 (PDT)
X-DH-Virus-Scanned: Debian amavisd-new at madmax.dreamhost.com
X-Spam-Flag: NO
X-Spam-Score: 0
X-Spam-Level: 
X-Spam-Status: No, score=x tagged_above=-999 required=999 WHITELISTED tests=[]
	autolearn=unavailable
Received: from terminator.dreamhost.com ([208.97.132.17])
	by localhost (madmax.dreamhost.com [208.97.132.139]) (amavisd-new,
	port 10024) with ESMTP id tKRhdcNBhlju for <sage@newdream.net>;
	Fri,  6 Jun 2014 06:23:27 -0700 (PDT)
Received: from scanrelay.coverity.com (scanrelay.coverity.com [209.249.196.67])
	by terminator.dreamhost.com (Postfix) with ESMTP id B5610288406D
	for <sage@newdream.net>; Fri,  6 Jun 2014 06:23:27 -0700 (PDT)
Received: from localhost.localdomain ([208.69.177.215]) by
	scanrelay.coverity.com with Microsoft SMTPSVC(7.5.7601.17514);
	Fri, 6 Jun 2014 06:23:27 -0700
Date: Fri, 06 Jun 2014 06:23:27 -0700
From: scan-admin@coverity.com
Message-ID: <5391c0cf3a857_59a5b533307584f@209.249.196.67.mail>
Subject: New Defects reported by Coverity Scan for ceph
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Jun 2014 13:23:27.0455 (UTC)
	FILETIME=[80459EF0:01CF818A]
To: undisclosed-recipients:;
X-Spambayes-Classification: ham; 0.00



Hi,


Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

Defect(s) Reported-by: Coverity Scan
Showing 1 of 1 defect(s)


** CID 1220854:  Invalid iterator comparison  (MISMATCHED_ITERATOR)
/osd/PG.cc: 981 in PG::calc_ec_acting(std::_Rb_tree_const_iterator<std::pair<const pg_shard_t, pg_info_t>>, unsigned int, const std::vector<int, std::allocator<int>> &, pg_shard_t, const std::vector<int, std::allocator<int>> &, pg_shard_t, const std::map<pg_shard_t, pg_info_t, std::less<pg_shard_t>, std::allocator<std::pair<const pg_shard_t, pg_info_t>>> &, bool, std::vector<int, std::allocator<int>> *, std::set<pg_shard_t, std::less<pg_shard_t>, std::allocator<pg_shard_t>> *, std::set<pg_shard_t, std::less<pg_shard_t>, std::allocator<pg_shard_t>> *, pg_shard_t *, std::basic_ostream<char, std::char_traits<char>>&)()


________________________________________________________________________________________________________
*** CID 1220854:  Invalid iterator comparison  (MISMATCHED_ITERATOR)
/osd/PG.cc: 981 in PG::calc_ec_acting(std::_Rb_tree_const_iterator<std::pair<const pg_shard_t, pg_info_t>>, unsigned int, const std::vector<int, std::allocator<int>> &, pg_shard_t, const std::vector<int, std::allocator<int>> &, pg_shard_t, const std::map<pg_shard_t, pg_info_t, std::less<pg_shard_t>, std::allocator<std::pair<const pg_shard_t, pg_info_t>>> &, bool, std::vector<int, std::allocator<int>> *, std::set<pg_shard_t, std::less<pg_shard_t>, std::allocator<pg_shard_t>> *, std::set<pg_shard_t, std::less<pg_shard_t>, std::allocator<pg_shard_t>> *, pg_shard_t *, std::basic_ostream<char, std::char_traits<char>>&)()
975     	all_info.find(pg_shard_t(acting[i], shard_id_t(i)))->second.last_update >=
976     	auth_log_shard->second.log_tail) {
977           ss << " selecting acting[i]: " << pg_shard_t(acting[i], shard_id_t(i)) << std::endl;
978           want[i] = acting[i];
979           ++usable;
980         } else {
>>>     CID 1220854:  Invalid iterator comparison  (MISMATCHED_ITERATOR)
>>>     Comparing "j" from "all_info_by_shard[shard_id_t(i)]" to "all_info_by_shard[shard_id_t(i)]->end()" from "all_info_by_shard[shard_id_t(i)]".
981           for (set<pg_shard_t>::iterator j = all_info_by_shard[shard_id_t(i)].begin();
982     	   j != all_info_by_shard[shard_id_t(i)].end();
983     	   ++j) {
984     	assert(j->shard == i);
985     	if (!all_info.find(*j)->second.is_incomplete() &&
986     	    all_info.find(*j)->second.last_update >=


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, http://scan.coverity.com/projects/25?tab=overview

To unsubscribe from the email notification for new defects, http://scan5.coverity.com/cgi-bin/unsubscribe.py




--557981400-1588950225-1402070087=:31587--
