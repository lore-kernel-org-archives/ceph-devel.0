From: scan-admin@coverity.com
Subject: New Defects reported by Coverity Scan for ceph
Date: Tue, 02 Dec 2014 06:09:56 -0800
Message-ID: <547dc83438133_459d9f331411560@scan.coverity.com.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from scanrelay.coverity.com ([209.249.196.67]:52138 "EHLO
	scanrelay.coverity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753373AbaLBOJ5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 2 Dec 2014 09:09:57 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi,

Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

1 new defect(s) introduced to ceph found with Coverity Scan.
9 defect(s), reported by Coverity Scan earlier, were marked fixed in the recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 1 of 1 defect(s)


** CID 1256511:  Missing unlock  (LOCK)
/mds/MDLog.cc: 612 in MDLog::trim_all()()
/mds/MDLog.cc: 612 in MDLog::trim_all()()


________________________________________________________________________________________________________
*** CID 1256511:  Missing unlock  (LOCK)
/mds/MDLog.cc: 612 in MDLog::trim_all()()
606           p = segments.lower_bound(last_seq + 1);
607         }
608       }
609     
610       _trim_expired_segments();
611     
>>>     CID 1256511:  Missing unlock  (LOCK)
>>>     Returning without unlocking "this->submit_mutex._m".
612       return 0;
613     }
614     
615     
616     void MDLog::try_expire(LogSegment *ls, int op_prio)
617     {
/mds/MDLog.cc: 612 in MDLog::trim_all()()
606           p = segments.lower_bound(last_seq + 1);
607         }
608       }
609     
610       _trim_expired_segments();
611     
>>>     CID 1256511:  Missing unlock  (LOCK)
>>>     Returning without unlocking "this->submit_mutex._m".
612       return 0;
613     }
614     
615     
616     void MDLog::try_expire(LogSegment *ls, int op_prio)
617     {


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, http://scan.coverity.com/projects/25?tab=overview

To unsubscribe from the email notification for new defects, http://scan5.coverity.com/cgi-bin/unsubscribe.py



