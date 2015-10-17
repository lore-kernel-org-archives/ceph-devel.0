From: "Deneau, Tom" <tom.deneau@amd.com>
Subject: symbol lookup error v9.1.0
Date: Sat, 17 Oct 2015 03:37:27 +0000
Message-ID: <BC97738F8E7C8742BABED7F06FB9DF9192524E19@SATLEXDAG01.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bl2on0082.outbound.protection.outlook.com ([65.55.169.82]:39282
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750961AbbJQDhe convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Oct 2015 23:37:34 -0400
Received: from satlvexedge01.amd.com (satlvexedge01.amd.com [10.177.96.28])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by atltwp02.amd.com (Axway MailGate 5.3.1) with ESMTPS id 2F1BAD16025
	for <ceph-devel@vger.kernel.org>; Fri, 16 Oct 2015 23:37:26 -0400 (EDT)
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On an ubuntu trusty system,
   * I installed v9.1.0 and could bring up a single node cluster with it.
   * I did a git checkout of v9.1.0, followed by ./autogen.sh; ./configure; make

Then when I try to run for example the rados I just built using
     "./src/.libs/rados -v"

I get
./src/.libs/rados: symbol lookup error: ./src/.libs/rados: undefined symbol: _ZN8librados20ObjectWriteOperation9copy_fromERKSsRKNS_5IoCtxEmj

which decodes to
 librados::ObjectWriteOperation::copy_from(std::string const&, librados::IoCtx const&, unsigned long, unsigned int)

Is there any reason why this symbol should not be resolved by the installed libraries of v9.1.0?

-- Tom Deneau
