From: "Deneau, Tom" <tom.deneau@amd.com>
Subject: deleting objects from a pool
Date: Wed, 24 Jun 2015 16:43:47 +0000
Message-ID: <BC97738F8E7C8742BABED7F06FB9DF91669AC8C2@SATLEXDAG01.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1bon0131.outbound.protection.outlook.com ([157.56.111.131]:55760
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753697AbbFXQnw convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Jun 2015 12:43:52 -0400
Received: from satlvexedge01.amd.com (satlvexedge01.amd.com [10.177.96.28])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by atltwp01.amd.com (Axway MailGate 5.3.1) with ESMTPS id 2F4A2CAE635
	for <ceph-devel@vger.kernel.org>; Wed, 24 Jun 2015 12:43:48 -0400 (EDT)
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

I have benchmarking situations where I want to leave a pool around but
delete a lot of objects from the pool.  Is there any really fast way to do that?
I noticed rados rmpool is fast but I don't want to remove the pool.

I have been spawning multiple threads, each deleting a subset of the objects
(which I believe is what rados bench write does) but even that can be very slow.

-- Tom Deneau

