From: Wido den Hollander <wido@widodh.nl>
Subject: (unknown)
Date: Wed, 16 Nov 2011 20:41:14 +0100
Message-ID: <1321472475-19115-1-git-send-email-wido@widodh.nl>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from hosted.by.pcextreme ([109.72.90.196]:36320 "EHLO
	logger.ceph.widodh.nl" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1751953Ab1KPTuK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Nov 2011 14:50:10 -0500
Subject: 
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


When upgrading or installing we do not want to stop or start the init scripts.

This could break upgrades but also do harmfull stuff we don't want.

Let the sysadmin decide when to (re)start the daemons
