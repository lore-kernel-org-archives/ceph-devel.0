From: "Deneau, Tom" <tom.deneau@amd.com>
Subject: keyring issues, 9.1.0
Date: Thu, 22 Oct 2015 21:25:34 +0000
Message-ID: <BC97738F8E7C8742BABED7F06FB9DF91925270E1@SATLEXDAG01.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1on0088.outbound.protection.outlook.com ([157.56.110.88]:20363
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S965019AbbJVVZk convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Oct 2015 17:25:40 -0400
Received: from satlvexedge02.amd.com (satlvexedge02.amd.com [10.177.96.29])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by atltwp02.amd.com (Axway MailGate 5.3.1) with ESMTPS id 2B487D1602A
	for <ceph-devel@vger.kernel.org>; Thu, 22 Oct 2015 17:25:35 -0400 (EDT)
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

My current situation as I upgrade to v9.1.0 is that client.admin keyring seems to work fine, for instance for ceph status command.  But commands that use client.bootstrap-osd  such as

/usr/bin/ceph --cluster ceph --name client.bootstrap-osd --keyring /var/lib/ceph/bootstrap-osd/ceph.keyring osd create --concise a428120d-99ec-4a73-999f-75d8a6bfcb2e

are getting "EACCES: access denied"

with log entries in ceph.audit.log such as

2015-10-22 13:50:24.070249 mon.0 10.0.2.132:6789/0 33 : audit [INF] from='client.? 10.0.2.132:0/263577121' entity='client.bootstrap-osd' cmd=[{"prefix": "osd create", "uuid": "a428120d-99ec-4a73-999f-75d8a6bfcb2e"}]:  access denied

I tried setting
    debug auth = 0
in ceph.conf but couldn't tell anything from that output.

Is there anything special I should look for here?
Note: I do have /var/lib/ceph and subdirectories owned by ceph:ceph

-- Tom


