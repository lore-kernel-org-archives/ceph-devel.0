From: scan-admin@coverity.com
Subject: New Defects reported by Coverity Scan for ceph
Date: Fri, 26 Dec 2014 06:19:33 -0800
Message-ID: <549d6e7576ca8_5d4085d33888668@scan.coverity.com.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from scanrelay.coverity.com ([209.249.196.67]:58985 "EHLO
	scanrelay.coverity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751122AbaLZOTe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Dec 2014 09:19:34 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi,

Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

1 new defect(s) introduced to ceph found with Coverity Scan.
1 defect(s), reported by Coverity Scan earlier, were marked fixed in the recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 1 of 1 defect(s)


** CID 1260469:  Unchecked return value from library  (CHECKED_RETURN)
/os/FileJournal.cc: 1083 in FileJournal::do_write(ceph::buffer::list &)()


________________________________________________________________________________________________________
*** CID 1260469:  Unchecked return value from library  (CHECKED_RETURN)
/os/FileJournal.cc: 1083 in FileJournal::do_write(ceph::buffer::list &)()
1077         ::fsync(fd);
1078     #else
1079         ::fdatasync(fd);
1080     #endif
1081     #ifdef HAVE_POSIX_FADVISE
1082         if (g_conf->filestore_fadvise)
>>>     CID 1260469:  Unchecked return value from library  (CHECKED_RETURN)
>>>     Calling "posix_fadvise(this->fd, 0L, 0L, 4)" without checking return value. This library function may fail and return an error code.
1083           posix_fadvise(fd, 0, 0, POSIX_FADV_DONTNEED);
1084     #endif
1085       }
1086     
1087       utime_t lat = ceph_clock_now(g_ceph_context) - from;    
1088       dout(20) << "do_write latency " << lat << dendl;


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, http://scan.coverity.com/projects/25?tab=overview

To manage Coverity Scan email notifications for "ceph-devel@vger.kernel.org", click http://scan.coverity.com/subscriptions/edit?email=ceph-devel%40vger.kernel.org&token=018084d671e3cc89d00dd2ccb7eb849c .

