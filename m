From: "Longguang Yue" <longguang_yue@tcloudcomputing.com>
Subject: how long client will take when recover to ok,after ceph down.
Date: Mon, 14 Feb 2011 09:21:42 +0800
Message-ID: <D0C67741759ABD4BBD8D3A5CB815606E07E915@mail.cloud-valley.com.cn>
References: <4D57DFFB.5080703@nadir-seen-fire.com> <Pine.LNX.4.64.1102131028450.27567@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from [203.114.244.241] ([203.114.244.241]:1203 "EHLO
	mail.cloud-valley.com" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755299Ab1BNBVv convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 13 Feb 2011 20:21:51 -0500
Content-class: urn:content-classes:message
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

When client lose its connection with ceph, then ls /mnt/ceph, it will
hang all the time
Remount does not work.
Thanks
