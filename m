From: Alex Elder <elder@inktank.com>
Subject: [PATCH 0/5] ceph: abstract message data information setting
Date: Tue, 05 Mar 2013 07:51:21 -0600
Message-ID: <5135F859.1090606@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:49223 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753975Ab3CENvZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Mar 2013 08:51:25 -0500
Received: by mail-ie0-f181.google.com with SMTP id 17so7603365iea.40
        for <ceph-devel@vger.kernel.org>; Tue, 05 Mar 2013 05:51:24 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The first two of these were posted before, but they ran into
trouble because assertions that data information fields in
ceph messages got set only once were failing.  Now those
assertions are commented out--initially.

The third and fourth patches in this series address the
reasons the assertions could fail, by changing the osd
client to only set message data fields once, and by changing
the mds client to only set them if there is data to be sent.

The final patch activates those commented-out assertions.

These are available in the branch "review/wip-abstract_data"
in the ceph-client git repository.

					-Alex

[PATCH 1/5] libceph: isolate message page field manipulation
[PATCH 2/5] libceph: isolate other message data fields
[PATCH 3/5] ceph: only set message data pointers if non-empty
[PATCH 4/5] libceph: set response data fields earlier
[PATCH 5/5] libceph: activate message data assignment checks

