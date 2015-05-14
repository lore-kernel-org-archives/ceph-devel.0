From: "Deneau, Tom" <tom.deneau@amd.com>
Subject: which osds get used for ec pool reads?
Date: Thu, 14 May 2015 16:27:14 +0000
Message-ID: <BC97738F8E7C8742BABED7F06FB9DF9166448682@SATLEXDAG01.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bl2on0138.outbound.protection.outlook.com ([65.55.169.138]:20544
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932600AbbENQlb convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 May 2015 12:41:31 -0400
Received: from satlvexedge01.amd.com (satlvexedge01.amd.com [10.177.96.28])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by atltwp02.amd.com (Axway MailGate 5.3.1) with ESMTPS id 28AF2D16050
	for <ceph-devel@vger.kernel.org>; Thu, 14 May 2015 12:27:15 -0400 (EDT)
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

I am looking at disk activity on reads from an erasure coded pool (k=2, m=1).
I have a contrived setup where I am reading a bunch of names that are
all in the same PG.  I see disk activity only from the 2 K osds, not the M osd.

As I understand http://ceph.com/docs/master/architecture/,  in this situation
all 3 osds would be read and the first two to return would be used but that is not what I see.

In this particular contrived setup, all of the OSDs are on a single node,
would that be causing the 2-OSD read behavior that I am seeing?

-- Tom Deneau


