From: "Deneau, Tom" <tom.deneau@amd.com>
Subject: erasure pool with isa plugin
Date: Mon, 22 Jun 2015 21:10:25 +0000
Message-ID: <BC97738F8E7C8742BABED7F06FB9DF91669A9C09@SATLEXDAG01.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1bbn0107.outbound.protection.outlook.com ([157.56.111.107]:35456
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751408AbbFVVZE convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Jun 2015 17:25:04 -0400
Received: from satlvexedge01.amd.com (satlvexedge01.amd.com [10.177.96.28])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by atltwp02.amd.com (Axway MailGate 5.3.1) with ESMTPS id 2F304D1602E
	for <ceph-devel@vger.kernel.org>; Mon, 22 Jun 2015 17:10:22 -0400 (EDT)
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

If one has a cluster with some nodes that can run with the ISA plugin
and some that cannot, is there a way to define a pool such that the
ISA-capable nodes can use the ISA plugin and the others can use say
the jerasure plugin?

-- Tom Deneau

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
