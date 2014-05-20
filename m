From: Sage Weil <sage@inktank.com>
Subject: New Defects reported by Coverity Scan for ceph (fwd)
Date: Tue, 20 May 2014 09:16:09 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1405200916060.31897@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1279670624-1400602570=:31897"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:60213 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753825AbaETQQK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 20 May 2014 12:16:10 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 337F9803BC
	for <ceph-devel@vger.kernel.org>; Tue, 20 May 2014 09:16:10 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 03752803BC
	for <ceph-devel@vger.kernel.org>; Tue, 20 May 2014 09:16:10 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1279670624-1400602570=:31897
Content-Type: TEXT/PLAIN; charset=US-ASCII


--557981400-1279670624-1400602570=:31897
Content-Type: MESSAGE/RFC822; CHARSET=US-ASCII
Content-ID: <alpine.DEB.2.00.1405200916061.31897@cobra.newdream.net>
Content-Description: Forwarded Message
Content-Disposition: inline

Return-Path: <scan-admin@coverity.com>
X-Original-To: sage@cobra.newdream.net
Delivered-To: sage@cobra.newdream.net
Received: from destro.newdream.net (destro.newdream.net [66.33.216.68])
	by cobra.newdream.net (Postfix) with ESMTP id F2822803BC
	for <sage@cobra.newdream.net>; Tue, 20 May 2014 06:18:54 -0700 (PDT)
Received: by destro.newdream.net (Postfix)
	id EE2E51209A4; Tue, 20 May 2014 06:18:54 -0700 (PDT)
Delivered-To: sage@destro.newdream.net
Received: from diehard.dreamhost.com (caiajhbdcbfh.dreamhost.com
	[208.97.132.157])
	by destro.newdream.net (Postfix) with ESMTP id E8D511209A0
	for <sage@newdream.net>; Tue, 20 May 2014 06:18:54 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by diehard.dreamhost.com (Postfix) with ESMTP id E45353C421C
	for <sage@newdream.net>; Tue, 20 May 2014 06:18:54 -0700 (PDT)
X-DH-Virus-Scanned: Debian amavisd-new at diehard.dreamhost.com
X-Spam-Flag: NO
X-Spam-Score: 0
X-Spam-Level: 
X-Spam-Status: No, score=x tagged_above=-999 required=999 WHITELISTED tests=[]
	autolearn=unavailable
Received: from connor.dreamhost.com ([208.97.132.17])
	by localhost (diehard.dreamhost.com [208.97.132.157]) (amavisd-new,
	port 10024) with ESMTP id g6sVAR2lPwsI for <sage@newdream.net>;
	Tue, 20 May 2014 06:18:54 -0700 (PDT)
Received: from scanrelay.coverity.com (scanrelay.coverity.com [209.249.196.67])
	by connor.dreamhost.com (Postfix) with ESMTP id 8E86E2CA830F
	for <sage@newdream.net>; Tue, 20 May 2014 06:17:45 -0700 (PDT)
Received: from localhost.localdomain ([208.69.177.215]) by
	scanrelay.coverity.com with Microsoft SMTPSVC(7.5.7601.17514);
	Tue, 20 May 2014 06:19:14 -0700
Date: Tue, 20 May 2014 06:17:44 -0700
From: scan-admin@coverity.com
Message-ID: <537b55f82226c_1e8939b31849687@209.249.196.67.mail>
Subject: New Defects reported by Coverity Scan for ceph
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 May 2014 13:19:14.0803 (UTC)
	FILETIME=[18A83C30:01CF742E]
To: undisclosed-recipients:;
X-Spambayes-Classification: ham; 0.00



Hi,


Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

Defect(s) Reported-by: Coverity Scan
Showing 1 of 1 defect(s)


** CID 1214678:  Unchecked return value  (CHECKED_RETURN)
/osd/OSD.cc: 318 in OSDService::_maybe_split_pgid(std::tr1::shared_ptr<const OSDMap>, std::tr1::shared_ptr<const OSDMap>, spg_t)()


________________________________________________________________________________________________________
*** CID 1214678:  Unchecked return value  (CHECKED_RETURN)
/osd/OSD.cc: 318 in OSDService::_maybe_split_pgid(std::tr1::shared_ptr<const OSDMap>, std::tr1::shared_ptr<const OSDMap>, spg_t)()
312     				  OSDMapRef new_map,
313     				  spg_t pgid)
314     {
315       assert(old_map->have_pg_pool(pgid.pool()));
316       if (pgid.ps() < static_cast<unsigned>(old_map->get_pg_num(pgid.pool()))) {
317         set<spg_t> children;
>>>     CID 1214678:  Unchecked return value  (CHECKED_RETURN)
>>>     No check of the return value of "pgid.is_split(old_map->get_pg_num(pgid.pool()), new_map->get_pg_num(pgid.pool()), &children)".
318         pgid.is_split(old_map->get_pg_num(pgid.pool()),
319     		  new_map->get_pg_num(pgid.pool()), &children);
320         _start_split(pgid, children);
321       } else {
322         assert(pgid.ps() < static_cast<unsigned>(new_map->get_pg_num(pgid.pool())));
323       }


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, http://scan.coverity.com/projects/25?tab=overview

To unsubscribe from the email notification for new defects, http://scan5.coverity.com/cgi-bin/unsubscribe.py




--557981400-1279670624-1400602570=:31897--
