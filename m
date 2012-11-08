From: Joe Buck <jbbuck@gmail.com>
Subject: Review request branch wip-java-test
Date: Thu, 8 Nov 2012 15:16:13 -0800
Message-ID: <0546E4DD-15A0-4850-A28F-41845E8DBC54@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:51985 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757227Ab2KHXQP convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Nov 2012 18:16:15 -0500
Received: by mail-pb0-f46.google.com with SMTP id rr4so2384809pbb.19
        for <ceph-devel@vger.kernel.org>; Thu, 08 Nov 2012 15:16:15 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I have a 3 line change to the file qa/workunits/libcephfs-java/test.sh that tweaks how LD_LIBRARY_PATH is set for the test execution.

The branch is wip-java-test in ceph.git.

Best,
-Joe Buck