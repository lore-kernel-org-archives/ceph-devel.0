From: "Deneau, Tom" <tom.deneau@amd.com>
Subject: journal writes when running rados bench seq on ec pool
Date: Wed, 13 May 2015 23:39:54 +0000
Message-ID: <BC97738F8E7C8742BABED7F06FB9DF9166442D87@SATLEXDAG01.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-by2on0118.outbound.protection.outlook.com ([207.46.100.118]:51949
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1030219AbbEMXkB convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 May 2015 19:40:01 -0400
Received: from satlvexedge02.amd.com (satlvexedge02.amd.com [10.177.96.29])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by atltwp02.amd.com (Axway MailGate 5.3.1) with ESMTPS id 26759D1603A
	for <ceph-devel@vger.kernel.org>; Wed, 13 May 2015 19:39:52 -0400 (EDT)
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

I am running a rados bench seq read benchmark on an erasure-coded pool (k=2, m=1),
and recording the disk activity.   I notice that I always see a small number of writes
to the journal partitions during the seq read run.  (I always drop the caches on the osd nodes
before starting the seq read run).

I never see this journal write behavior with a replicated pool and I didn't think there
would be any journal writes with either kind of pool on a read benchmark.

The write activity is low enough that it's probably not that important performance-wise
but I as just curious as to what would cause this.

-- Tom Deneau



