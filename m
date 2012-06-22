From: Guido Winkelmann <guido-ceph@thisisnotatest.de>
Subject: Re: Unmountable btrfs filesystems
Date: Fri, 22 Jun 2012 16:54:45 +0200
Message-ID: <1994850.3pprtJuiTQ@pc10>
References: <4FDCD484.50706@widodh.nl> <4FDDE1DE.5030709@tuxadero.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from unknownsite.de ([62.48.69.106]:34828 "EHLO hartes-hannover.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755537Ab2FVOyr (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 22 Jun 2012 10:54:47 -0400
In-Reply-To: <4FDDE1DE.5030709@tuxadero.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: martin@tuxadero.com
Cc: Wido den Hollander <wido@widodh.nl>, ceph-devel <ceph-devel@vger.kernel.org>

Am Sonntag, 17. Juni 2012, 15:55:42 schrieb Martin Mailand:
> Hi Wido,
> until recently there were still a few bugs in btrfs which could be hit
> quite easily with ceph. The last big one was fixed here
> http://www.spinics.net/lists/ceph-devel/msg06270.html

I keep hearing things along the lines of "yes, btrfs is really really close to 
ready, we just had some really nasty bug in the last release, so you 
absolutely have to run the very latest Linux kernel" since at least Linux 3.1.

I think I will probably wait until there have been at least three major Linux 
releases with no serious btrfs issues before I start using it in production.

	Guido
