From: "Deneau, Tom" <tom.deneau@amd.com>
Subject: rados bench throughput with no disk or network activity
Date: Thu, 28 May 2015 23:09:56 +0000
Message-ID: <BC97738F8E7C8742BABED7F06FB9DF9166995A9B@satlexdag04.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1on0112.outbound.protection.outlook.com ([157.56.110.112]:39712
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755202AbbE1XKA convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 May 2015 19:10:00 -0400
Received: from satlvexedge01.amd.com (satlvexedge01.amd.com [10.177.96.28])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by atltwp02.amd.com (Axway MailGate 5.3.1) with ESMTPS id 21307BD8453
	for <ceph-devel@vger.kernel.org>; Thu, 28 May 2015 19:09:55 -0400 (EDT)
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

I've noticed that
   * with a single node cluster with 4 osds
   * and running rados bench rand on that same node so no network traffic
   * with a number of objects small enough so that everything is in the cache so no disk traffic

we still peak out at about 1600 MB/sec.

And the cpu is 40% idle. (and a good chunk of the cpu activity is the rados benchmark itself)

What is likely causing the throttling here?

-- Tom Deneau, AMD




