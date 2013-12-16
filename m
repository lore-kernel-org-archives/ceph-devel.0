From: Sage Weil <sage@inktank.com>
Subject: New Defects reported by Coverity Scan for ceph (fwd)
Date: Mon, 16 Dec 2013 08:07:48 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1312160807450.4454@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-355039154-1387210068=:4454"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:34112 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754445Ab3LPQHt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 16 Dec 2013 11:07:49 -0500
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 1AE9B80446
	for <ceph-devel@vger.kernel.org>; Mon, 16 Dec 2013 08:07:49 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id E435780446
	for <ceph-devel@vger.kernel.org>; Mon, 16 Dec 2013 08:07:48 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-355039154-1387210068=:4454
Content-Type: TEXT/PLAIN; charset=US-ASCII


--557981400-355039154-1387210068=:4454
Content-Type: MESSAGE/RFC822; CHARSET=US-ASCII
Content-ID: <alpine.DEB.2.00.1312160807451.4454@cobra.newdream.net>
Content-Description: Forwarded Message
Content-Disposition: inline

Return-Path: <scan-admin@coverity.com>
X-Original-To: sage@cobra.newdream.net
Delivered-To: sage@cobra.newdream.net
Received: from destro.newdream.net (destro.newdream.net [66.33.216.68])
	by cobra.newdream.net (Postfix) with ESMTP id CBE9F8044C
	for <sage@cobra.newdream.net>; Mon, 16 Dec 2013 00:57:58 -0800 (PST)
Received: by destro.newdream.net (Postfix)
	id C9B30120962; Mon, 16 Dec 2013 00:57:58 -0800 (PST)
Delivered-To: sage@destro.newdream.net
Received: from alc-junkmail-backend3.dreamhost.com (caiajhbdcahe.dreamhost.com
	[208.97.132.74])
	by destro.newdream.net (Postfix) with ESMTP id C746C12093B
	for <sage@newdream.net>; Mon, 16 Dec 2013 00:57:58 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by alc-junkmail-backend3.dreamhost.com (Postfix) with ESMTP id
	C425C16160C0
	for <sage@newdream.net>; Mon, 16 Dec 2013 00:57:58 -0800 (PST)
X-DH-Virus-Scanned: Debian amavisd-new at alc-junkmail-backend3.dreamhost.com
X-Spam-Flag: NO
X-Spam-Score: 0
X-Spam-Level: 
X-Spam-Status: No, score=x tagged_above=-999 required=999 WHITELISTED tests=[]
Received: from connor.dreamhost.com ([208.97.132.205])
	by localhost (alc-junkmail-backend3.dreamhost.com [208.97.132.104])
	(amavisd-new, port 10024)
	with ESMTP id 4zWZyEIcar6L for <sage@newdream.net>;
	Mon, 16 Dec 2013 00:57:58 -0800 (PST)
Received: from scanrelay.coverity.com (scanrelay.coverity.com [209.249.196.67])
	by connor.dreamhost.com (Postfix) with ESMTP id 8BBCB2CA801D
	for <sage@newdream.net>; Mon, 16 Dec 2013 00:57:58 -0800 (PST)
Received: from localhost.localdomain ([208.69.177.215]) by
	scanrelay.coverity.com with Microsoft SMTPSVC(7.5.7601.17514);
	Mon, 16 Dec 2013 00:57:56 -0800
Date: Mon, 16 Dec 2013 00:57:57 -0800
From: scan-admin@coverity.com
Message-ID: <52aec095b64cb_36d4115dff04827c@209.249.196.67.mail>
Subject: New Defects reported by Coverity Scan for ceph
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Dec 2013 08:57:56.0310 (UTC)
	FILETIME=[E984CF60:01CEFA3C]
To: undisclosed-recipients:;
X-Spambayes-Classification: ham; 0.00



Hi,


Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

Defect(s) Reported-by: Coverity Scan
Showing 4 of 4 defect(s)


** CID 1138366:  Resource leak  (RESOURCE_LEAK)
/test/librados/tier.cc: 96 in LibRadosMisc_HitSetNone_Test::TestBody()()
/test/librados/tier.cc: 98 in LibRadosMisc_HitSetNone_Test::TestBody()()
/test/librados/tier.cc: 99 in LibRadosMisc_HitSetNone_Test::TestBody()()

** CID 1138367:  Time of check time of use  (TOCTOU)
/rbd.cc: 2024 in do_kernel_rm(const char *)()

** CID 1138368:  Time of check time of use  (TOCTOU)
/rbd.cc: 1735 in do_kernel_add(const char *, const char *, const char *)()

** CID 1138369:  Uncaught exception  (UNCAUGHT_EXCEPT)
/test/librados/tier.cc: 369 in main()
/test/librados/tier.cc: 369 in main()




________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, http://scan.coverity.com

To unsubscribe from the email notification for new defects, http://scan5.coverity.com/cgi-bin/unsubscribe.py




--557981400-355039154-1387210068=:4454--
