From: Joe Buck <jbbuck@gmail.com>
Subject: Review request for branch wip-java-tests
Date: Thu, 08 Nov 2012 09:32:22 -0800
Message-ID: <509BECA6.4020008@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33058 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752427Ab2KHRcU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Nov 2012 12:32:20 -0500
Received: by mail-pa0-f46.google.com with SMTP id hz1so2138448pad.19
        for <ceph-devel@vger.kernel.org>; Thu, 08 Nov 2012 09:32:19 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I have a branch for review that reworks that tests for the java bindings 
and builds them if both --enable-cephfs-java and --with-debug are 
specified. The tests can also be built and run via ant.

Branch name is wip-java-tests.

Regards,
-Joe Buck
