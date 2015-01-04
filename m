From: scan-admin@coverity.com
Subject: New Defects reported by Coverity Scan for ceph
Date: Sun, 04 Jan 2015 06:14:49 -0800
Message-ID: <54a94ad928d4a_c3db01328948c@scan.coverity.com.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from scanrelay.coverity.com ([209.249.196.67]:56355 "EHLO
	scanrelay.coverity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752586AbbADOOu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 4 Jan 2015 09:14:50 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi,

Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

1 new defect(s) introduced to ceph found with Coverity Scan.


New defect(s) Reported-by: Coverity Scan
Showing 1 of 1 defect(s)


** CID 1261633:  Time of check time of use  (TOCTOU)
/mount/mtab.c: 275 in update_mtab_entry()


________________________________________________________________________________________________________
*** CID 1261633:  Time of check time of use  (TOCTOU)
/mount/mtab.c: 275 in update_mtab_entry()
269     	mnt.mnt_freq = freq;
270     	mnt.mnt_passno = pass;
271     
272     	FILE *fp;
273     	
274     	lock_mtab();
>>>     CID 1261633:  Time of check time of use  (TOCTOU)
>>>     Calling function "setmntent" that uses ""/etc/mtab"" after a check function. This can cause a time-of-check, time-of-use race condition.
275     	fp = setmntent(_PATH_MOUNTED, "a+");
276     	if (fp == NULL) {
277     		int errsv = errno;
278     		printf("mount: can't open %s: %s", _PATH_MOUNTED,
279     		       strerror (errsv));
280     	} else {


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, http://scan.coverity.com/projects/25?tab=overview

To manage Coverity Scan email notifications for "ceph-devel@vger.kernel.org", click http://scan.coverity.com/subscriptions/edit?email=ceph-devel%40vger.kernel.org&token=018084d671e3cc89d00dd2ccb7eb849c .

