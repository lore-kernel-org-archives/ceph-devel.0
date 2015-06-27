From: "Deneau, Tom" <tom.deneau@amd.com>
Subject: load-gen from an osd node
Date: Sat, 27 Jun 2015 00:48:07 +0000
Message-ID: <BC97738F8E7C8742BABED7F06FB9DF91669ADC59@SATLEXDAG01.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1bon0141.outbound.protection.outlook.com ([157.56.111.141]:57815
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753058AbbF0AsO convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Jun 2015 20:48:14 -0400
Received: from satlvexedge01.amd.com (satlvexedge01.amd.com [10.177.96.28])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by atltwp01.amd.com (Axway MailGate 5.3.1) with ESMTPS id 20975CAE7D2
	for <ceph-devel@vger.kernel.org>; Fri, 26 Jun 2015 20:48:08 -0400 (EDT)
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

I am running 9.0.1 and I noticed when I run rados load-gen from one of the osd nodes,
it creates the objects but then always reports a throughput of 0 MB/sec.

But if I run it from a separate client node, it works fine.
Why would this be?

I'm not sure but I thought in earlier versions load-gen could be run from an osd node.

-- Tom Deneau
