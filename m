From: scan-admin@coverity.com
Subject: New Defects reported by Coverity Scan for ceph
Date: Sat, 09 Aug 2014 08:30:23 -0700
Message-ID: <53e63e8f3af45_6cc37f33348794d@209.249.196.67.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:41857 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934480AbbI1RU0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Sep 2015 13:20:26 -0400
Received: from us02secmta1.synopsys.com (us02secmta1.synopsys.com [10.12.235.96])
	by smtprelay.synopsys.com (Postfix) with ESMTP id 7AD4F10C09A5
	for <ceph-devel@vger.kernel.org>; Mon, 28 Sep 2015 10:20:26 -0700 (PDT)
Received: from us02secmta1.internal.synopsys.com (us02secmta1.internal.synopsys.com [127.0.0.1])
	by us02secmta1.internal.synopsys.com (Service) with ESMTP id 6EADC4E21F
	for <ceph-devel@vger.kernel.org>; Mon, 28 Sep 2015 10:20:26 -0700 (PDT)
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
	by us02secmta1.internal.synopsys.com (Service) with ESMTP id 55A234E21E
	for <ceph-devel@vger.kernel.org>; Mon, 28 Sep 2015 10:20:26 -0700 (PDT)
Received: from mailhost.synopsys.com (localhost [127.0.0.1])
	by mailhost.synopsys.com (Postfix) with ESMTP id 414181F8
	for <ceph-devel@vger.kernel.org>; Mon, 28 Sep 2015 10:20:26 -0700 (PDT)
Received: from scanrelay.coverity.com (scanrelay.internal.synopsys.com [10.0.8.65])
	by mailhost.synopsys.com (Postfix) with ESMTP id 34D9F1F7
	for <ceph-devel@vger.kernel.org>; Mon, 28 Sep 2015 10:20:26 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>


Hi,


Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

Defect(s) Reported-by: Coverity Scan
Showing 1 of 1 defect(s)


** CID 1230671:  Missing unlock  (LOCK)
/msg/SimpleMessenger.cc: 258 in SimpleMessenger::reaper()()


________________________________________________________________________________________________________
*** CID 1230671:  Missing unlock  (LOCK)
/msg/SimpleMessenger.cc: 258 in SimpleMessenger::reaper()()
252           ::close(p->sd);
253         ldout(cct,10) << "reaper reaped pipe " << p << " " << p->get_peer_addr() << dendl;
254         p->put();
255         ldout(cct,10) << "reaper deleted pipe " << p << dendl;
256       }
257       ldout(cct,10) << "reaper done" << dendl;
>>>     CID 1230671:  Missing unlock  (LOCK)
>>>     Returning without unlocking "this->lock._m".
258     }
259     
260     void SimpleMessenger::queue_reap(Pipe *pipe)
261     {
262       ldout(cct,10) << "queue_reap " << pipe << dendl;
263       lock.Lock();


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, http://scan.coverity.com/projects/25?tab=overview

To unsubscribe from the email notification for new defects, http://scan5.coverity.com/cgi-bin/unsubscribe.py



