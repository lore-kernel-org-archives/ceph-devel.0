From: Sage Weil <sweil@redhat.com>
Subject: New Defects reported by Coverity Scan for ceph (fwd)
Date: Thu, 25 Sep 2014 08:02:09 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1409250801580.14861@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-825215298-1411657329=:14861"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:39202 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752130AbaIYPCK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Sep 2014 11:02:10 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, john.spray@redhat.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-825215298-1411657329=:14861
Content-Type: TEXT/PLAIN; charset=US-ASCII


--557981400-825215298-1411657329=:14861
Content-Type: MESSAGE/RFC822; CHARSET=US-ASCII
Content-ID: <alpine.DEB.2.00.1409250801581.14861@cobra.newdream.net>
Content-Description: Forwarded Message
Content-Disposition: inline

Return-Path: <scan-admin@coverity.com>
X-Original-To: sage@cobra.newdream.net
Delivered-To: sage@cobra.newdream.net
Received: from destro.newdream.net (destro.newdream.net [66.33.216.68])
	by cobra.newdream.net (Postfix) with ESMTP id 6C7BC80079
	for <sage@cobra.newdream.net>; Thu, 25 Sep 2014 06:19:45 -0700 (PDT)
Received: by destro.newdream.net (Postfix)
	id 6A3431211D6; Thu, 25 Sep 2014 06:19:45 -0700 (PDT)
Delivered-To: sage@destro.newdream.net
Received: from madmax.dreamhost.com (caiajhbdcbdj.dreamhost.com
	[208.97.132.139])
	by destro.newdream.net (Postfix) with ESMTP id 693401211BB
	for <sage@newdream.net>; Thu, 25 Sep 2014 06:19:45 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by madmax.dreamhost.com (Postfix) with ESMTP id 65D69FD800D
	for <sage@newdream.net>; Thu, 25 Sep 2014 06:19:45 -0700 (PDT)
X-DH-Virus-Scanned: Debian amavisd-new at madmax.dreamhost.com
X-Spam-Flag: NO
X-Spam-Score: 0
X-Spam-Level: 
X-Spam-Status: No, score=x tagged_above=-999 required=999 WHITELISTED tests=[]
	autolearn=unavailable
Received: from terminator.dreamhost.com ([208.97.132.17])
	by localhost (madmax.dreamhost.com [208.97.132.139]) (amavisd-new,
	port 10024) with ESMTP id 3XOxBMJfG5Cv for <sage@newdream.net>;
	Thu, 25 Sep 2014 06:19:45 -0700 (PDT)
Received: from scanrelay.coverity.com (scanrelay.coverity.com [209.249.196.67])
	by terminator.dreamhost.com (Postfix) with ESMTP id 4509C288406E
	for <sage@newdream.net>; Thu, 25 Sep 2014 06:19:45 -0700 (PDT)
Received: from localhost.localdomain ([208.69.177.215]) by
	scanrelay.coverity.com with Microsoft SMTPSVC(7.5.7601.17514);
	Thu, 25 Sep 2014 06:18:54 -0700
Date: Thu, 25 Sep 2014 06:18:46 -0700
From: scan-admin@coverity.com
Message-ID: <5424163634449_26ad92732c8958d@scan.coverity.com.mail>
Subject: New Defects reported by Coverity Scan for ceph
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Sep 2014 13:18:54.0594 (UTC)
	FILETIME=[417C9620:01CFD8C3]
To: undisclosed-recipients:;
X-Spambayes-Classification: ham; 0.00



Hi,


Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

Defect(s) Reported-by: Coverity Scan
Showing 1 of 1 defect(s)


** CID 1241497:  Thread deadlock  (ORDER_REVERSAL)



________________________________________________________________________________________________________
*** CID 1241497:  Thread deadlock  (ORDER_REVERSAL)
/osdc/Filer.cc: 314 in Filer::_do_purge_range(PurgeRange *, int)()
308         return;
309       }
310     
311       int max = 10 - pr->uncommitted;
312       while (pr->num > 0 && max > 0) {
313         object_t oid = file_object_t(pr->ino, pr->first);
>>>     CID 1241497:  Thread deadlock  (ORDER_REVERSAL)
>>>     Calling "get_osdmap_read" acquires lock "RWLock.L" while holding lock "Mutex._m" (count: 15 / 30).
314         const OSDMap *osdmap = objecter->get_osdmap_read();
315         object_locator_t oloc = osdmap->file_to_object_locator(pr->layout);
316         objecter->put_osdmap_read();
317         objecter->remove(oid, oloc, pr->snapc, pr->mtime, pr->flags,
318     		     NULL, new C_PurgeRange(this, pr));
319         pr->uncommitted++;


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, http://scan.coverity.com/projects/25?tab=overview

To unsubscribe from the email notification for new defects, http://scan5.coverity.com/cgi-bin/unsubscribe.py




--557981400-825215298-1411657329=:14861--
