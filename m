From: Jeff Wu <cpwu@tnsoft.com.cn>
Subject: Questions about ceph mount dir subdirectory max size limit
Date: Tue, 22 Feb 2011 17:37:37 +0800
Message-ID: <1298367457.1879.33.camel@cephhost>
Reply-To: <cpwu@tnsoft.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from [210.22.136.227] ([210.22.136.227]:25012 "EHLO
	MAIL.TNSOFT.COM.CN" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753385Ab1BVJh3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Feb 2011 04:37:29 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi ,
Resemble quota,
is there a way to limit per subdirectory max size under ceph mount
directory  ? 

For instance :
mount.ceph cephserver:6789:/ /mnt/ceph
/mnt/ceph     max size    300G 
/mnt/ceph/user1     max size limit   30G 
/mnt/ceph/user2     max size limit   50G 
/mnt/ceph/user3     max size limit   10G 
................
................

Thanks

Jeff C.P.Wu

