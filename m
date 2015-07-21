From: "Deneau, Tom" <tom.deneau@amd.com>
Subject: 9.0.2 test/perf_local.cc on non-x86 architectures
Date: Tue, 21 Jul 2015 16:34:03 +0000
Message-ID: <BC97738F8E7C8742BABED7F06FB9DF91669B9E68@SATLEXDAG01.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-by2on0105.outbound.protection.outlook.com ([207.46.100.105]:22400
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755091AbbGUQeL convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Jul 2015 12:34:11 -0400
Received: from satlvexedge02.amd.com (satlvexedge02.amd.com [10.177.96.29])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by atltwp02.amd.com (Axway MailGate 5.3.1) with ESMTPS id 21996D16045
	for <ceph-devel@vger.kernel.org>; Tue, 21 Jul 2015 12:34:01 -0400 (EDT)
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

I was trying to do an rpmbuild of v9.0.2 for aarch64 and got the following error:

test/perf_local.cc: In function 'double div32()':
test/perf_local.cc:396:31: error: impossible constraint in 'asm'
                          "cc");

Probably should have an if defined (__i386__) around it.

-- Tom

