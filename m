From: scan-admin@coverity.com
Subject: New Defects reported by Coverity Scan for ceph
Date: Thu, 28 Sep 2017 05:09:08 +0000 (UTC)
Message-ID: <59cc83f4587ad_1cc671733478d1@ss1435.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from o5.24nn.shared.sendgrid.net ([50.31.63.1]:37213 "EHLO
        o5.24nn.shared.sendgrid.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750914AbdI1FJJ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 28 Sep 2017 01:09:09 -0400
Received: from coverity.com (static-208.69.177.245.nephosdns.com [208.69.177.245])
        by ismtpd0023p1las1.sendgrid.net (SG) with ESMTP id B7QRKkOjQnOSqyeYT7FGFQ
        for <ceph-devel@vger.kernel.org>; Thu, 28 Sep 2017 05:09:08.588 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi,

Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

1 new defect(s) introduced to ceph found with Coverity Scan.
8 defect(s), reported by Coverity Scan earlier, were marked fixed in the recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 1 of 1 defect(s)


** CID 1418596:  Program hangs  (ORDER_REVERSAL)


________________________________________________________________________________________________________
*** CID 1418596:  Program hangs  (ORDER_REVERSAL)
/home/brad/working/src/ceph/src/tools/cephfs/Dumper.cc: 64 in Dumper::recover_journal(Journaler *)()
58     
59     
60     int Dumper::recover_journal(Journaler *journaler)
61     {
62       C_SaferCond cond;
63       lock.Lock();
>>>     CID 1418596:  Program hangs  (ORDER_REVERSAL)
>>>     Calling "recover" acquires lock "Journaler.lock" while holding lock "Mutex._m" (count: 1 / 6).
64       journaler->recover(&cond);
65       lock.Unlock();
66       const int r = cond.wait();
67     
68       if (r < 0) { // Error
69         derr << "error on recovery: " << cpp_strerror(r) << dendl;


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRaGCnxtQO9E3gxlB2GxVsWFENryh7bC5hIb-2FQBVM85YLQ-3D-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8Gm8nnXjGdSCg3Y3xJLzJka5OSmtSf-2BpUegs4H9v0CBigN85le6zVzYYwpgazONa6fU9p92NkrJbrUVT4aNO4guK9R6ITym49IktPI8IzeuyOQ7NY4AUM1lqvKPRmubM0kw0tXn90C3Ytd5iJ-2Boif1yj85E5vF2fOnU6QsJ0s5tIJdqN5a3DvwBDMY9w43Nwdg-3D

To manage Coverity Scan email notifications for "ceph-devel@vger.kernel.org", click https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRbVDbis712qZDP-2FA8y06Nq4Bco8jcmzhh7FSyvoR0E3-2BDgRcBCQ6OuthHBtaTCGNq9OVG2ZVnjrgThgf5hX3GVEkIxvBX-2BorwRZfOftSp7HPfCifRGGak1MlgNFVd3IIPA-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8Gm8nnXjGdSCg3Y3xJLzJka5OSmtSf-2BpUegs4H9v0CBilB9hnyE1u8H6YPr85gqxxRIYgD7GieCWnZKVoDvLULn9JV0oJDUW6HUoyHV2Eyp9wGGAkh4xLlxe0LuCzLREu30rbCGrbH6kxuDNkfPxJ47brJv8wMXUXTN1puP0hdVcKGDHWv23YvvEM8i6vD4KNg-3D

