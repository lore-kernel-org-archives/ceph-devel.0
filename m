From: Guido Winkelmann <guido-ceph@thisisnotatest.de>
Subject: Re: Can I use btrfs-restore to restore ceph osds?
Date: Wed, 09 May 2012 19:35:47 +0200
Message-ID: <1862199.KHPoMmXDX8@pc10>
References: <8973610.uuSzCzFUvq@pc10>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from unknownsite.de ([62.48.69.106]:32800 "EHLO hartes-hannover.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754302Ab2EIRfz (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 9 May 2012 13:35:55 -0400
Received: from pc10.localnet (pc10.asys-h.de [193.98.1.90])
	by hartes-hannover.de (Postfix) with ESMTPSA id 2E95E10C866
	for <ceph-devel@vger.kernel.org>; Wed,  9 May 2012 19:35:54 +0200 (CEST)
In-Reply-To: <8973610.uuSzCzFUvq@pc10>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Am Mittwoch, 9. Mai 2012, 19:15:19 schrieben Sie:
> I'm currently trying to re-enable my experimental ceph cluster that has been
> offline for a few months. Unfortunately, it appears that, out of the six
> btrfs volumes involved, only one can still be mounted, the other five are
> broken somehow. (If I ever use Ceph in production, it's probably not going
> to be on btrfs after this... I cannot recall whether or not the servers
> were properly shut down the last time, but even if not, this is a bit
> ridiculous.)

In case anybody was wondering, the machines were using kernel 3.1.1 when they 
last ran. (And still are, but I'm preparing a newer kernel.) I don't know yet 
what bug has caused this breakage and whether or not it's still present in 
newer kernels.

	Guido
