From: "Deneau, Tom" <tom.deneau@amd.com>
Subject: rpmbuild version
Date: Sat, 28 Mar 2015 13:04:09 +0000
Message-ID: <BC97738F8E7C8742BABED7F06FB9DF9166411E6C@SATLEXDAG01.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-by2on0109.outbound.protection.outlook.com ([207.46.100.109]:7605
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753264AbbC1NEO convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 28 Mar 2015 09:04:14 -0400
Received: from satlvexedge02.amd.com (satlvexedge02.amd.com [10.177.96.29])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by atltwp01.amd.com (Axway MailGate 5.3.1) with ESMTPS id 2FCD712C0001
	for <ceph-devel@vger.kernel.org>; Sat, 28 Mar 2015 08:04:09 -0500 (CDT)
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Starting from a ceph git checkout I want to create a source tar.bz2 to feed to rpmbuild.
I see there is a "make dist-bzip2" to make the actual source tar but if I want
the built binaries to identify themselves as a custom version, what is the best way to do that?

-- Tom Deneau

