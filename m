From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Intel 520/530 SSD for ceph
Date: Mon, 18 Nov 2013 14:38:42 +0100
Message-ID: <528A1862.7010601@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ph.de-nserver.de ([85.158.179.214]:45738 "EHLO
	mail-ph.de-nserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750779Ab3KRNip (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Nov 2013 08:38:45 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

Hi guys,

in the past we've used intel 520 ssds for ceph journal - this worked
great and our experience was good.

Now they started to replace the 520 series with their new 530.

When we did we were supriced by the ugly performance and i need some
days to reproduce.

While O_DIRECT works fine for both and the intel ssd 530 is even faster
than the 520.

O_DSYNC... see the results:

~# dd if=randfile.gz of=/dev/sda bs=350k count=10000 oflag=direct,dsync
3584000000 bytes (3,6 GB) copied, 22,287 s, 161 MB/s

~# dd if=randfile.gz of=/dev/sdb bs=350k count=10000 oflag=direct,dsync
3584000000 bytes (3,6 GB) copied, 136,505 s, 26,3 MB/s

I used a blocksize of 350k as my graphes shows me that this is the
average workload we have on the journal. But i also tried using fio,
bigger blocksize, ... it stays the same.

Does anybody have an idea? Without dsync both devices have around the
same performance of 260MB/s.

Greets,
Stefan
