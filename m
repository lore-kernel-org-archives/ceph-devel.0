From: scan-admin@coverity.com
Subject: New Defects reported by Coverity Scan for ceph
Date: Thu, 25 Sep 2014 06:18:46 -0700
Message-ID: <5424163634449_26ad92732c8958d@scan.coverity.com.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtprelay4.synopsys.com ([198.182.47.9]:34092 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934480AbbI1RUZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Sep 2015 13:20:25 -0400
Received: from us02secmta2.synopsys.com (us02secmta2.synopsys.com [10.12.235.98])
	by smtprelay.synopsys.com (Postfix) with ESMTP id B740D24E13F3
	for <ceph-devel@vger.kernel.org>; Mon, 28 Sep 2015 10:20:24 -0700 (PDT)
Received: from us02secmta2.internal.synopsys.com (us02secmta2.internal.synopsys.com [127.0.0.1])
	by us02secmta2.internal.synopsys.com (Service) with ESMTP id A98D155F23
	for <ceph-devel@vger.kernel.org>; Mon, 28 Sep 2015 10:20:24 -0700 (PDT)
Received: from mailhost.synopsys.com (unknown [10.13.184.66])
	by us02secmta2.internal.synopsys.com (Service) with ESMTP id 902DF55F22
	for <ceph-devel@vger.kernel.org>; Mon, 28 Sep 2015 10:20:24 -0700 (PDT)
Received: from mailhost.synopsys.com (localhost [127.0.0.1])
	by mailhost.synopsys.com (Postfix) with ESMTP id 82AB0528
	for <ceph-devel@vger.kernel.org>; Mon, 28 Sep 2015 10:20:24 -0700 (PDT)
Received: from scanrelay.coverity.com (scanrelay.internal.synopsys.com [10.0.8.65])
	by mailhost.synopsys.com (Postfix) with ESMTP id 78EE8525
	for <ceph-devel@vger.kernel.org>; Mon, 28 Sep 2015 10:20:24 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>


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



