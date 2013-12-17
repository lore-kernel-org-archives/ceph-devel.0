From: Sage Weil <sage@inktank.com>
Subject: New Defects reported by Coverity Scan for ceph (fwd)
Date: Tue, 17 Dec 2013 09:10:20 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1312170910010.10503@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-410371245-1387300220=:10503"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47389 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754592Ab3LQRKV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 17 Dec 2013 12:10:21 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: zheng.z.yan@intel.com, ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-410371245-1387300220=:10503
Content-Type: TEXT/PLAIN; charset=US-ASCII


--557981400-410371245-1387300220=:10503
Content-Type: MESSAGE/RFC822; CHARSET=US-ASCII
Content-ID: <alpine.DEB.2.00.1312170910011.10503@cobra.newdream.net>
Content-Description: Forwarded Message
Content-Disposition: inline

Return-Path: <scan-admin@coverity.com>
X-Original-To: sage@cobra.newdream.net
Delivered-To: sage@cobra.newdream.net
Received: from destro.newdream.net (destro.newdream.net [66.33.216.68])
	by cobra.newdream.net (Postfix) with ESMTP id 7448F80446
	for <sage@cobra.newdream.net>; Tue, 17 Dec 2013 05:58:52 -0800 (PST)
Received: by destro.newdream.net (Postfix)
	id 714D21209E9; Tue, 17 Dec 2013 05:58:52 -0800 (PST)
Delivered-To: sage@destro.newdream.net
Received: from alc-junkmail-backend3.dreamhost.com (caiajhbdcahe.dreamhost.com
	[208.97.132.74])
	by destro.newdream.net (Postfix) with ESMTP id 702881209D9
	for <sage@newdream.net>; Tue, 17 Dec 2013 05:58:52 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by alc-junkmail-backend3.dreamhost.com (Postfix) with ESMTP id
	6AD501616066
	for <sage@newdream.net>; Tue, 17 Dec 2013 05:58:52 -0800 (PST)
X-DH-Virus-Scanned: Debian amavisd-new at alc-junkmail-backend3.dreamhost.com
X-Spam-Flag: NO
X-Spam-Score: 0
X-Spam-Level: 
X-Spam-Status: No, score=x tagged_above=-999 required=999 WHITELISTED tests=[]
Received: from connor.dreamhost.com ([208.97.132.205])
	by localhost (alc-junkmail-backend3.dreamhost.com [208.97.132.104])
	(amavisd-new, port 10024)
	with ESMTP id NpDl4L5xmpsE for <sage@newdream.net>;
	Tue, 17 Dec 2013 05:58:52 -0800 (PST)
Received: from scanrelay.coverity.com (scanrelay.coverity.com [209.249.196.67])
	by connor.dreamhost.com (Postfix) with ESMTP id 0F5052CA802B
	for <sage@newdream.net>; Tue, 17 Dec 2013 05:58:52 -0800 (PST)
Received: from localhost.localdomain ([208.69.177.215]) by
	scanrelay.coverity.com with Microsoft SMTPSVC(7.5.7601.17514);
	Tue, 17 Dec 2013 05:58:49 -0800
Date: Tue, 17 Dec 2013 05:58:50 -0800
From: scan-admin@coverity.com
Message-ID: <52b0589a75e56_19c8115dff048236@209.249.196.67.mail>
Subject: New Defects reported by Coverity Scan for ceph
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Dec 2013 13:58:49.0185 (UTC)
	FILETIME=[1C48AD10:01CEFB30]
To: undisclosed-recipients:;
X-Spambayes-Classification: ham; 0.00



Hi,


Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

Defect(s) Reported-by: Coverity Scan
Showing 7 of 13 defect(s)


** CID 1138583:  Dereference null return value  (NULL_RETURNS)
/mds/MDCache.cc: 5074 in MDCache::process_imported_caps()()

** CID 1138584:  Dereference null return value  (NULL_RETURNS)
/mds/Migrator.cc: 2480 in Migrator::import_finish(CDir *, bool, bool)()

** CID 1138585:  Dereference null return value  (NULL_RETURNS)
/mds/Migrator.cc: 2289 in Migrator::import_reverse(CDir *)()

** CID 1138586:  Dereference null return value  (NULL_RETURNS)
/mds/Migrator.cc: 2297 in Migrator::import_reverse(CDir *)()

** CID 1138587:  Out-of-bounds access  (OVERRUN)
/messages/MClientCaps.h: 170 in MClientCaps::decode_payload()()
/messages/MClientCaps.h: 170 in MClientCaps::decode_payload()()
/messages/MClientCaps.h: 170 in MClientCaps::decode_payload()()

** CID 1138588:  Out-of-bounds access  (OVERRUN)
/messages/MClientCaps.h: 179 in MClientCaps::encode_payload(unsigned long)()
/messages/MClientCaps.h: 179 in MClientCaps::encode_payload(unsigned long)()
/messages/MClientCaps.h: 179 in MClientCaps::encode_payload(unsigned long)()

** CID 739602:  Dereference null return value  (NULL_RETURNS)
/mds/Server.cc: 707 in Server::reconnect_tick()()




________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, http://scan.coverity.com

To unsubscribe from the email notification for new defects, http://scan5.coverity.com/cgi-bin/unsubscribe.py




--557981400-410371245-1387300220=:10503--
