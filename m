From: scan-admin@coverity.com
Subject: New Defects reported by Coverity Scan for ceph
Date: Thu, 02 Oct 2014 06:21:18 -0700
Message-ID: <542d514e83d2a_19ff10a933428996@scan.coverity.com.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.60.111]:41860 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934488AbbI1RU1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Sep 2015 13:20:27 -0400
Received: from dc8secmta1.synopsys.com (dc8secmta1.synopsys.com [10.13.218.200])
	by smtprelay.synopsys.com (Postfix) with ESMTP id A747310C158E
	for <ceph-devel@vger.kernel.org>; Mon, 28 Sep 2015 10:20:26 -0700 (PDT)
Received: from dc8secmta1.internal.synopsys.com (dc8secmta1.internal.synopsys.com [127.0.0.1])
	by dc8secmta1.internal.synopsys.com (Service) with ESMTP id 9484727123
	for <ceph-devel@vger.kernel.org>; Mon, 28 Sep 2015 10:20:26 -0700 (PDT)
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
	by dc8secmta1.internal.synopsys.com (Service) with ESMTP id 7A8AA27121
	for <ceph-devel@vger.kernel.org>; Mon, 28 Sep 2015 10:20:26 -0700 (PDT)
Received: from mailhost.synopsys.com (localhost [127.0.0.1])
	by mailhost.synopsys.com (Postfix) with ESMTP id 658B71FF
	for <ceph-devel@vger.kernel.org>; Mon, 28 Sep 2015 10:20:26 -0700 (PDT)
Received: from scanrelay.coverity.com (scanrelay.internal.synopsys.com [10.0.8.65])
	by mailhost.synopsys.com (Postfix) with ESMTP id 46F5D1F9
	for <ceph-devel@vger.kernel.org>; Mon, 28 Sep 2015 10:20:26 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>


Hi,


Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

Defect(s) Reported-by: Coverity Scan
Showing 1 of 1 defect(s)


** CID 1243158:  Resource leak  (RESOURCE_LEAK)
/test/librbd/test_librbd.cc: 1370 in LibRBD_ListChildrenTiered_Test::TestBody()()


________________________________________________________________________________________________________
*** CID 1243158:  Resource leak  (RESOURCE_LEAK)
/test/librbd/test_librbd.cc: 1370 in LibRBD_ListChildrenTiered_Test::TestBody()()
1364     
1365       int features = RBD_FEATURE_LAYERING;
1366       rbd_image_t parent;
1367       int order = 0;
1368     
1369       // make a parent to clone from
>>>     CID 1243158:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "ioctx2" going out of scope leaks the storage it points to.
1370       ASSERT_EQ(0, create_image_full(ioctx1, "parent", 4<<20, &order,
1371     				 false, features));
1372       ASSERT_EQ(0, rbd_open(ioctx1, "parent", &parent, NULL));
1373       // create a snapshot, reopen as the parent we're interested in
1374       ASSERT_EQ(0, rbd_snap_create(parent, "parent_snap"));
1375       ASSERT_EQ(0, rbd_snap_set(parent, "parent_snap"));


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, http://scan.coverity.com/projects/25?tab=overview

To unsubscribe from the email notification for new defects, http://scan5.coverity.com/cgi-bin/unsubscribe.py



