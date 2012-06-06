From: Guido Winkelmann <guido-ceph@thisisnotatest.de>
Subject: Ceph and BackupPC (was: Re: mount: 10.0.6.10:/: can't read superblock)
Date: Wed, 06 Jun 2012 15:29:05 +0200
Message-ID: <3941218.dafc4yYMCO@pc10>
References: <c99406dc-0969-47de-a75a-72a8f42eae52@mail.linserv.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from unknownsite.de ([62.48.69.106]:36474 "EHLO hartes-hannover.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753488Ab2FFN3L (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 6 Jun 2012 09:29:11 -0400
In-Reply-To: <c99406dc-0969-47de-a75a-72a8f42eae52@mail.linserv.se>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Martin Wilderoth <martin.wilderoth@linserv.se>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Am Dienstag, 5. Juni 2012, 14:33:19 schrieb Martin Wilderoth:

> I have not done any changes installed at version 0.46 upgraded earlier and
> have been testing with ceph and ceph-fuse and backuppc.

BackupPC and Ceph sounds like an interesting combination. Other than this 
hanging MDS problem, what are your experiences with that?

I'm asking because BackupPC is the only application I know of that actually 
makes heavy use of hardlinks. Ceph, as far as I've understood it, supports 
hardlinks, but works under the assumption that they're a rare and not 
performance-critical corner case, and does some optimizations that help the 
more common cases, but would probably hurt if you are using hardlinks a lot.

Regards,
	Guido
