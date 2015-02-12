From: "Deneau, Tom" <tom.deneau@amd.com>
Subject: using radosgw with mod_proxy_fcgi
Date: Thu, 12 Feb 2015 00:21:46 +0000
Message-ID: <BC97738F8E7C8742BABED7F06FB9DF915554B70A@SATLEXDAG01.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-by2on0132.outbound.protection.outlook.com ([207.46.100.132]:26688
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751417AbbBLAyw convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Feb 2015 19:54:52 -0500
Received: from satlvexedge02.amd.com (satlvexedge02.amd.com [10.177.96.29])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by atltwp02.amd.com (Axway MailGate 5.3.1) with ESMTPS id 266FED16045
	for <ceph-devel@vger.kernel.org>; Wed, 11 Feb 2015 18:21:46 -0600 (CST)
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I am a Ceph novice and have the rados and rbd setups working and would like to use the radosgw stack.

I am running on a platform (aarch64) for which there are no pre-built binaries of the ceph patched apache and the ceph patched mod_fastcgi.  But since I gather from the mail lists that the future is just to use mod_proxy_fcgi and since my apache install has mod_proxy_fcgi build in already that seems like the way to go.

I realize the documentation to explain exactly how to set things up with mod_proxy_fcgi is still in the works but if there is any preliminary documentation on this, I'd be glad to try it out.

-- Tom Deneau, AMD

