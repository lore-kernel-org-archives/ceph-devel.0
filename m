From: "Deneau, Tom" <tom.deneau@amd.com>
Subject: osd pool erasure code stripe width
Date: Fri, 19 Jun 2015 20:11:50 +0000
Message-ID: <BC97738F8E7C8742BABED7F06FB9DF91669A8E8B@SATLEXDAG01.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1on0138.outbound.protection.outlook.com ([157.56.110.138]:44653
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752174AbbFSU1d convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 19 Jun 2015 16:27:33 -0400
Received: from satlvexedge01.amd.com (satlvexedge01.amd.com [10.177.96.28])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by atltwp02.amd.com (Axway MailGate 5.3.1) with ESMTPS id 23335BD8451
	for <ceph-devel@vger.kernel.org>; Fri, 19 Jun 2015 16:11:53 -0400 (EDT)
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

I am trying to understand the use of "osd pool erasure code stripe width"
For example, I have a single-node system with a k=2,m=1 ec pool
and I write a single 40M object to this pool using rados bench.
But when I look on the disk, I still see only the 3 20M pieces for this object.
Where does the striping get used?

-- Tom Deneau, AMD


Description:
Sets the desired size, in bytes, of an object stripe on every erasure coded pools. Every object if size S will be stored as N stripes and each stripe will be encoded/decoded individually.
Type:
Unsigned 32-bit Integer
Default:
4096


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
