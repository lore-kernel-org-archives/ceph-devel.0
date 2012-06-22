From: Guido Winkelmann <guido-ceph@thisisnotatest.de>
Subject: Re: Unmountable btrfs filesystems
Date: Fri, 22 Jun 2012 16:47:44 +0200
Message-ID: <32695314.Vnmc9MkfxK@pc10>
References: <4FDCD484.50706@widodh.nl> <4FDCDA83.7070708@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from unknownsite.de ([62.48.69.106]:42203 "EHLO hartes-hannover.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757428Ab2FVOrr (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 22 Jun 2012 10:47:47 -0400
In-Reply-To: <4FDCDA83.7070708@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Am Samstag, 16. Juni 2012, 14:12:03 schrieb Mark Nelson:
> btrfsck might tell you what's wrong.  Sounds like there is a
> btrfs-restore command in the dangerdonteveruse branch you could try.
> Beyond that, I guess it just really comes down to tradeoffs.

I've had similar problems in the recent past. Turns out Ceph makes heavy use 
of btrfs snapshots when running on btrfs, and btrfs-restore will not restore 
those, so it cannot be used to restore a broken osd.

	Guido
