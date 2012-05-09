From: Guido Winkelmann <guido-ceph@thisisnotatest.de>
Subject: Can I use btrfs-restore to restore ceph osds?
Date: Wed, 09 May 2012 19:15:19 +0200
Message-ID: <8973610.uuSzCzFUvq@pc10>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from unknownsite.de ([62.48.69.106]:45965 "EHLO hartes-hannover.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751147Ab2EIRP1 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 9 May 2012 13:15:27 -0400
Received: from pc10.localnet (pc10.asys-h.de [193.98.1.90])
	by hartes-hannover.de (Postfix) with ESMTPSA id 40A0710C866
	for <ceph-devel@vger.kernel.org>; Wed,  9 May 2012 19:15:25 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I'm currently trying to re-enable my experimental ceph cluster that has been 
offline for a few months. Unfortunately, it appears that, out of the six btrfs 
volumes involved, only one can still be mounted, the other five are broken 
somehow. (If I ever use Ceph in production, it's probably not going to be on 
btrfs after this... I cannot recall whether or not the servers were properly 
shut down the last time, but even if not, this is a bit ridiculous.)

I cannot seem to repair the broken filesystem with btrfsck, but I can extract 
data from them with btrfs-restore.

If I want to restore this whole thing, can I just run btrfs-restore to recover 
the files that were on the broken volume, then make a new filesystem on the 
old partition, and finally copy over the directories and file restored by 
btrfs-restore? Or will that lose important information?

	Guido
