From: Guido Winkelmann <guido-ceph@thisisnotatest.de>
Subject: Re: Random data corruption in VM, possibly caused by rbd
Date: Fri, 08 Jun 2012 15:08:19 +0200
Message-ID: <3953360.A6afv81RG7@pc10>
References: <21601270.dfB0BsVfyn@pc10> <4FD10575.7010300@inktank.com> <6535521.l6e0muMKBm@pc10>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from unknownsite.de ([62.48.69.106]:56525 "EHLO hartes-hannover.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751565Ab2FHNIZ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 8 Jun 2012 09:08:25 -0400
In-Reply-To: <6535521.l6e0muMKBm@pc10>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel@vger.kernel.org

Am Freitag, 8. Juni 2012, 14:55:44 schrieb Guido Winkelmann:
> I did not change anything else in the setup. In particular, the OSDs still
> use btrfs. One of the OSD has been restarted, though. I will run another
> test with a VM without rbd caching, to make sure it wasn't by random chance
> restarting that one osd that made the real difference.

Did that now, the problem is still reproducable:

Start a VM normally -> Lots and lots of data corruption (and it seems to be 
getting worse...)
Start a VM with rbd caching -> No data corruption

	Guido
