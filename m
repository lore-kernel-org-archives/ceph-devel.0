From: Wido den Hollander <wido@42on.com>
Subject: inode64 mount option for XFS
Date: Mon, 03 Nov 2014 13:28:42 +0100
Message-ID: <545774FA.2070102@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:37367 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751557AbaKCM2s (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 3 Nov 2014 07:28:48 -0500
Received: from [10.100.7.32] (a83-160-116-36.adsl.xs4all.nl [83.160.116.36])
	by websrv.42on.com (Postfix) with ESMTPSA id 1B5D8BF46A
	for <ceph-devel@vger.kernel.org>; Mon,  3 Nov 2014 13:28:44 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

While look at init-ceph and ceph-disk I noticed a discrepancy between them.

init-ceph mounts XFS filesystems with rw,noatime,inode64, but
ceph-disk(-active) with rw,noatime

As inode64 gives the best performance, shouldn't ceph-disk do the same?

Any implications if we add inode64 on running deployments?

-- 
Wido den Hollander
42on B.V.
Ceph trainer and consultant

Phone: +31 (0)20 700 9902
Skype: contact42on
