From: Fyodor Ustinov <ufm@ufm.su>
Subject: increase duplication level decrease performance
Date: Mon, 4 Apr 2011 21:55:04 +0000 (UTC)
Message-ID: <loom.20110404T235336-22@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:40775 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753148Ab1DDWPK (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 4 Apr 2011 18:15:10 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1Q6s3A-0007ae-EV
	for ceph-devel@vger.kernel.org; Tue, 05 Apr 2011 00:15:08 +0200
Received: from 94.232.181.14 ([94.232.181.14])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Tue, 05 Apr 2011 00:15:08 +0200
Received: from ufm by 94.232.181.14 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Tue, 05 Apr 2011 00:15:08 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi.

ceph osd pool set data size 1

dd if=/dev/zero of=aaa bs=1024000 count=4000
4096000000 bytes (4.1 GB) copied, 31.3153 s, 131 MB/s

ceph osd pool set data size 2
4096000000 bytes (4.1 GB) copied, 72.7146 s, 56.3 MB/s

ceph osd pool set data size 3
4096000000 bytes (4.1 GB) copied, 136.263 s, 30.1 MB/s

Why? I thought increase in the number of copies should increase the 
performance (in the worst case does not affect).

WBR,
    Fyodor.


