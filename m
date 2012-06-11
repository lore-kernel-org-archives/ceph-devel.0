From: <Eric_YH_Chen@wiwynn.com>
Subject: How to turn on async write of rbd ?
Date: Mon, 11 Jun 2012 10:34:11 +0800
Message-ID: <8512670932FB654F81AF0FEF1BE6D49D017E5125@WHQBEMAIL1.whq.wistron>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from twnhumsw2.wistron.com ([220.128.89.22]:57768 "EHLO
	TWNHUMSW2.wistron.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752145Ab2FKCeQ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 10 Jun 2012 22:34:16 -0400
Received: from twnhufe2.whq.wistron (unverified [10.37.31.102]) by TWNHUMSW2.wistron.com
 (Clearswift SMTPRS 5.4.0) with ESMTP id <Ta4e783f891c0a816702224@TWNHUMSW2.wistron.com> for <ceph-devel@vger.kernel.org>;
 Mon, 11 Jun 2012 10:33:42 +0800
Content-class: urn:content-classes:message
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Chris_YT_Huang@wiwynn.com, Victor_CY_Chang@wiwynn.com

Dear All:

   I saw rbd support "async writes" since 0.36, http://ceph.com/2011/09/
   But I cannot find related document that how to turn on it.
   Should I just write "enabled" to /sys/devices/rbd/0/power/async?

   One more thing, If I want to implement iSCSI multipath with RBD, just
like http://ceph.com/wiki/ISCSI
   Can I turn on the async writes under this situation?

   Thanks!


