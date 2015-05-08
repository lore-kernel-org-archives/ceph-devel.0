From: "Deneau, Tom" <tom.deneau@amd.com>
Subject: No rule to make target `../src/gmock/lib/libgmock_main.la'
Date: Fri, 8 May 2015 03:24:31 +0000
Message-ID: <BC97738F8E7C8742BABED7F06FB9DF9166435336@SATLEXDAG01.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1bon0146.outbound.protection.outlook.com ([157.56.111.146]:41418
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752203AbbEHDYh convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 May 2015 23:24:37 -0400
Received: from satlvexedge02.amd.com (satlvexedge02.amd.com [10.177.96.29])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by atltwp02.amd.com (Axway MailGate 5.3.1) with ESMTPS id 2A7F6D1A007
	for <ceph-devel@vger.kernel.org>; Thu,  7 May 2015 23:24:29 -0400 (EDT)
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

I wanted to build v9.0.0 using 
I did 
	git clone http://github.com/ceph/ceph
	git checkout v9.0.0
	git submodule update --force --init --recursive
	autogen; configure; make

When I do so I get the following error
               
make[3]: *** No rule to make target `../src/gmock/lib/libgmock_main.la', needed by `unittest_librbd'.  Stop.

I did not have this problem when I had checked out 0.94.1
Is there some submodule step I am missing?

By the way, an rpmbuild of v9.0.0 from the tar.bz2 worked fine.

-- Tom Deneau, AMD


