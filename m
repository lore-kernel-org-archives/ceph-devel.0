From: "Deneau, Tom" <tom.deneau@amd.com>
Subject: ceph tell osd bench
Date: Thu, 23 Apr 2015 13:58:42 +0000
Message-ID: <BC97738F8E7C8742BABED7F06FB9DF916642BFFE@SATLEXDAG01.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1bbn0105.outbound.protection.outlook.com ([157.56.111.105]:10624
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757818AbbDWN6r convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 23 Apr 2015 09:58:47 -0400
Received: from satlvexedge02.amd.com (satlvexedge02.amd.com [10.177.96.29])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by atltwp01.amd.com (Axway MailGate 5.3.1) with ESMTPS id 2C98912C0004
	for <ceph-devel@vger.kernel.org>; Thu, 23 Apr 2015 08:58:41 -0500 (CDT)
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

While running ceph tell osd bench and playing around with the total_bytes and block_size parameters,
I have noticed that if the total_bytes written is less than about 0.5G, the bytes/sec is much higher.
Why is that?

-- Tom Deneau
