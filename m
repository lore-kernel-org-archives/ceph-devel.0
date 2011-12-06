From: <Eric_YH_Chen@wistron.com>
Subject: How to sync data on different server but with the same image
Date: Tue, 6 Dec 2011 17:17:44 +0800
Message-ID: <8512670932FB654F81AF0FEF1BE6D49D9430EB@WHQBEMAIL1.whq.wistron>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from twnhumsw5.wistron.com ([220.128.89.25]:64572 "EHLO
	TWNHUMSW5.wistron.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932905Ab1LFJRr convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Dec 2011 04:17:47 -0500
Received: from twnhufe1.whq.wistron (unverified [10.37.31.101]) by TWNHUMSW5.wistron.com
 (Clearswift SMTPRS 5.4.0) with ESMTP id <Ta120cb3546c0a8167320e4@TWNHUMSW5.wistron.com> for <ceph-devel@vger.kernel.org>;
 Tue, 6 Dec 2011 17:18:43 +0800
Content-class: urn:content-classes:message
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Chris_YT_Huang@wistron.com

Dear All:

   I map the same rbd image to the rbd device on two different servers.

	For example:   
     1. create rbd image named foo
     2. map foo to /dev/rbd0 on server A,  mount /dev/rbd0 to /mnt
     3. map foo to /dev/rbd0 on server B,  mount /dev/rbd0 to /mnt

   If I put add a file to /mnt via server A, I hope I can see the same
file on server B.
   However, I can't see it until I umount /mnt on server A and re-mount
/mnt on server B.
   
   Do you have any comment about this scenario? How could I force the
data synchronization?

   Actually, I want to implement the iSCSI High Available multipath on
http://ceph.newdream.net/wiki/ISCSI.
   Therefore, I tried this small experiment first, but fail. Would you
please give me some suggestion before I start to implement it? Thanks!


