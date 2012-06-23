From: Stefan Priebe <s.priebe@profihost.ag>
Subject: FS / Kernel question choosing the correct kernel version
Date: Sat, 23 Jun 2012 20:26:45 +0200
Message-ID: <4FE60A65.2030800@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:53143 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755305Ab2FWS0o (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 23 Jun 2012 14:26:44 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

i got stuck while selecting the right FS for ceph / RBD.

XFS:
- deadlock / hung task under 3.0.34 in xfs_ilock / xfs_buf_lock while syncfs
- under 3.5-rc3 all my machines got loaded doing nothing than waiting 
for XFS / SSDs so ceph is really slow / unuseable

btrfs:
- 3.5-rc3 ceph is pretty fast and works good until i see also a deadlock 
while doing heavy random I/Os in my rbd / kvm.

All processes hang in btrfs_commit_transaction or 
btrfs_commit_transaction_async

Are there tested / recommanded kernel versions for rbd and a specific fs.

Greets
Stefan
